import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:life_admin/backend/finances/budget.dart';
import 'package:life_admin/backend/finances/budget_entry.dart';
import 'package:life_admin/backend/finances/budget_entry_type.dart';
import 'package:life_admin/backend/finances/catalog.dart';
import 'package:life_admin/backend/finances/catalog_entry.dart';
import 'package:life_admin/backend/finances/catalog_entry_item.dart';
import 'package:life_admin/backend/finances/finances_manager.dart';
import 'package:life_admin/backend/finances/inflation_calculator.dart';
import 'package:life_admin/backend/finances/inflation_index.dart';
import 'package:life_admin/backend/finances/inflation_index_provider.dart';
import 'package:life_admin/backend/finances/price.dart';
import 'package:life_admin/backend/shared/datetime_manager.dart';
import 'package:life_admin/backend/shared/metadata.dart';
import 'package:life_admin/backend/shared/tag.dart';
import 'package:life_admin/backend/shared/tag_manager.dart';
import 'package:life_admin/backend/shared/tag_tree_node.dart';
import 'package:life_admin/backend/tasks/datetime_rule.dart';
import 'package:life_admin/backend/tasks/monthweek.dart';
import 'package:life_admin/backend/tasks/task.dart';
import 'package:life_admin/backend/tasks/tasks_manager.dart';
import 'package:life_admin/backend/tasks/tasks_manager_wrapped.dart';
import 'package:life_admin/backend/tasks/time_of_day.dart';
import 'package:life_admin/backend/tasks/weekday.dart';

class Db {
  static const String userDataFilePath = 'db_files/user_data.json';
  static const String inflationIndexSerieFilePath =
      'db_files/inflation_index_serie.json';

  Future<FinancesManager> createFinancesManager() async {
    final userDataJson = await _jsonFromFile(userDataFilePath);

    final inflationCalculator = await _createInflationCalculatorFromJson(
        userDataJson['inflationIndexSerieApi']);

    final rootTag = _createTagNodeFromJson(userDataJson['financesRootTag']);

    final catalog = _createCatalogFromJson(
        userDataJson['catalog'], inflationCalculator, rootTag);

    final budget =
        _createBudgetFromJson(userDataJson['budget'], catalog, rootTag);

    return FinancesManager(
      budget: budget,
      catalog: catalog,
      inflationCalculator: inflationCalculator,
      tagsTree: rootTag,
    );
  }

  Future<TasksManager> createTasksManager() async {
    final userDataJson = await _jsonFromFile(userDataFilePath);

    final rootTag = _createTagNodeFromJson(userDataJson['tasksRootTag']);
    final tasks = _createTasksFromJson(userDataJson['tasks'], rootTag);

    final tasksManagerWrapped = TasksManagerWrapped(
      tasks: tasks,
      tagsTree: rootTag,
    );

    return TasksManager(tasksManagerWrapped: tasksManagerWrapped);
  }

  List<Task> _createTasksFromJson(List<dynamic> json, TagTreeNode rootTag) {
    return json
        .map((taskJson) => _createTaskFromJson(taskJson, rootTag))
        .toList();
  }

  Task _createTaskFromJson(Map<String, dynamic> json, TagTreeNode rootTag) {
    return Task(
      metadata: _createMetadataFromJson(json['metadata'], rootTag),
      datetimeRule: _createDatetimeRuleFromJson(json['datetimeRule']),
    );
  }

  DatetimeRule _createDatetimeRuleFromJson(Map<String, dynamic> json) {
    return DatetimeRule(
      // Format: 10:00
      duration: Duration(
        hours: int.parse(json['duration'].split(':')[0]),
        minutes: int.parse(json['duration'].split(':')[1]),
      ),
      startsAt: _createTimeOfDayFromJson(json['startsAt']),
      weekdays: _createWeekdaysFromJson(json['weekdays']),
      monthweeks: _createMonthweeksFromJson(json['monthweeks']),
    );
  }

  TimeOfDay _createTimeOfDayFromJson(String value) {
    // Format: 10:00
    return TimeOfDay(
      hour: int.parse(value.split(':')[0]),
      minute: int.parse(value.split(':')[1]),
    );
  }

  List<Weekday> _createWeekdaysFromJson(List<dynamic> json) {
    return json
        .map((weekdayJson) => _createWeekdayFromJson(weekdayJson))
        .toList();
  }

  Weekday _createWeekdayFromJson(int value) {
    switch (value) {
      case 1:
        return Weekday.monday;
      case 2:
        return Weekday.tuesday;
      case 3:
        return Weekday.wednesday;
      case 4:
        return Weekday.thursday;
      case 5:
        return Weekday.friday;
      case 6:
        return Weekday.saturday;
      case 7:
        return Weekday.sunday;
      default:
        throw Exception('Unknown weekday: $value');
    }
  }
  // Weekday _createWeekdayFromJson(String value) {
  //   switch (value) {
  //     case 'monday':
  //       return Weekday.monday;
  //     case 'tuesday':
  //       return Weekday.tuesday;
  //     case 'wednesday':
  //       return Weekday.wednesday;
  //     case 'thursday':
  //       return Weekday.thursday;
  //     case 'friday':
  //       return Weekday.friday;
  //     case 'saturday':
  //       return Weekday.saturday;
  //     case 'sunday':
  //       return Weekday.sunday;
  //     default:
  //       throw Exception('Unknown weekday: $value');
  //   }
  // }

  List<Monthweek> _createMonthweeksFromJson(List<dynamic> json) {
    return json
        .map((monthweekJson) => _createMonthweekFromJson(monthweekJson))
        .toList();
  }

  Monthweek _createMonthweekFromJson(int value) {
    return value;
  }

  Budget _createBudgetFromJson(
      Map<String, dynamic> json, Catalog catalog, TagTreeNode rootTag) {
    final entriesJson = json['entries'] as List<dynamic>;

    return Budget(
      entries: entriesJson
          .map((e) => _createBudgetEntryFromJson(e, catalog, rootTag))
          .toList(),
    );
  }

  TagTreeNode _createTagNodeFromJson(Map<String, dynamic> json) {
    final tagNode = TagTreeNode(
      data: Tag(
        name: json['name'],
      ),
    );
    if (json['children'] != null) {
      for (final child in json['children'] as List<dynamic>) {
        tagNode.addChild(_createTagNodeFromJson(child));
      }
    }
    return tagNode;
  }

  BudgetEntry _createBudgetEntryFromJson(
      Map<String, dynamic> json, Catalog catalog, TagTreeNode rootTag) {
    final catalogEntryItemsJson = json['catalogEntryItems'] as List<dynamic>;

    return BudgetEntry(
      metadata: _createMetadataFromJson(json['metadata'], rootTag),
      type: _createBudgetEntryTypeFromJson(json['type']),
      catalogEntryItems: catalogEntryItemsJson
          .map((e) => _createCatalogEntryItemFromJson(e, catalog))
          .toList(),
    );
  }

  BudgetEntryType _createBudgetEntryTypeFromJson(String value) {
    switch (value) {
      case 'expense':
        return BudgetEntryType.expense;
      case 'income':
        return BudgetEntryType.income;
      default:
        throw Exception('Unknown budget entry type: $value');
    }
  }

  Catalog _createCatalogFromJson(Map<String, dynamic> json,
      InflationCalculator inflationCalculator, TagTreeNode rootTag) {
    final entriesJson = json['entries'] as List<dynamic>;
    final catalog = Catalog(
      entries: entriesJson
          .map((e) => _createCatalogEntryFromJson(e, rootTag))
          .toList(),
    );
    return catalog;
  }

  Future<InflationCalculator> _createInflationCalculatorFromJson(
      Map<String, dynamic> json) async {
    final url = json['url'];
    final token = json['token'];

    dynamic indexSerieJson = await _jsonFromFile(inflationIndexSerieFilePath)
        as Map<String, dynamic>;

    if (indexSerieJson == {} ||
        indexSerieJson['lastUpdate'] !=
            DateFormat('yyyy-MM-dd').format(DefaultDateTimeManager().now())) {
      await _updateInflationIndexSerie(url, token);
      indexSerieJson = await _jsonFromFile(inflationIndexSerieFilePath)
          as Map<String, dynamic>;
    }

    final inflationIndexSerie = _createInflationIndexSerieFromJson(
        indexSerieJson['inflationIndexSerie'] as List<dynamic>);

    inflationIndexSerie.sortBy((inflationIndex) => inflationIndex.datetime);

    final inflationIndexProvider = InflationIndexProvider(
      inflationIndexSerie: inflationIndexSerie,
    );

    return InflationCalculator(inflationIndexProvider: inflationIndexProvider);
  }

  CatalogEntry _createCatalogEntryFromJson(
      Map<String, dynamic> json, TagTreeNode rootTag) {
    return CatalogEntry(
      metadata: _createMetadataFromJson(json['metadata'], rootTag),
      price: _createPriceFromJson(json['price']),
      lastPriceUpdate: DateTime.parse(json['lastPriceUpdate']),
      adjustForInflation: json['adjustForInflation'],
    );
  }

  CatalogEntryItem _createCatalogEntryItemFromJson(
      Map<String, dynamic> json, Catalog catalog) {
    final catalogEntry = catalog.entries.firstWhere(
      (element) => element.metadata.name == json['catalogEntry'],
      orElse: () {
        throw Exception('Unknown catalog entry: ${json['catalogEntry']}');
      },
    );
    return CatalogEntryItem(
      factor: json['factor'].toDouble(),
      catalogEntry: catalogEntry,
    );
  }

  Metadata _createMetadataFromJson(
      Map<String, dynamic> json, TagTreeNode rootTag) {
    final tagsJson = json['tags'] as List<dynamic>?;

    late final List<TagTreeNode>? tags;
    if (tagsJson == null) {
      tags = null;
    } else {
      tags = tagsJson.map((tagJson) {
        final first = rootTag.firstWhere((tag) {
          return tag.name == tagJson;
        });
        return first;
      }).toList();
    }

    return Metadata(
      name: json['name'],
      description: json['description'],
      tagManager: TagManager(tags: tags),
    );
  }

  Price _createPriceFromJson(Map<String, dynamic> json) {
    return Price(
      value: json['value'].toDouble(),
      absoluteError: json['absoluteError'].toDouble(),
    );
  }

  Future<void> _updateInflationIndexSerie(String url, String token) async {
    late final Response response;
    try {
      response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'BEARER $token',
      });
    } catch (e) {
      log('Error while fetching inflation index serie: $e');
      return;
    }
    if (response.statusCode == 200) {
      log('Inflation index serie fetched successfully');
      final bodyJson = jsonDecode(response.body);
      final json = {
        'inflationIndexSerie': bodyJson['results'],
        'lastUpdate':
            DateFormat('yyyy-MM-dd').format(DefaultDateTimeManager().now()),
      };

      final jsonString = jsonEncode(json);

      await _writeInflationIndexSerieFile(jsonString);
    } else {
      log('Request failed with status: ${response.statusCode}');
      log('Response body: ${response.body}');
    }
  }

  List<InflationIndex> _createInflationIndexSerieFromJson(List<dynamic> json) {
    List<InflationIndex> inflationIndexSerie = [];
    for (dynamic inflationIndex in json) {
      DateTime datetime = DateTime.parse(inflationIndex['fecha']);
      dynamic jsonValue = inflationIndex['valor'];
      inflationIndexSerie.add(InflationIndex(
          datetime: datetime,
          value: jsonValue is int ? jsonValue.toDouble() : jsonValue));
    }
    return inflationIndexSerie;
  }

  Future<void> _writeInflationIndexSerieFile(String jsonString) async {
    // Write to file in a separate isolate
    await compute(
        (_) async => _writeDataToFile(inflationIndexSerieFilePath, jsonString),
        '');
    log('$inflationIndexSerieFilePath file written');
  }

  void _writeDataToFile(String path, String jsonString) {
    final File file = File(path);
    file.writeAsStringSync(jsonString);
  }

  Future<dynamic> _jsonFromFile(String path) async {
    final file = File(path);

    if (!await file.exists()) {
      return <String, dynamic>{};
    }

    String jsonString = await file.readAsString();
    log('File read: $path');
    return jsonDecode(jsonString);
  }
}

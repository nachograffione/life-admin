import 'dart:math';

import 'package:flutter/material.dart';
import 'package:life_admin/backend/tasks/time_of_day.dart' as tod;
import 'package:life_admin/frontend/tasks/timetable/timetable_block.dart';
import 'package:life_admin/frontend/tasks/timetable/timetable_block_data.dart';
import 'package:life_admin/frontend/tasks/timetable/timetable_description.dart';
import 'package:life_admin/frontend/tasks/timetable/timetable_hour_row.dart';

class Timetable extends StatelessWidget {
  static const double blockLeft = 45;
  static const double blockWidth = 30;

  static const double descriptionFontSize = 10;
  static const double descriptionHeight = 14;

  // Entire widget size
  final double height;
  final double width;

  // Timetable size
  late final double timetableHeight;

  // TimeOfDay range
  final tod.TimeOfDay timetableStartsAt;
  final tod.TimeOfDay timetableEndsAt;

  late final List<tod.TimeOfDay> startOfHours;
  final List<TimetableBlockData> blocks;

  Timetable({
    super.key,
    required this.blocks,
    required this.height,
    required this.width,
    this.timetableStartsAt = tod.TimeOfDay.startOfDay,
    this.timetableEndsAt = tod.TimeOfDay.endOfDay,
  }) {
    // To simplify background grid generation
    assert(timetableStartsAt.minute == 0);
    assert(timetableEndsAt.minute == 59);

    // This is for late and short blocks
    // (because they will be extended to minBlockHeight and it overflows the timetable)
    timetableHeight = height - descriptionHeight;

    startOfHours = [];
    for (int hour = timetableStartsAt.hour;
        hour <= timetableEndsAt.hour;
        hour++) {
      startOfHours.add(tod.TimeOfDay(hour: hour, minute: 0));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ...startOfHours
              .map(
                (startOfHour) => _buildHourStackItem(
                    startOfHour, TimetableHourRow(startsAt: startOfHour)),
              )
              .toList(),
          ...blocks
              .map(
                (block) => _buildBlockStackItem(
                    block.startsAt, block.duration, const TimetableBlock()),
              )
              .toList(),
          ..._buildDescriptionStackItems(blocks),
        ],
      ),
    );
  }

  Widget _buildHourStackItem(tod.TimeOfDay startsAt, Widget child) {
    return Positioned(
      top: _getTop(startsAt),
      height: _getHeight(const Duration(hours: 1)),
      left: 0,
      width: width,
      child: child,
    );
  }

  Widget _buildBlockStackItem(
      tod.TimeOfDay startsAt, Duration duration, Widget child) {
    return Positioned(
      top: _getTop(startsAt),
      height: _getHeight(duration),
      left: blockLeft,
      width: blockWidth,
      child: child,
    );
  }

  List<Widget> _buildDescriptionStackItems(List<TimetableBlockData> blocks) {
    final List<Widget> descriptionStackItems = [];
    for (var i = 0; i < blocks.length; i++) {
      final block = blocks[i];
      bool isOverlap = false;
      if (i > 0 &&
          (block.startsAt - blocks[i - 1].startsAt) <
              const Duration(minutes: 15)) {
        isOverlap = true;
      }

      descriptionStackItems.add(
        _buildDescriptionStackItem(
            block.startsAt, isOverlap, TimetableDescription(block: block)),
      );
    }

    return descriptionStackItems;
  }

  Widget _buildDescriptionStackItem(
      tod.TimeOfDay startsAt, bool isOverlap, Widget child) {
    return Positioned(
      // Add a correction and shift if applies
      top: _getTop(startsAt) - 3 + (isOverlap ? descriptionHeight : 0),
      height: descriptionHeight,
      left: blockLeft + blockWidth + 4, // Add a padding
      width: width - blockLeft - blockWidth,
      child: child,
    );
  }

  double _getTop(tod.TimeOfDay startsAt) {
    final totalMinutes =
        timetableEndsAt.minuteOfDay - timetableStartsAt.minuteOfDay;
    final offset = startsAt.minuteOfDay - timetableStartsAt.minuteOfDay;
    return (offset / totalMinutes) * timetableHeight;
  }

  double _getHeight(Duration duration, {double minHeight = 1}) {
    final totalMinutes =
        timetableEndsAt.minuteOfDay - timetableStartsAt.minuteOfDay;
    final ratio = duration.inMinutes / totalMinutes;
    return max(ratio * timetableHeight, minHeight);
  }
}

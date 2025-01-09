import 'package:flutter/material.dart';
import 'package:life_admin/frontend/app_state/app_state.dart';
import 'package:life_admin/frontend/finances/budget/budget_view.dart';
import 'package:life_admin/frontend/finances/catalog/catalog_view.dart';
import 'package:life_admin/frontend/finances/overview/overview_view.dart';
import 'package:life_admin/frontend/tasks/tasks_view.dart';
import 'package:provider/provider.dart';
import 'package:side_navigation/side_navigation.dart';

class Home extends StatelessWidget {
  static const List<Widget> _views = <Widget>[
    OverviewView(),
    BudgetView(),
    CatalogView(),
    TasksView(),
  ];

  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Life Admin'),
          ),
          body: Row(
            children: [
              SideNavigationBar(
                selectedIndex: appState.activeViewIndex,
                items: const <SideNavigationBarItem>[
                  SideNavigationBarItem(
                    icon: Icons.home,
                    label: 'Home',
                  ),
                  SideNavigationBarItem(
                    icon: Icons.attach_money,
                    label: 'Budget',
                  ),
                  SideNavigationBarItem(
                    icon: Icons.menu_book,
                    label: 'Catalog',
                  ),
                  SideNavigationBarItem(
                    icon: Icons.task,
                    label: 'Tasks',
                  ),
                  SideNavigationBarItem(
                    icon: Icons.refresh,
                    label: 'Refresh',
                  )
                ],
                onTap: (index) {
                  appState.onSetActiveViewIndex(index);
                },
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: _views.elementAt(appState.activeViewIndex),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

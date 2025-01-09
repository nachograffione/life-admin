import 'package:flutter/material.dart';
import 'package:life_admin/frontend/app_state/app_state.dart';
import 'package:life_admin/frontend/home.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppState>(
      create: (context) {
        final appState = AppState();
        appState.init(); // async
        return appState;
      },
      child: const MaterialApp(
        title: 'Life Admin',
        home: Home(),
      ),
    );
  }
}

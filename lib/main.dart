import 'package:flutter/material.dart';
import 'package:task_app/data/task_inherited.dart';
import 'package:task_app/screens/form_screen.dart';
import 'package:task_app/screens/initial_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: false,
        ),
        initialRoute: "/initialScreen",
        routes: {
          "/initialScreen": (context) => TaskInherited(
                child: const InitialScreen(),
              ),
          "/formScreen": (context) => FormScreen(
                taskContext: context,
              ),
        });
  }
}

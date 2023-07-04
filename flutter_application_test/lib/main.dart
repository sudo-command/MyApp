import 'package:flutter/material.dart';
import 'package:flutter_application_test/Screens/home_screen.dart';
import 'package:flutter_application_test/Screens/notepad/todo_list.dart';
import 'package:flutter_application_test/Screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Life',
      theme: ThemeData(
        primarySwatch: Colors.red,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          color: Colors.red, //<-- SEE HERE
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/toDoList': (context) => const TodoList(),
      },
    );
  }
}
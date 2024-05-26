import 'package:flutter/material.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LifeCounterPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class LifeCounterPage extends StatefulWidget {
  const LifeCounterPage({super.key, required this.title});


  final String title;

  @override
  State<LifeCounterPage> createState() => _LifeCounterPage();
}

class _LifeCounterPage extends State<LifeCounterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    );
  }
}

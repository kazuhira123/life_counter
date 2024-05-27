import 'package:flutter/material.dart';
import 'package:life_counter/life_event.dart';
import 'objectbox.g.dart';

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
  //ObjectBoxから値を受け取るための変数storeを定義
  //変数の型名の前に?を入れることで、変数にnullを入れられるようにしている
  Store? store;
  Box<LifeEvent>? lifeEventBox;

  Future<void> initialize() async {
    store = await openStore();
    lifeEventBox = store?.box<LifeEvent>();
    setState(() {});
  }

  //initState()ではasync awaitが使用できないので、async awaitを使った関数を作成し、initState内で呼び出している
  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

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

  //LifeEventクラスの型を持つBox型の変数lifeEventBoxを定義
  Box<LifeEvent>? lifeEventBox;

  //Boxの中身を入れるリストを定義
  List<LifeEvent> lifeEvents = [];

  Future<void> initialize() async {
    store = await openStore();

    //Boxの中にStoreの値を入れる
    lifeEventBox = store?.box<LifeEvent>();

    //Boxの値をListに入れる
    //??キーワードによって、lifeEventBoxがnullの際は、getAllを実行する代わりに空のリストが代入される
    lifeEvents = lifeEventBox?.getAll() ?? [];
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('人生カウンター'),
      ),
      body: ListView.builder(
          itemCount: lifeEvents.length,
          itemBuilder: (context, Index) {
            final lifeEvent = lifeEvents[Index];
            //ListViewの戻り値に取得したlifeEventのtitleを代入
            return Text(lifeEvent.title);
          }),
    );
  }
}


class AddLifeEventPage extends StatefulWidget {
  const AddLifeEventPage({super.key});

  @override
  State<AddLifeEventPage> createState() => _AddLifeEventPageState();
}

class _AddLifeEventPageState extends State<AddLifeEventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ライフイベント追加'),
      ),
      body: TextFormField(),
    );
  }
}
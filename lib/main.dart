//import 'dart:js_interop';

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

    fetchLifeEvents();
  }

  //lifeEventsを取得する処理を関数にまとめる
  void fetchLifeEvents() {
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
      floatingActionButton: FloatingActionButton(
        //追加用のプラスアイコンを子ウィジェットに追加
        child: const Icon(Icons.add),
        onPressed: () async {
          //Navigatorによって新しい画面をスタックにプッシュ(画面遷移)している
          //LifeEvent型のnewLifeEventを定義し、popで帰ってきた値を受け取っている
          final newLifeEvent = await Navigator.of(context).push<LifeEvent>(
            ///新しいページに遷移する為のルートを指定する為の処理
            MaterialPageRoute(
              builder: (context) {
                return const AddLifeEventPage();
              },
            ),
          );
          //newLifeEventがnullで無ければ、取得した値をputしている
          if (newLifeEvent != null) {
            //BoxのputメソッドにnewLifeEventのインスタンスを渡している
            //putメソッドによって、取得した値をデータベースに保存している
            lifeEventBox?.put(newLifeEvent);

            fetchLifeEvents();
          }
        },
      ),
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
      body: TextFormField(
        onFieldSubmitted: (text) {
          //lifeEventに代入する形で、LifeEventクラスのインスタンスを生成
          final lifeEvent = LifeEvent(title: text, count: 0);
          //popメソッドによって、前のページにlifeEventインスタンスを渡している
          Navigator.of(context).pop(lifeEvent);
        },
      ),
    );
  }
}

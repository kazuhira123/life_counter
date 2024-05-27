import 'package:objectbox/objectbox.dart';

//エンティティクラスを定義(エンティティはObjectBoxによって管理されるデータモデル)
@Entity()
class LifeEvent {
  LifeEvent({
    required this.title,
    required this.count,
  });

  int id = 0;

//イベント名用の引数
  String title;

  //イベント回数用の引数
  int count;
}

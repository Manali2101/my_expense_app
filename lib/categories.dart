import 'package:realm/realm.dart';
part 'categories.g.dart';

@RealmModel()
class _Category {
  @PrimaryKey()
  late ObjectId id;

  late String name;

}

import 'package:realm/realm.dart';
part 'expense.g.dart';

@RealmModel()
class _Expense {
  @PrimaryKey()
  late ObjectId id;

  late String date; // make it dateTime
  late String category;
  late String? description;
  late int? amount;
}

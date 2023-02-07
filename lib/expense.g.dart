// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Expense extends _Expense with RealmEntity, RealmObjectBase, RealmObject {
  Expense(
    ObjectId id,
    String date,
    String category, {
    String? description,
    int? amount,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'date', date);
    RealmObjectBase.set(this, 'category', category);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'amount', amount);
  }

  Expense._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get date => RealmObjectBase.get<String>(this, 'date') as String;
  @override
  set date(String value) => RealmObjectBase.set(this, 'date', value);

  @override
  String get category =>
      RealmObjectBase.get<String>(this, 'category') as String;
  @override
  set category(String value) => RealmObjectBase.set(this, 'category', value);

  @override
  String? get description =>
      RealmObjectBase.get<String>(this, 'description') as String?;
  @override
  set description(String? value) =>
      RealmObjectBase.set(this, 'description', value);

  @override
  int? get amount => RealmObjectBase.get<int>(this, 'amount') as int?;
  @override
  set amount(int? value) => RealmObjectBase.set(this, 'amount', value);

  @override
  Stream<RealmObjectChanges<Expense>> get changes =>
      RealmObjectBase.getChanges<Expense>(this);

  @override
  Expense freeze() => RealmObjectBase.freezeObject<Expense>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Expense._);
    return const SchemaObject(ObjectType.realmObject, Expense, 'Expense', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('date', RealmPropertyType.string),
      SchemaProperty('category', RealmPropertyType.string),
      SchemaProperty('description', RealmPropertyType.string, optional: true),
      SchemaProperty('amount', RealmPropertyType.int, optional: true),
    ]);
  }
}

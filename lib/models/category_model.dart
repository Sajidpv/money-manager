import 'package:hive_flutter/adapters.dart';
part 'category_model.g.dart';

@HiveType(typeId: 1)
enum CategoryType {
  @HiveField(0)
  income,
  @HiveField(1)
  expense,
}

@HiveType(typeId: 0)
class CategoryModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final bool isDeleted;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final CategoryType type;

  CategoryModel({
    required this.type,
    required this.id,
    this.isDeleted = false,
    required this.name,
  });
}

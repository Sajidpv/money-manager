import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management_app/models/category_model.dart';

const CATEGORY_DB = 'category-database';

abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getCategory();
  Future<void> insertCategory(CategoryModel value);
  Future<void> deleteCategory(int categoryId);
}

class CategoryDB implements CategoryDbFunctions {
  CategoryDB._mydb();
  static CategoryDB instance = CategoryDB._mydb();
  factory CategoryDB() {
    return instance;
  }

  ValueNotifier<List<CategoryModel>> incomeListListener = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseListListener = ValueNotifier([]);

  @override
  Future<List<CategoryModel>> getCategory() async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB);
    return _categoryDB.values.toList();
  }

  @override
  Future<void> insertCategory(CategoryModel value) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB);
    await _categoryDB.add(value);
    refreshUI();
  }

  Future<void> refreshUI() async {
    final _allCategory = await getCategory();
    expenseListListener.value.clear();
    incomeListListener.value.clear();
    await Future.forEach(_allCategory, (CategoryModel category) {
      if (category.type == CategoryType.income) {
        incomeListListener.value.add(category);
      } else {
        expenseListListener.value.add(category);
      }
    });
    expenseListListener.notifyListeners();
    incomeListListener.notifyListeners();
  }

  @override
  Future<void> deleteCategory(int categoryId) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB);
    _categoryDB.delete(categoryId);
    refreshUI();
  }
}

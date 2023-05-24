import 'package:flutter/material.dart';
import 'package:money_management_app/db/category_db.dart';
import 'package:money_management_app/models/category_model.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier =
    ValueNotifier(CategoryType.income);

Future<void> addCategory(BuildContext context) async {
  final _categoryNameController = TextEditingController();
  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: const Text('Add Category'),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _categoryNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Category Name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: const [
                  RadioButtonWidget(title: 'INCOME', type: CategoryType.income),
                  RadioButtonWidget(
                      title: 'EXPENSE', type: CategoryType.expense),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  final _name = _categoryNameController.text;
                  final _type = selectedCategoryNotifier.value;
                  CategoryModel _data = CategoryModel(
                      type: _type,
                      id: DateTime.now().millisecondsSinceEpoch,
                      name: _name);
                  CategoryDB().insertCategory(_data);
                  Navigator.pop(ctx);
                },
                child: const Text('Add'),
              ),
            ),
          ],
        );
      });
}

class RadioButtonWidget extends StatelessWidget {
  final String title;
  final CategoryType type;
  const RadioButtonWidget({Key? key, required this.title, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: selectedCategoryNotifier,
            builder: (BuildContext ctx, CategoryType newCategory, Widget? _) {
              return Radio<CategoryType>(
                  value: type,
                  groupValue: newCategory,
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    selectedCategoryNotifier.value = value;
                    selectedCategoryNotifier.notifyListeners();
                  });
            }),
        Text(title),
      ],
    );
  }
}

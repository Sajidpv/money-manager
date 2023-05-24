import 'package:flutter/material.dart';
import 'package:money_management_app/db/category_db.dart';
import 'package:money_management_app/models/category_model.dart';

class IncomList extends StatelessWidget {
  const IncomList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDB().incomeListListener,
        builder: (BuildContext ctx, List<CategoryModel> newList, Widget? _) {
          return ListView.separated(
              padding: const EdgeInsets.all(10),
              itemBuilder: (ctx, index) {
                final card = newList[index];
                return Card(
                  shadowColor: Colors.grey,
                  child: ListTile(
                    title: Text(card.name),
                    trailing: IconButton(
                        onPressed: () {
                          CategoryDB().deleteCategory(card.id);
                        },
                        icon: const Icon(Icons.delete)),
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return const SizedBox(
                  height: 5,
                );
              },
              itemCount: newList.length);
        });
  }
}

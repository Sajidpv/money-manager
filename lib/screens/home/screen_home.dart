import 'package:flutter/material.dart';
import 'package:money_management_app/db/category_db.dart';
import 'package:money_management_app/models/category_model.dart';
import 'package:money_management_app/screens/category/screen_category.dart';
import 'package:money_management_app/screens/category/widgets/category_add_poup.dart';
import 'package:money_management_app/screens/home/widget_bottum_navigation_bar.dart';
import 'package:money_management_app/screens/transactions/add_transaction.dart';
import 'package:money_management_app/screens/transactions/screen_transaction.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static ValueNotifier<int> selectedIndex = ValueNotifier(0);
  final _pages = const [TransactionScreen(), CategoryScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('MONEY MANAGER'),
      ),
      body: SafeArea(
          child: ValueListenableBuilder(
        valueListenable: selectedIndex,
        builder: (BuildContext ctx, int updatedIndex, Widget? _) {
          return _pages[updatedIndex];
        },
      )),
      bottomNavigationBar: const BottumNavigationWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedIndex.value == 0) {
            print('add transaction');
            Navigator.of(context).pushNamed(ScreenAddTransaction.routeName);
          } else {
            print('add category');
            addCategory(context);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

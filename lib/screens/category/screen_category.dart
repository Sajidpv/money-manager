import 'package:flutter/material.dart';
import 'package:money_management_app/db/category_db.dart';
import 'package:money_management_app/screens/category/widgets/expense_list.dart';
import 'package:money_management_app/screens/category/widgets/income_list.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    CategoryDB().refreshUI();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(
              text: 'INCOME',
            ),
            Tab(
              text: 'EXPENSES',
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            children: const [IncomList(), ExpenseList()],
            controller: _tabController,
          ),
        ),
      ],
    );
  }
}

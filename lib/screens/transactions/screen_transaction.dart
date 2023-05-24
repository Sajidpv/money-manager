import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_management_app/db/category_db.dart';
import 'package:money_management_app/db/transaction_db.dart';
import 'package:money_management_app/models/category_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../models/transaction_model.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransactionDb.instance.refresh();
    CategoryDB.instance.refreshUI();
    return ValueListenableBuilder(
      valueListenable: TransactionDb.instance.transactionListNotifier,
      builder: (BuildContext ctx, List<TransactionModel> newList, Widget? _) {
        return ListView.separated(
            padding: const EdgeInsets.all(10),
            itemBuilder: (ctx, index) {
              final _value = newList[index];
              return Slidable(
                key: Key(_value.transactionId!),

                startActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (ctx) {
                        print(_value.transactionId!);
                        TransactionDb.instance.deleteTransaction(_value.transactionId!);
                      },
                      icon: Icons.delete,
                      label: 'Delete ',
                    ),
                  ],
                ),
                child: Card(
                  shadowColor: Colors.grey.shade100,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 50,
                      backgroundColor: _value.type == CategoryType.income
                          ? Colors.green
                          : Colors.red,
                      child: Text(parsedDate(_value.date)),
                    ),
                    title: Text('RS ${_value.amount}'),
                    subtitle: Text(_value.purose),
                  ),
                ),
              );
            },
            separatorBuilder: (ctx, index) {
              return const SizedBox(
                height: 3,
              );
            },
            itemCount: newList.length);
      },
    );
  }

  String parsedDate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _splitDate = _date.split(' ');
    return '${_splitDate.first}\n${_splitDate.last}';
  }
}

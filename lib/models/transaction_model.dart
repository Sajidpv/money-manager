import 'package:hive_flutter/adapters.dart';
import 'package:money_management_app/models/category_model.dart';

part 'transaction_model.g.dart';

@HiveType(typeId: 2)
class TransactionModel {
  @HiveField(0)
  final String purose;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final CategoryType type;
  @HiveField(4)
  final CategoryModel category;
  @HiveField(5)
  String? transactionId;

  TransactionModel(
      {required this.purose,
      required this.amount,
      required this.date,
      required this.type,
      required this.category}) {
    transactionId = DateTime.now().millisecondsSinceEpoch.toString();
  }
}

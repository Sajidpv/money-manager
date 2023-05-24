import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management_app/models/transaction_model.dart';

const TRANSACTION_DB = "transaction-db";

abstract class TransactionDbFunctions {
  Future<void> addTransactionDb(TransactionModel obj);
  Future<List<TransactionModel>> getTransaction();
  Future<void> deleteTransaction(String id);
}

class TransactionDb implements TransactionDbFunctions {
  TransactionDb._internal();

  static TransactionDb instance = TransactionDb._internal();

  factory TransactionDb() {
    return instance;
  }

  ValueNotifier<List<TransactionModel>> transactionListNotifier =
      ValueNotifier([]);

  @override
  Future<void> addTransactionDb(TransactionModel obj) async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB);
    _db.put(obj.transactionId, obj);
  }

  Future<void> refresh() async {
    final _list = await getTransaction();
    _list.sort((first, second) => second.date.compareTo(first.date));
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(_list);
    transactionListNotifier.notifyListeners();
  }

  @override
  Future<List<TransactionModel>> getTransaction() async {
    final _transactionDb = await Hive.openBox<TransactionModel>(TRANSACTION_DB);
    return _transactionDb.values.toList();
  }

  @override
  Future<void> deleteTransaction(String id) async {
    final _transactionDb = await Hive.openBox<TransactionModel>(TRANSACTION_DB);
    await _transactionDb.delete(id);
    refresh();
  }
}

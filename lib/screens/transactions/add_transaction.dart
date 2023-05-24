import 'package:flutter/material.dart';
import 'package:money_management_app/db/category_db.dart';
import 'package:money_management_app/db/transaction_db.dart';
import 'package:money_management_app/models/category_model.dart';
import 'package:money_management_app/models/transaction_model.dart';

class ScreenAddTransaction extends StatefulWidget {
  static const routeName = 'add-transaction';
  const ScreenAddTransaction({Key? key}) : super(key: key);

  @override
  State<ScreenAddTransaction> createState() => _ScreenAddTransactionState();
}

class _ScreenAddTransactionState extends State<ScreenAddTransaction> {
  final _amountTextEditingController=TextEditingController();
  final _purposeTextEditingController=TextEditingController();
  DateTime? _selectedDate;
  CategoryType? _selectedCategoryType = CategoryType.income;
  CategoryModel? _selectedCategoryModel;
  String? _categoryID;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        //purpose
        TextFormField(
          controller: _purposeTextEditingController,
          decoration: const InputDecoration(hintText: 'Purpose'),
        ),

        //amount
        TextFormField(
          controller: _amountTextEditingController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: 'amount'),
        ),

        //calender
        TextButton.icon(
            onPressed: () async {
              final _selectedDateTemp = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now().subtract(const Duration(days: 30)),
                lastDate: DateTime.now(),
              );
              setState(() {
                _selectedDate = _selectedDateTemp;
              });
            },
            icon: const Icon(Icons.calendar_today),
            label: Text(_selectedDate == null
                ? 'Select Date'
                : _selectedDate.toString())),

        //type
        Row(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Radio(
                value: CategoryType.income,
                groupValue: _selectedCategoryType,
                onChanged: (newValue) {
                  setState(() {
                    _selectedCategoryType = CategoryType.income;
                    _categoryID = null;
                  });
                }),
            const Text('Income'),
            Radio(
                value: CategoryType.expense,
                groupValue: _selectedCategoryType,
                onChanged: (newValue) {
                  setState(() {
                    _selectedCategoryType = CategoryType.expense;
                    _categoryID = null;
                  });
                }),
            const Text('Expense'),
          ],
        ),

        //category
        DropdownButton(
          hint: const Text('Select Category'),
          value: _categoryID,
          items: (_selectedCategoryType == CategoryType.income
                  ? CategoryDB().incomeListListener
                  : CategoryDB().expenseListListener)
              .value
              .map((e) {
            return DropdownMenuItem(
              value: e.id,
              child: Text(e.name),
              onTap: (){
                _selectedCategoryModel=e;
              },
            );
          }).toList(),
          onChanged: (selectedValue) {
            print(selectedValue);
            setState(() {
              //_categoryID = selectedValu;
            });
          },
        ),

        //submit
        ElevatedButton(onPressed: () {
          addTransaction();
        }, child: const Text('Submit')),
      ]),
    )));
  }
  Future<void> addTransaction()async{
    final _purposeText=_purposeTextEditingController.text;
    final _amountText=_amountTextEditingController.text;
    if(_selectedDate==null){
      return;
    }
    if(_selectedCategoryType==null){
      return;
    }
    if(_selectedCategoryModel==null){
      return;
    }
    final parsedAmount= double.tryParse(_amountText);
    if(parsedAmount==null){
      return;
    }

    final _model=TransactionModel(
      purose: _purposeText,
      amount: parsedAmount,
      date: _selectedDate!,
      type: _selectedCategoryType!,
      category: _selectedCategoryModel!,
    );
    TransactionDb.instance.addTransactionDb(_model);
    print("submited");

    TransactionDb.instance.refresh();
    Navigator.pop(context);
  }
}

import 'package:flutter/material.dart';
import 'package:money_management_app/screens/home/Screen_Home.dart';

class BottumNavigationWidget extends StatefulWidget {
  const BottumNavigationWidget({Key? key}) : super(key: key);

  @override
  State<BottumNavigationWidget> createState() => _BottumNavigationWidgetState();
}

class _BottumNavigationWidgetState extends State<BottumNavigationWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: HomeScreen.selectedIndex,
        builder: (BuildContext ctx, int updatedIndex, Widget? _) {
          return BottomNavigationBar(
            currentIndex: updatedIndex,
            onTap: (newIndex) {
              HomeScreen.selectedIndex.value = newIndex;
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'Transactions'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category), label: 'Category'),
            ],
          );
        });
  }
}

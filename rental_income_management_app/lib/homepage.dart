import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/home/bottomnavbar.dart';
import 'screens/home/screenhome.dart';
import 'screens/money/screenmoney.dart';
import 'screens/people/screens/screenpeople.dart';
import 'screens/plusbutton/screenplusbutton.dart';
import 'screens/property/screen/screenproperty.dart';

class SelectedIndexProvider extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final selectedIndexProvider = Provider.of<SelectedIndexProvider>(context);

    final pages = [
      ScreenHome(),
      const ScreenMoney(),
      const ScreenplusButton(),
      const ScreenPeople(),
      ScreenProperty(),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const BottomNavBar(),
      body: SafeArea(
        child: pages[selectedIndexProvider.selectedIndex],
      ),
    );
  }
}

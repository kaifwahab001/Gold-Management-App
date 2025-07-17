import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_app/constants/colors.dart';
import 'package:gold_app/view/user/client/clientviewscreen.dart';

import '../supplier/inventory.dart';
import '../supplier/settingscreen.dart';


class ClientBottomNavBar extends StatefulWidget {
  const ClientBottomNavBar({super.key});

  @override
  State<ClientBottomNavBar> createState() => _ClientBottomNavBarState();
}

class _ClientBottomNavBarState extends State<ClientBottomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Clientviewscreen(),
    InventoryScreen(),
    Settingscreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(bottom: false, top: false, child: _pages[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Appcolor.mainColor,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(
          color: Appcolor.mainColor,
          fontWeight: FontWeight.bold,
          fontSize: 15
        ),
        unselectedLabelStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 14),
        backgroundColor: Colors.grey.shade200,
        elevation: 3,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'dashboard'.tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            activeIcon: Icon(Icons.bar_chart_outlined),
            label: 'gold'.tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'setting-scr'.tr,
          ),
        ],
      ),
    );
  }
}

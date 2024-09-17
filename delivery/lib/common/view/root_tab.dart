import 'package:delivery/common/const/colors.dart';
import 'package:delivery/common/layout/default_layout.dart';
import 'package:flutter/material.dart';

class RootTab extends StatefulWidget {
  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> {
  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '유현 딜리버리',
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[100],
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {
            tabIndex = value;
          });
        },
        currentIndex: tabIndex,
        items: const [
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: '홈',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.fastfood),
            icon: Icon(Icons.fastfood_outlined),
            label: '음식',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.receipt_long),
            icon: Icon(Icons.receipt_long_outlined),
            label: '주문',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outlined),
            label: '프로필',
          ),
        ],
      ),
      child: const Center(
        child: Text('Root Screen'),
      ),
    );
  }
}

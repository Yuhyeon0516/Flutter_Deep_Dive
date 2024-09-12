import 'package:flutter/material.dart';
import 'package:tabbar/const/tabs.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen>
    with TickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: Tabs.length, vsync: this);

    tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bottom Navigation Bar Screen"),
      ),
      body: TabBarView(
        controller: tabController,
        children: Tabs.map(
          (e) => Center(
            child: Icon(e.icon),
          ),
        ).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          tabController.animateTo(index);
        },
        currentIndex: tabController.index,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(
          color: Colors.red,
        ),
        // 선택된 tab의 이름을 보여라
        showSelectedLabels: true,
        // 선택되지 않은 tab의 이름을 보여라
        showUnselectedLabels: true,
        // bottom navigation bar의 type
        // fixed는 크기 고정, shifting은 확대되면서 shift
        type: BottomNavigationBarType.shifting,
        items: Tabs.map(
          (e) => BottomNavigationBarItem(
            icon: Icon(e.icon),
            label: e.label,
          ),
        ).toList(),
      ),
    );
  }
}

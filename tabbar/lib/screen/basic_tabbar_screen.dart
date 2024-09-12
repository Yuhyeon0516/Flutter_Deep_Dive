import 'package:flutter/material.dart';
import 'package:tabbar/const/tabs.dart';

class BasicTabbarScreen extends StatelessWidget {
  const BasicTabbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: Tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Basic Tabbar Screen"),
          // appbar의 하단에 생성됨
          bottom: TabBar(
            tabs: Tabs.map(
              (e) => Tab(
                icon: Icon(e.icon),
                child: Text(e.label),
              ),
            ).toList(),
          ),
        ),
        body: Container(),
      ),
    );
  }
}

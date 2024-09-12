import 'package:flutter/material.dart';
import 'package:tabbar/const/tabs.dart';

class TabbarUsingControllerScreen extends StatefulWidget {
  const TabbarUsingControllerScreen({super.key});

  @override
  State<TabbarUsingControllerScreen> createState() =>
      _TabbarUsingControllerScreenState();
}

// Tabbar를 controller와 사용하려면 TickerProviderStateMixin을 mixin해야함
class _TabbarUsingControllerScreenState
    extends State<TabbarUsingControllerScreen> with TickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(
      length: Tabs.length,
      vsync: this,
    );

    // tabController의 값이 변경될떄 불림
    tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tabbar Using Controller"),
        bottom: TabBar(
          controller: tabController,
          tabs: Tabs.map(
            (e) => Tab(
              icon: Icon(e.icon),
              child: Text(e.label),
            ),
          ).toList(),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: Tabs.map(
          (e) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(e.icon),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (tabController.index != 0) ...[
                    ElevatedButton(
                      onPressed: () {
                        tabController.animateTo(tabController.index - 1);
                      },
                      child: const Text("이전"),
                    ),
                    const SizedBox(
                      width: 16,
                    )
                  ],
                  if (tabController.index != Tabs.length - 1)
                    ElevatedButton(
                      onPressed: () {
                        tabController.animateTo(tabController.index + 1);
                      },
                      child: const Text("다음"),
                    ),
                ],
              )
            ],
          ),
        ).toList(),
      ),
    );
  }
}

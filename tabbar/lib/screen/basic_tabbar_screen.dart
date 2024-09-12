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
          // appbar의 하단에 생성되어 이름이 bottom
          // PreferredSize를 이용하여 TabBar의 size도 정할수있고 custom도 가능함
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TabBar(
                  // tab의 indicator색을 설정
                  indicatorColor: Colors.red,
                  // tab의 사이즈로 맞춤 기본은 label
                  indicatorSize: TabBarIndicatorSize.tab,
                  // indicator의 weight
                  indicatorWeight: 4,
                  // tab이 길어졌을때 scroll이 가능하게
                  isScrollable: true,
                  // icon과 child의 색이 바뀜
                  labelColor: Colors.red,
                  // 선택되지 않은 tab의 색을 설정
                  unselectedLabelColor: Colors.blue,
                  // label의 style
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                  // 선택되지 않은 tab의 label style
                  unselectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.w100,
                  ),
                  tabs: Tabs.map(
                    (e) => Tab(
                      icon: Icon(e.icon),
                      child: Text(e.label),
                    ),
                  ).toList(),
                ),
              ],
            ),
          ),
        ),
        // TabBarView를 이용하여 index별 화면 정의 가능
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: Tabs.map(
            (e) => Center(
              child: Icon(e.icon),
            ),
          ).toList(),
        ),
      ),
    );
  }
}

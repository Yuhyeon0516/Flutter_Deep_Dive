import 'package:flutter/material.dart';
import 'package:scrollable/const/colors.dart';
import 'package:scrollable/layout/main_layout.dart';

class ListViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);
  ListViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: "ListViewScreen",
      body: renderListViewSeparator(),
    );
  }

  // 1. 기본 랜더링으로 모든 위젯을 한번에 랜더링
  Widget renderListView() {
    return ListView(
      children: numbers
          .map(
            (e) => renderContainer(
                color: rainbowColors[e % rainbowColors.length], index: e),
          )
          .toList(),
    );
  }

  // 2. builder로 랜더링 시 화면에 보이는것들 + 보이기 직전인 위젯만 랜더링됨(퍼포먼스 좋음)
  Widget renderListViewBuilder() {
    return ListView.builder(
      itemCount: numbers.length,
      itemBuilder: (context, index) {
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length],
          index: index,
        );
      },
    );
  }

  // 3. item 사이에 separator를 builder할 수 있음. builder와 동일하게 화면에 보이는것들만 랜더링됨
  Widget renderListViewSeparator() {
    return ListView.separated(
      itemCount: numbers.length,
      itemBuilder: (context, index) {
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length],
          index: index,
        );
      },
      separatorBuilder: (context, index) {
        // 5개마다 separator를 넣어주기
        if (index % 5 == 0) {
          return renderContainer(
            color: Colors.black,
            index: index,
            height: 50,
          );
        }

        return Container();
      },
    );
  }

  Widget renderContainer(
      {required Color color, required int index, double? height}) {
    print(index);

    return Container(
      height: height ?? 300,
      color: color,
      child: Center(
        child: Text(
          index.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}

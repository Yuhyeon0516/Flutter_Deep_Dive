import 'package:flutter/material.dart';
import 'package:scrollable/const/colors.dart';
import 'package:scrollable/layout/main_layout.dart';

class GridViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);
  GridViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: "GridViewScreen",
      body: renderGridViewBuilder(),
    );
  }

  // 1. 기본적인 그리드뷰로 전체 위젯이 한번에 랜더링되며 crossAxis에 몇개의 위젯을 넣을건지 정할 수 있음
  Widget renderGridViewCount() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: numbers
          .map(
            (e) => renderContainer(
              color: rainbowColors[e % rainbowColors.length],
              index: e,
            ),
          )
          .toList(),
    );
  }

  // 2. builder를 이용하여 화면에 보이는 것만 랜더링하고 gridDelegate를 이용하여 crossAxis를 control함
  Widget renderGridViewBuilder() {
    return GridView.builder(
      // crossAxis에 몇개의 위젯을 배치할것이냐
      // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //   crossAxisCount: 2,
      //   crossAxisSpacing: 12,
      //   mainAxisSpacing: 12,
      // ),
      //
      // 위젯의 crossAxis 최대 크기를 설정
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 100,
      ),
      itemCount: numbers.length,
      itemBuilder: (context, index) {
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length],
          index: index,
        );
      },
    );
  }

  Widget renderContainer({
    required Color color,
    required int index,
    double? height,
  }) {
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

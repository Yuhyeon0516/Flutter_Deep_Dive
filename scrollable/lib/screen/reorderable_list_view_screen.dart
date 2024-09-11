import 'package:flutter/material.dart';
import 'package:scrollable/const/colors.dart';
import 'package:scrollable/layout/main_layout.dart';

class ReorderableListViewScreen extends StatefulWidget {
  const ReorderableListViewScreen({super.key});

  @override
  State<ReorderableListViewScreen> createState() =>
      _ReorderableListViewScreenState();
}

class _ReorderableListViewScreenState extends State<ReorderableListViewScreen> {
  final List<int> numbers = List.generate(100, (index) => index);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: "ReorderableListViewScreen",
      body: renderReorderableListViewBuilder(),
    );
  }

  // 1. 기본 랜더링으로 모든 위젯이 모두 랜더링됨.
  Widget renderReorderableListView() {
    return ReorderableListView(
      children: numbers
          .map(
            (e) => renderContainer(
              color: rainbowColors[e % rainbowColors.length],
              index: e,
            ),
          )
          .toList(),
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          // [red, orange, yellow]
          // index 0 1 2
          // red를 yellow 다음으로 옮기고싶다.
          // red : 0 oldIndex -> 3 newIndex
          // [orange, yellow, red]
          //
          // [red, orange, yellow]
          // yellow를 맨 앞으로 옮기고싶다.
          // yellow : 2 oldIndex -> 0 newIndex
          // [yellow, red, orange]
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }

          final item = numbers.removeAt(oldIndex);
          numbers.insert(newIndex, item);
        });
      },
    );
  }

  // 2. builder를 이용하여 보이는것만 랜더링.
  Widget renderReorderableListViewBuilder() {
    return ReorderableListView.builder(
      itemBuilder: (context, index) {
        return renderContainer(
          color: rainbowColors[numbers[index] % rainbowColors.length],
          index: numbers[index],
        );
      },
      itemCount: numbers.length,
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }

          final item = numbers.removeAt(oldIndex);
          numbers.insert(newIndex, item);
        });
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
      key: Key(index.toString()),
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

import 'package:flutter/material.dart';
import 'package:scrollable/const/colors.dart';
import 'package:scrollable/layout/main_layout.dart';

class SingleChildScrollViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);
  SingleChildScrollViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: "SingleChildScrollView",
      body: renderSinglePerformance(),
    );
  }

  // 1. 기본 랜더링
  Widget renderSingle() {
    return SingleChildScrollView(
      child: Column(
        children: rainbowColors
            .map(
              (e) => renderContainer(color: e),
            )
            .toList(),
      ),
    );
  }

  // 2. pysics(스크롤의 옵션)
  Widget renderSinglePysics() {
    return SingleChildScrollView(
      // 스크롤이 안되게 설정
      // physics: const NeverScrollableScrollPhysics(),
      // 화면을 넘어가지 않더라도 스크롤이 가능하게 설정
      // physics: const AlwaysScrollableScrollPhysics(),
      // ios의 기본셋팅처럼 화면이 튕기게 설정
      // physics: const BouncingScrollPhysics(),
      // android의 기본셋팅처럼 화면이 걸리게 설정
      physics: const ClampingScrollPhysics(),
      child: Column(
        children: rainbowColors
            .map(
              (e) => renderContainer(color: e),
            )
            .toList(),
      ),
    );
  }

  // 3. clipBehavior(위젯이 잘리지 않게)
  Widget renderSingleClipBehavior() {
    return SingleChildScrollView(
      // 스크롤을 해도 화면이 잘리지 않음
      clipBehavior: Clip.none,
      child: Column(
        children: [
          renderContainer(
            color: Colors.black,
          )
        ],
      ),
    );
  }

  // 4. SingleChildScrollView 퍼포먼스
  // SingleChildScrollView는 화면에 보이지 않아도 전부 랜더링하며 메모리에 올리기 때문에 성능에 저하가 발생할 수 있음
  Widget renderSinglePerformance() {
    return SingleChildScrollView(
      child: Column(
        children: numbers
            .map(
              (e) => renderContainer(
                color: rainbowColors[e % rainbowColors.length],
                index: e,
              ),
            )
            .toList(),
      ),
    );
  }

  Widget renderContainer({required Color color, int? index}) {
    if (index != null) {
      print(index);
    }

    return Container(
      height: 300,
      color: color,
    );
  }
}

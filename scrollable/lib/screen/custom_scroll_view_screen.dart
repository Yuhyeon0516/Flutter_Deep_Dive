import 'package:flutter/material.dart';
import 'package:scrollable/const/colors.dart';

class _SliverFixedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double maxHeight;
  final double minHeight;

  _SliverFixedHeaderDelegate(
      {required this.child, required this.maxHeight, required this.minHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: child,
    );
  }

  // 최대 높이
  @override
  double get maxExtent => maxHeight;

  // 최소 높이
  @override
  double get minExtent => minHeight;

  //
  @override
  // covariant: 상속된 클래스도 사용가능
  // oldDelegate: build가 실행이 됐을때 이전 delegate
  // shouldRebuild: 새로 build를 할지 말지 선택하는 함수
  // bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
  bool shouldRebuild(_SliverFixedHeaderDelegate oldDelegate) {
    return oldDelegate.maxHeight != maxHeight ||
        oldDelegate.minHeight != minHeight ||
        oldDelegate.child != child;
  }
}

class CustomScrollViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(10, (index) => index);
  CustomScrollViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          renderSliverAppBar(),
          renderHeader(),
          renderSliverList(),
          renderHeader(),
          renderSliverGrid(),
        ],
      ),
    );
  }

  SliverPersistentHeader renderHeader() {
    return SliverPersistentHeader(
      // 상단에 고정됨.
      pinned: true,
      delegate: _SliverFixedHeaderDelegate(
        child: Container(
          color: Colors.blue,
          child: const Center(
            child: Text("신기하지!"),
          ),
        ),
        maxHeight: 150,
        minHeight: 75,
      ),
    );
  }

  SliverAppBar renderSliverAppBar() {
    return SliverAppBar(
      // 위로 살짝 스크롤하면 AppBar가 보이는 형태
      floating: true, // 기본값 false
      // 스크롤해도 위에 AppBar가 고정되는 형태
      pinned: false, // 기본값 false
      // snap 하는 방향으로 AppBar가 사라지거나 나타남
      // floating이 true여야 동작함
      snap: true,
      // AppBar가 List를 따라감
      // pysics가 Bounce일때 사용 가능
      stretch: true, // 기본값 false
      // AppBar의 최대 Height
      expandedHeight: 200,
      // AppBar의 최소 Height
      collapsedHeight: 150,
      // AppBar가 늘어나 있을때의 디자인
      flexibleSpace: FlexibleSpaceBar(
        background: Image.asset(
          "asset/img/image_1.jpeg",
          fit: BoxFit.cover,
        ),
        title: const Text("FlexibleSpaceBar"),
      ),
      title: const Text("CustomScrollViewScreen"),
    );
  }

  SliverGrid renderSliverGridBuilder() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return renderContainer(
            color: rainbowColors[index % rainbowColors.length],
            index: index,
          );
        },
        childCount: numbers.length,
      ),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 100,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
    );
  }

  SliverGrid renderSliverGrid() {
    return SliverGrid(
      delegate: SliverChildListDelegate(
        numbers
            .map(
              (e) => renderContainer(
                  color: rainbowColors[e % rainbowColors.length], index: e),
            )
            .toList(),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
    );
  }

  SliverList renderSliverBuilderList() {
    return SliverList(
      // ListView.builder와 동일하게 동작함
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return renderContainer(
            color: rainbowColors[index % rainbowColors.length],
            index: index,
          );
        },
        childCount: numbers.length,
      ),
    );
  }

  SliverList renderSliverList() {
    return SliverList(
      // 일반적인 ListView의 children에 넣어 그려지듯
      delegate: SliverChildListDelegate(
        numbers
            .map(
              (e) => renderContainer(
                  color: rainbowColors[e % rainbowColors.length], index: e),
            )
            .toList(),
      ),
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

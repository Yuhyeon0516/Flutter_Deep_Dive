import 'package:dusty_dust/const/colors.dart';
import 'package:flutter/material.dart';

class CategoryStat extends StatelessWidget {
  const CategoryStat({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 160,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              16,
            ),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      color: darkColor,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        "종류별 통계",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                        color: lightColor,
                      ),
                      child: ListView(
                        physics: const PageScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: List.generate(
                          6,
                          (index) => SizedBox(
                            width: constraints.maxWidth / 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "미세먼지",
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Image.asset(
                                  "asset/img/bad.png",
                                  width: 50,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                const Text("46.0mg")
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

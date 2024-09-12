import 'package:dusty_dust/model/stat_model.dart';
import 'package:dusty_dust/utils/status_utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

class CategoryStat extends StatelessWidget {
  final Region region;
  final Color darkColor;
  final Color lightColor;
  const CategoryStat({
    super.key,
    required this.region,
    required this.darkColor,
    required this.lightColor,
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
          color: lightColor,
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
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      color: darkColor,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        '종류별 통계',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
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
                      ),
                      child: ListView(
                        physics: const PageScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: ItemCode.values
                            .map(
                              (e) => FutureBuilder(
                                  future: GetIt.I<Isar>()
                                      .statModels
                                      .filter()
                                      .regionEqualTo(region)
                                      .itemCodeEqualTo(e)
                                      .sortByDataTimeDesc()
                                      .findFirst(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Center(
                                        child: Text(snapshot.error.toString()),
                                      );
                                    }
                                    if (!snapshot.hasData) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }

                                    final statModel = snapshot.data!;
                                    final statusModel =
                                        StatusUtils.getStatusModelFromStat(
                                      statModel: statModel,
                                    );

                                    return SizedBox(
                                      width: constraints.maxWidth / 3,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            e.krName,
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Image.asset(
                                            statusModel.imagePath,
                                            width: 50,
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(statModel.stat.toString()),
                                        ],
                                      ),
                                    );
                                  }),
                            )
                            .toList(),
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

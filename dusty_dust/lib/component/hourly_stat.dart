import 'package:dusty_dust/utils/date_utils.dart';
import 'package:dusty_dust/utils/status_utils.dart';
import 'package:flutter/material.dart' hide DateUtils;
import 'package:dusty_dust/model/stat_model.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

class HourlyStat extends StatelessWidget {
  final Region region;
  final Color darkColor;
  final Color lightColor;
  const HourlyStat({
    super.key,
    required this.region,
    required this.darkColor,
    required this.lightColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: ItemCode.values
          .map(
            (itemCode) => FutureBuilder<List<StatModel>>(
              future: GetIt.I<Isar>()
                  .statModels
                  .filter()
                  .regionEqualTo(region)
                  .itemCodeEqualTo(itemCode)
                  .sortByDataTimeDesc()
                  .limit(24)
                  .findAll(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }

                final stats = snapshot.data!;

                return SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Card(
                      color: lightColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: darkColor,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                              ),
                              child: Text(
                                '시간별 ${itemCode.krName}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          ...stats.map(
                            (stat) => Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 4,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${DateUtils.padInteger(number: stat.dataTime.hour)}시',
                                    ),
                                  ),
                                  Expanded(
                                    child: Image.asset(
                                      StatusUtils.getStatusModelFromStat(
                                              statModel: stat)
                                          .imagePath,
                                      height: 20,
                                    ),
                                  ),
                                  Expanded(
                                      child: Text(
                                    StatusUtils.getStatusModelFromStat(
                                            statModel: stat)
                                        .label,
                                    textAlign: TextAlign.right,
                                  ))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
          .toList(),
    );
  }
}

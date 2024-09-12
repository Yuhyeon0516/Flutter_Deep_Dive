import 'package:dio/dio.dart';
import 'package:dusty_dust/model/stat_model.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

class StatRepository {
  static Future<void> fetchData() async {
    final isar = GetIt.I<Isar>();
    final now = DateTime.now();
    final compareDateTimeTarget =
        DateTime(now.year, now.month, now.day, now.hour);

    final count = await isar.statModels
        .filter()
        .dataTimeEqualTo(compareDateTimeTarget)
        .count();

    if (count > 0) {
      print('데이터가 존재합니다. $count');
      return;
    }

    // for (ItemCode itemCode in ItemCode.values) {
    //   await fetchDataByItemCode(itemCode: itemCode);
    // }
  }

  static Future<List<StatModel>> fetchDataByItemCode(
      {required ItemCode itemCode}) async {
    final itemCodeStr = itemCode.name;

    final res = await Dio().get(
      'http://apis.data.go.kr/B552584/ArpltnStatsSvc/getCtprvnMesureLIst',
      queryParameters: {
        'serviceKey':
            'M+umCojLm4KtTM1HUm4vT9AuyEOzHJTPpF6GLlW1l1vYILXw+7eEJHIL0l+FOzh97c/fhmlR4xYzMG5nJoq5qQ==',
        'returnType': 'json',
        'numOfRows': 100,
        'pageNo': 1,
        'itemCode': itemCodeStr,
        'dataGubun': 'HOUR',
        'searchCondition': 'WEEK',
      },
    );

    final rawItemsList = res.data['response']['body']['items'];
    List<StatModel> stats = [];

    final List<String> skipKeys = ['dataGubun', 'dataTime', 'itemCode'];

    for (Map<String, dynamic> item in rawItemsList) {
      final dataTime = DateTime.parse(item['dataTime']);

      for (String key in item.keys) {
        if (skipKeys.contains(key)) {
          continue;
        }

        final regionStr = key;
        final stat = double.parse(item[key]);
        final region = Region.values.firstWhere((e) => e.name == regionStr);

        final statModel = StatModel()
          ..region = region
          ..stat = stat
          ..dataTime = dataTime
          ..itemCode = itemCode;

        final isar = GetIt.I<Isar>();

        final count = await isar.statModels
            .filter()
            .regionEqualTo(region)
            .statEqualTo(stat)
            .dataTimeEqualTo(dataTime)
            .itemCodeEqualTo(itemCode)
            .count();

        if (count > 0) {
          continue;
        }

        await isar.writeTxn(() async {
          await isar.statModels.put(statModel);
        });
      }
    }

    return stats;
  }
}

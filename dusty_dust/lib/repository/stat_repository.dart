import 'package:dio/dio.dart';
import 'package:dusty_dust/model/stat_model.dart';

class StatRepository {
  static Future<List<StatModel>> fetchData({required ItemCode itemCode}) async {
    final itemCodeStr = itemCode == ItemCode.PM25 ? 'PM2.5' : itemCode.name;

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
      final dataTime = item['dataTime'];

      for (String key in item.keys) {
        if (skipKeys.contains(key)) {
          continue;
        }

        final regionStr = key;
        final stat = item[key];

        stats = [
          ...stats,
          StatModel(
            region: Region.values.firstWhere((e) => e.name == regionStr),
            stat: double.parse(stat),
            dataTime: DateTime.parse(dataTime),
            itemCode: itemCode,
          ),
        ];
      }
    }

    return stats;
  }
}

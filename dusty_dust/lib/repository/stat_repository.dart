import 'package:dio/dio.dart';

class StatRepository {
  static Future<Map<String, dynamic>> fetchData() async {
    final res = await Dio().get(
      'http://apis.data.go.kr/B552584/ArpltnStatsSvc/getCtprvnMesureLIst',
      queryParameters: {
        'serviceKey':
            'M+umCojLm4KtTM1HUm4vT9AuyEOzHJTPpF6GLlW1l1vYILXw+7eEJHIL0l+FOzh97c/fhmlR4xYzMG5nJoq5qQ==',
        'returnType': 'json',
        'numOfRows': 100,
        'pageNo': 1,
        'itemCode': 'PM10',
        'dataGubun': 'HOUR',
        'searchCondition': 'WEEK',
      },
    );

    return res.data;
  }
}

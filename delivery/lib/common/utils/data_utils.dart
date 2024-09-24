import 'dart:convert';

import 'package:delivery/common/const/data.dart';

class DataUtils {
  static String pathToUrl(String value) {
    return 'http://$ip:3000$value';
  }

  static List<String> listPathsToUrl(List values) {
    return values.map((e) => pathToUrl(e)).toList();
  }

  static String plainTobase64(String plain) {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);

    String encoded = stringToBase64.encode(plain);

    return encoded;
  }

  static DateTime stringToDateTime(String date) {
    return DateTime.parse(date);
  }
}

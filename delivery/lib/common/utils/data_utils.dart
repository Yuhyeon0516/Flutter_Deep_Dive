import 'package:delivery/common/const/data.dart';

class DataUtils {
  static String pathToUrl(String value) {
    return 'http://$ip:3000$value';
  }

  static List<String> listPathsToUrl(List values) {
    return values.map((e) => pathToUrl(e)).toList();
  }
}

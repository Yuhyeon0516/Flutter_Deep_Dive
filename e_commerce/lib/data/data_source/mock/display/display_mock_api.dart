import 'dart:convert';

import 'package:e_commerce/data/data_source/mock/display/display_mock_data.dart';
import 'package:e_commerce/data/data_source/remote/display.api.dart';
import 'package:e_commerce/data/dto/display/menu/menu.dto.dart';

class DisplayMockApi implements DisplayApi {
  @override
  Future<List<MenuDto>> getMenusByMallType(String mallType) {
    return Future(
      () => _menuParser(mallType == 'market'
          ? DisplayMockData.menusByMarket
          : DisplayMockData.menusByBeauty),
    );
  }

  List<MenuDto> _menuParser(String source) {
    List<MenuDto> menus = [];

    final List json = jsonDecode(source);

    menus = json.map((e) => MenuDto.fromJson(e)).toList();

    return menus;
  }
}

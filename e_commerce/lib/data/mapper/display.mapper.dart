import 'package:e_commerce/data/dto/display/menu/menu.dto.dart';
import 'package:e_commerce/domain/model/display/menu/menu.model.dart';

extension MenuDtoX on MenuDto {
  Menu toModel() {
    return Menu(tabId: tabId ?? -1, title: title ?? '');
  }
}

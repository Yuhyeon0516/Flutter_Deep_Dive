import 'package:freezed_annotation/freezed_annotation.dart';

part 'menu.model.freezed.dart';
part 'menu.model.g.dart';

@freezed
class Menu with _$Menu {
  factory Menu({
    required int tabId,
    required String title,
  }) = _MenuModel;

  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);
}

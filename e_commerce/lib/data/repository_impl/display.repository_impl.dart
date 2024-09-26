import 'package:e_commerce/core/utils/constant.dart';
import 'package:e_commerce/data/data_source/remote/display.api.dart';
import 'package:e_commerce/data/dto/common/response_wrapper/response_wrapper.dart';
import 'package:e_commerce/data/mapper/common.mapper.dart';
import 'package:e_commerce/data/mapper/display.mapper.dart';
import 'package:e_commerce/domain/model/display/menu/menu.model.dart';
import 'package:e_commerce/domain/repository/display.repository.dart';

class DisplayRepositoryImpl implements DisplayRepository {
  final DisplayApi _displayApi;

  DisplayRepositoryImpl(this._displayApi);

  @override
  Future<ResponseWrapper<List<Menu>>> getMenusByMallType(
      {required MallType mallType}) async {
    final res = await _displayApi.getMenusByMallType(mallType.name);

    return res.toModel<List<Menu>>(
      res.data?.map((dto) => dto.toModel()).toList() ?? [],
    );
  }
}

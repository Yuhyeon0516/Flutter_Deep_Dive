import 'package:e_commerce/data/dto/common/response_wrapper/response_wrapper.dart';
import 'package:e_commerce/domain/model/display/menu/menu.model.dart';
import 'package:e_commerce/domain/repository/repository.dart';
import 'package:e_commerce/presentation/main/cubit/mall_type_cubit.dart';

abstract class DisplayRepository extends Repository {
  Future<ResponseWrapper<List<Menu>>> getMenusByMallType({
    required MallType mallType,
  });
}

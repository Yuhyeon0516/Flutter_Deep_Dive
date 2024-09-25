import 'package:e_commerce/core/utils/error/error_response.dart';
import 'package:e_commerce/domain/model/common/result.dart';
import 'package:e_commerce/domain/repository/display.repository.dart';
import 'package:e_commerce/domain/usecase/base/remote.usecase.dart';
import 'package:e_commerce/presentation/main/cubit/mall_type_cubit.dart';

class GetMenusUsecase extends RemoteUsecase<DisplayRepository> {
  final MallType mallType;

  GetMenusUsecase(this.mallType);

  @override
  Future call(DisplayRepository repository) async {
    final res = await repository.getMenusByMallType(mallType: mallType);

    return res.status == 'SUCCESS'
        ? Result.success(res.data ?? [])
        : Result.failure(ErrorResponse(
            status: res.status,
            code: res.code,
            message: res.message,
          ));
  }
}

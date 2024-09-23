import 'package:delivery/common/model/cursor_pagination_model.dart';
import 'package:delivery/common/model/model_with_id.dart';
import 'package:delivery/common/model/pagination_params.dart';

abstract class IBasePaginationRespository<T extends IModelWithId> {
  Future<CursorPaginationModel<T>> paginate({
    PaginationParams? params = const PaginationParams(),
  });
}

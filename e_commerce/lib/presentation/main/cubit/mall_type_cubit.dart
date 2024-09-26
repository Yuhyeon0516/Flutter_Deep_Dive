import 'package:e_commerce/core/theme/custom/custom_app_bar.dart';
import 'package:e_commerce/core/utils/constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MallTypeCubit extends Cubit<MallType> {
  MallTypeCubit() : super(MallType.market);

  void changeIndex(int index) => emit(MallType.values[index]);
}

extension MallTypeLabel on MallType {
  String get label {
    switch (this) {
      case MallType.market:
        return '마켓패캠';

      case MallType.beauty:
        return '뷰티패캠';
    }
  }

  bool get isMarket => this == MallType.market;

  bool get isBeauty => this == MallType.beauty;
}

extension MallTypeTheme on MallType {
  CustomAppBarTheme get theme {
    switch (this) {
      case MallType.market:
        return CustomAppBarTheme.market;
      default:
        return CustomAppBarTheme.beauty;
    }
  }
}

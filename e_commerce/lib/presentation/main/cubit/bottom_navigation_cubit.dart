import 'package:e_commerce/core/theme/constant/app_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum BottomNavigation {
  home,
  category,
  search,
  user,
}

class BottomNavigationCubit extends Cubit<BottomNavigation> {
  BottomNavigationCubit() : super(BottomNavigation.home);

  void changeIndex(int index) => emit(BottomNavigation.values[index]);
}

extension BottomNavigationIcon on BottomNavigation {
  String get icon {
    switch (this) {
      case BottomNavigation.home:
        return AppIcons.navHome;
      case BottomNavigation.category:
        return AppIcons.navCategory;
      case BottomNavigation.search:
        return AppIcons.navSearch;
      case BottomNavigation.user:
        return AppIcons.navUser;
    }
  }

  String get activeIcon {
    switch (this) {
      case BottomNavigation.home:
        return AppIcons.navHomeOn;
      case BottomNavigation.category:
        return AppIcons.navCategoryOn;
      case BottomNavigation.search:
        return AppIcons.navSearchOn;
      case BottomNavigation.user:
        return AppIcons.navUserOn;
    }
  }
}

extension BottomNavigationLabel on BottomNavigation {
  String get label {
    switch (this) {
      case BottomNavigation.home:
        return '홈';
      case BottomNavigation.category:
        return '카테고리';
      case BottomNavigation.search:
        return '검색';
      case BottomNavigation.user:
        return '마이페이지';
    }
  }
}

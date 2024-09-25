import 'package:e_commerce/presentation/main/component/top_app_bar/default_app_bar.dart';
import 'package:e_commerce/presentation/main/component/top_app_bar/home_app_bar.dart';
import 'package:e_commerce/presentation/main/cubit/bottom_navigation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TopAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationCubit, BottomNavigation>(
      builder: (_, state) {
        switch (state) {
          case BottomNavigation.home:
            return const HomeAppBar();
          default:
            return DefaultAppBar(
              bottomNavigation: state,
            );
        }
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(44);
}

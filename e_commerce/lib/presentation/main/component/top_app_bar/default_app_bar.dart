import 'package:e_commerce/core/theme/custom/custom_theme.dart';
import 'package:e_commerce/presentation/main/cubit/bottom_navigation_cubit.dart';
import 'package:e_commerce/presentation/main/cubit/mall_type_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DefaultAppBar extends StatelessWidget {
  final BottomNavigation bottomNavigation;

  const DefaultAppBar({
    super.key,
    required this.bottomNavigation,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MallTypeCubit, MallType>(
      builder: (_, state) {
        return Container(
          color: state.isMarket
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surface,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text(
              bottomNavigation.label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: state.isMarket
                    ? Theme.of(context).colorScheme.surface
                    : Theme.of(context).colorScheme.contentPrimary,
                fontSize: 20,
              ),
            ),
          ),
        );
      },
    );
  }
}

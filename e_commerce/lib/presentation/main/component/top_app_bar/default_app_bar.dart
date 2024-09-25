import 'package:e_commerce/presentation/main/cubit/bottom_navigation_cubit.dart';
import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget {
  final BottomNavigation bottomNavigation;

  const DefaultAppBar({
    super.key,
    required this.bottomNavigation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          bottomNavigation.label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

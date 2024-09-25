import 'package:e_commerce/core/theme/constant/app_icons.dart';
import 'package:e_commerce/presentation/main/cubit/bottom_navigation_cubit.dart';
import 'package:e_commerce/presentation/pages/category/category_page.dart';
import 'package:e_commerce/presentation/pages/home/home_page.dart';
import 'package:e_commerce/presentation/pages/search/search_page.dart';
import 'package:e_commerce/presentation/pages/user/user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class MainScreen extends StatelessWidget {
  static String get routeName => 'main';

  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BottomNavigationCubit(),
      child: const MainScreenView(),
    );
  }
}

class MainScreenView extends StatelessWidget {
  const MainScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(44),
        child: Container(
          color: Theme.of(context).colorScheme.primary,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: const Text(
              'tabbar',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            leadingWidth: 85,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(AppIcons.mainLogo),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: SvgPicture.asset(
                  AppIcons.location,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.surface,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: SvgPicture.asset(
                  AppIcons.cart,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.surface,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: BlocBuilder<BottomNavigationCubit, BottomNavigation>(
        builder: (_, state) {
          switch (state) {
            case BottomNavigation.home:
              return const HomePage();
            case BottomNavigation.category:
              return const CategoryPage();
            case BottomNavigation.search:
              return const SearchPage();
            case BottomNavigation.user:
              return const UserPage();
          }
        },
      ),
      bottomNavigationBar: BlocBuilder<BottomNavigationCubit, BottomNavigation>(
        builder: (context, state) {
          return BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            currentIndex: state.index,
            onTap: (value) =>
                context.read<BottomNavigationCubit>().changeIndex(value),
            items: List.generate(
              BottomNavigation.values.length,
              (index) => BottomNavigationBarItem(
                icon: SvgPicture.asset(BottomNavigation.values[index].icon),
                activeIcon:
                    SvgPicture.asset(BottomNavigation.values[index].activeIcon),
                label: BottomNavigation.values[index].label,
              ),
            ),
          );
        },
      ),
    );
  }
}

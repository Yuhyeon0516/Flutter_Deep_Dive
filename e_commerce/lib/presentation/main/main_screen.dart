import 'package:e_commerce/presentation/main/component/top_app_bar/top_app_bar.dart';
import 'package:e_commerce/presentation/main/cubit/bottom_navigation_cubit.dart';
import 'package:e_commerce/presentation/main/cubit/mall_type_cubit.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => BottomNavigationCubit(),
        ),
        BlocProvider(
          create: (_) => MallTypeCubit(),
        ),
      ],
      child: const MainScreenView(),
    );
  }
}

class MainScreenView extends StatelessWidget {
  const MainScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopAppBar(),
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

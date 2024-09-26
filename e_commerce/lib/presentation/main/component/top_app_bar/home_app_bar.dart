import 'package:e_commerce/core/theme/constant/app_icons.dart';
import 'package:e_commerce/core/theme/custom/custom_app_bar.dart';
import 'package:e_commerce/core/theme/custom/custom_font_weight.dart';
import 'package:e_commerce/core/utils/constant.dart';
import 'package:e_commerce/presentation/main/component/widgets/svg_icon_button.dart';
import 'package:e_commerce/presentation/main/cubit/mall_type_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<MallTypeCubit, MallType>(
      builder: (_, state) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          color: state.theme.backgroundColor,
          child: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(CustomAppBarTheme.tabBarRadius),
                color: state.theme.containerColor,
              ),
              child: SizedBox(
                height: 28,
                child: IntrinsicWidth(
                  child: DefaultTabController(
                    initialIndex: state.index,
                    length: MallType.values.length,
                    child: TabBar(
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            CustomAppBarTheme.tabBarRadius),
                        color: state.theme.indicatorColor,
                      ),
                      isScrollable: false,
                      dividerColor: Colors.transparent,
                      indicatorSize: TabBarIndicatorSize.tab,
                      onTap: (index) =>
                          context.read<MallTypeCubit>().changeIndex(index),
                      labelColor: state.theme.labelColor,
                      labelPadding: const EdgeInsets.symmetric(horizontal: 12),
                      labelStyle: textTheme.labelLarge.bold,
                      unselectedLabelColor: state.theme.unselectedLabelColor,
                      unselectedLabelStyle: textTheme.labelLarge,
                      splashBorderRadius:
                          BorderRadius.circular(CustomAppBarTheme.tabBarRadius),
                      tabs: List.generate(
                        MallType.values.length,
                        (index) => Tab(
                          text: MallType.values[index].label,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            leadingWidth: 75,
            leading: SvgIconButton(
              icon: AppIcons.mainLogo,
              color: state.theme.logoColor,
            ),
            actions: [
              SvgIconButton(
                icon: AppIcons.location,
                color: state.theme.iconColor,
              ),
              SvgIconButton(
                icon: AppIcons.cart,
                color: state.theme.iconColor,
              ),
            ],
          ),
        );
      },
    );
  }
}

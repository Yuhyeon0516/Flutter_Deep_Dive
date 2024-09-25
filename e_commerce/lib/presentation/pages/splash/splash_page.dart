import 'dart:async';

import 'package:e_commerce/core/theme/constant/app_icons.dart';
import 'package:e_commerce/presentation/routes/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

// TODO 로그인 bloc
class SplashPage extends StatefulWidget {
  static String get routeName => 'splash';

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    // TODO 로그인 bloc
    Timer(const Duration(seconds: 2), () => context.go(RoutePath.home));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SvgPicture.asset(AppIcons.mainLogo),
      ),
    );
  }
}

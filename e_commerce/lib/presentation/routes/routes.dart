import 'package:e_commerce/presentation/main/main_screen.dart';
import 'package:e_commerce/presentation/pages/splash/splash_page.dart';
import 'package:e_commerce/presentation/routes/route_path.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: RoutePath.splash,
  routes: [
    GoRoute(
      path: RoutePath.splash,
      name: SplashPage.routeName,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: RoutePath.main,
      name: MainScreen.routeName,
      builder: (context, state) => const MainScreen(),
    ),
  ],
);

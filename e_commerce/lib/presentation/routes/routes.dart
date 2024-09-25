import 'package:e_commerce/presentation/pages/home/home_page.dart';
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
      path: RoutePath.home,
      name: HomePage.routeName,
      builder: (context, state) => const HomePage(),
    ),
  ],
);

import 'package:delivery/common/view/root_tab.dart';
import 'package:delivery/common/view/splash_screen.dart';
import 'package:delivery/restaurant/view/basket_screen.dart';
import 'package:delivery/restaurant/view/restaurant_detail_screen.dart';
import 'package:delivery/user/model/user_model.dart';
import 'package:delivery/user/provider/user_me_provider.dart';
import 'package:delivery/user/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider(ref: ref);
});

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({
    required this.ref,
  }) {
    ref.listen<UserModelBase?>(userMeProvider, (prev, next) {
      if (prev != next) {
        notifyListeners();
      }
    });
  }

  List<GoRoute> get routes => [
        GoRoute(
          path: '/',
          name: RootTab.routeName,
          builder: (_, state) => const RootTab(),
          routes: [
            GoRoute(
              path: 'restaurant/:rid',
              name: RestaurantDetailScreen.routeName,
              builder: (_, state) => RestaurantDetailScreen(
                id: state.pathParameters['rid']!,
              ),
            )
          ],
        ),
        GoRoute(
          path: '/splash',
          name: SplashScreen.routeName,
          builder: (_, state) => const SplashScreen(),
        ),
        GoRoute(
          path: '/login',
          name: LoginScreen.routeName,
          builder: (_, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/basket',
          name: BasketScreen.routeName,
          builder: (_, state) => const BasketScreen(),
        ),
      ];

  String? redirectLogic(BuildContext context, GoRouterState state) {
    final user = ref.read(userMeProvider);

    final logginIn = state.matchedLocation == '/login';

    if (user == null) {
      return logginIn ? null : '/login';
    }

    if (user is UserModel) {
      return logginIn || state.matchedLocation == '/splash' ? '/' : null;
    }

    if (user is UserModelError) {
      return !logginIn ? '/login' : null;
    }

    return null;
  }

  void logout() {
    ref.read(userMeProvider.notifier).logout();
  }
}

import 'package:delivery/user/model/user_model.dart';
import 'package:delivery/user/provider/user_me_provider.dart';
import 'package:flutter/foundation.dart';
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

  String? redirectLogic(GoRouterState state) {
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
}

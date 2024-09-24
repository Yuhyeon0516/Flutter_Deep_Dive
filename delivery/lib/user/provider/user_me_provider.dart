import 'package:delivery/common/const/data.dart';
import 'package:delivery/common/secure_storage/secure_storage_provider.dart';
import 'package:delivery/user/model/user_model.dart';
import 'package:delivery/user/repository/auth_repository.dart';
import 'package:delivery/user/repository/user_me_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final userMeProvider =
    StateNotifierProvider<UserMeStateNotifier, UserModelBase?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final userMeRepository = ref.watch(userMeRepositoryProvider);
  final storage = ref.watch(secureStorageProvider);

  return UserMeStateNotifier(
    repository: userMeRepository,
    storage: storage,
    authRepository: authRepository,
  );
});

class UserMeStateNotifier extends StateNotifier<UserModelBase?> {
  final UserMeRepository repository;
  final FlutterSecureStorage storage;
  final AuthRepository authRepository;

  UserMeStateNotifier({
    required this.repository,
    required this.storage,
    required this.authRepository,
  }) : super(UserModelLoading()) {
    getMe();
  }

  Future<void> getMe() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    if (refreshToken == null || accessToken == null) {
      state = null;

      return;
    }

    final res = await repository.getMe();

    state = res;
  }

  Future<UserModelBase> login({
    required String username,
    required String password,
  }) async {
    try {
      state = UserModelLoading();

      final res =
          await authRepository.login(username: username, password: password);

      await storage.write(key: REFRESH_TOKEN_KEY, value: res.refreshToken);
      await storage.write(key: ACCESS_TOKEN_KEY, value: res.accessToken);

      final userRes = await repository.getMe();

      state = userRes;

      return userRes;
    } catch (e) {
      state = UserModelError(message: '로그인 중 에러가 발생하였습니다.');

      return Future.value(state);
    }
  }

  Future<void> logout() async {
    state = null;

    await Future.wait([
      storage.delete(key: REFRESH_TOKEN_KEY),
      storage.delete(key: ACCESS_TOKEN_KEY)
    ]);
  }
}

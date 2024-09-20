import 'package:delivery/common/dio/dio.dart';
import 'package:delivery/common/secure_storage/secure_storage_provider.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

@riverpod
Dio dio(DioRef ref) {
  final dio = Dio();
  final storage = ref.read(secureStorageProvider);

  dio.interceptors.add(CustomInterceptor(storage: storage));

  return dio;
}

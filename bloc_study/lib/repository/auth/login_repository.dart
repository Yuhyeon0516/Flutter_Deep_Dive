import 'package:bloc_study/config/app_url.dart';
import 'package:bloc_study/data/network/network_services_api.dart';
import 'package:bloc_study/models/user/user_model.dart';

class LoginRepository {
  final _api = NetworkServicesApi();

  Future<UserModel> loginApi(dynamic data) async {
    final res = await _api.postApi(AppUrl.loginApi, data);

    return UserModel.fromJson(res);
  }
}

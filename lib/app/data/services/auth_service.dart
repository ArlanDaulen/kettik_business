import 'package:kettik_business/app/clients/json_api_client.dart';
import 'package:kettik_business/app/data/models/user_auth_response_model.dart';
import 'package:kettik_business/core/freezed/network_error.dart';
import 'package:kettik_business/core/freezed/result.dart';
import 'package:kettik_business/core/network/layers/network_executer.dart';

class AuthService {
  Future<Result<UserAuthResponseModel, NetworkError>> login(
      String email, String password) async {
    return NetworkExecuter.execute(
        route: PlaceHolderClient.login(email, password),
        responseType: UserAuthResponseModel());
  }

  Future<Result<UserAuthResponseModel, NetworkError>> register(
      String email, String username, String password, String phone) async {
    return NetworkExecuter.execute(
        route: PlaceHolderClient.register(email, username, password, phone));
  }
}

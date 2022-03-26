import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kettik_business/app/main/user_data.dart';
import 'package:kettik_business/core/network/interfaces/base_client_generator.dart';
part 'json_api_client.freezed.dart';

@freezed
class PlaceHolderClient extends BaseClientGenerator with _$PlaceHolderClient {
  static final UserData _userData = UserData();
  // Routes
  const PlaceHolderClient._() : super();
  const factory PlaceHolderClient.login(String email, String password) = _Login;
  const factory PlaceHolderClient.register(
      String email, String username, String password, String phone) = _Register;

  @override
  String get baseURL => "https://kettik-tour-app-dev.herokuapp.com/api";

  @override
  Future<Map<String, dynamic>> get header async {
    return {
      "accept": "application/json",
      "authorization": "Bearer " + await _userData.getToken(),
    };
  }

  @override
  String get path {
    return this.when<String>(
      register: (String email, String username, String password,
              String phone) =>
          '/user/registration?email=$email&fullName=$username&password=$password&phone=$phone',
      login: (String email, String password) =>
          '/user/login?email=$email&password=$password',
    );
  }

  @override
  String get method {
    return this.maybeWhen<String>(
      orElse: () => 'GET',
      login: (String email, String password) => 'POST',
      register:
          (String email, String username, String password, String phone) =>
              'POST',
    );
  }

  @override
  dynamic get body {
    return this.maybeWhen(
      orElse: () {
        return null;
      },
      login: (String email, String password) => null,
      register:
          (String email, String username, String password, String phone) =>
              null,
    );
  }

  @override
  Map<String, dynamic>? get queryParameters {
    return this.maybeWhen(
      orElse: () {
        return null;
      },
    );
  }
}

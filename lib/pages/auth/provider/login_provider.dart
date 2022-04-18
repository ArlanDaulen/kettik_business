import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:kettik_business/app/data/models/user_auth_response_model.dart';
import 'package:kettik_business/app/data/services/auth_service.dart';
import 'package:kettik_business/app/main/user_data.dart';
import 'package:kettik_business/base/base_bloc.dart';
import 'package:kettik_business/core/freezed/network_error.dart';
import 'package:kettik_business/core/freezed/result.dart';
import 'package:kettik_business/pages/index/ui/index.dart';
import 'package:kettik_business/shared/size_config.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class LoginProvider extends BaseBloc {
  TextEditingController loginCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  bool isButtonEnabled = true;
  bool isObscureText = true;
  Size? size;
  AuthService _authService = AuthService();
  UserData _userData = UserData();
  var phoneFormatter = MaskTextInputFormatter(
      mask: '(###) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  init(BuildContext context) {
    setLoading(true);
    SizeConfig().init(context);
    size = MediaQuery.of(context).size;
    setLoading(false);
  }

  setIsButtonEnabled(bool value) {
    isButtonEnabled = value;
    notifyListeners();
  }

  void checkForm() {}

  void setReverisObscured() {
    isObscureText = !isObscureText;
    notifyListeners();
  }

  toLogin(BuildContext context) async {
    setIsSendRequest(true);

    // Result<UserAuthResponseModel, NetworkError> loginResponse =
    //     await _authService.login(loginCtrl.text, passwordCtrl.text);

    // loginResponse.when(success: (response) async {
    //   _userData.setAllUserDatas(
    //       response.token, response.expiryDate, response.user);
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const IndexScreen()));
    // }, failure: (error) {
    //   CoolAlert.show(
    //       context: context,
    //       type: CoolAlertType.error,
    //       title: "Ошибка!",
    //       text: "");
    // });

    setIsSendRequest(false);
  }
}

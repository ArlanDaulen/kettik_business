import 'package:flutter/material.dart';
import 'package:kettik_business/base/base_provider.dart';
import 'package:kettik_business/pages/auth/provider/login_provider.dart';
import 'package:kettik_business/pages/auth/provider/register_provider.dart';
import 'package:kettik_business/pages/auth/ui/register.dart';
import 'package:kettik_business/shared/size_config.dart';
import 'package:kettik_business/shared/theme.dart';
import 'package:kettik_business/shared/ui_helper.dart';
import 'package:kettik_business/shared/utils.dart';
import 'package:kettik_business/widgets/custom_container.dart';
import 'package:kettik_business/widgets/default_button.dart';
import 'package:kettik_business/widgets/loading_view.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseProvider<LoginProvider>(
        onReady: (_) => _.init(context),
        builder: (context, model, child) {
          return model.isLoading
              ? const LoadingView()
              : ModalProgressHUD(
                  inAsyncCall: model.isSendRequest,
                  child: Scaffold(
                    body: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Spacer(),
                        Text(
                          'Добро пожаловать!',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: getProportionateScreenWidth(48),
                              color: AppColors.systemBlackColor),
                        ),
                        UIHelper.verticalSpace(10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Text(
                            'Введите ваш номер телефона для входа.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(24),
                              color: AppColors.systemDarkGrayColor,
                            ),
                          ),
                        ),
                        UIHelper.verticalSpace(50),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(60)),
                          child: CustomContainer(
                            child: TextField(
                              controller: model.loginCtrl,
                              onChanged: (String value) {
                                model.checkForm();
                              },
                              keyboardType: TextInputType.text,
                              cursorColor: AppColors.systemBlackColor,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.person,
                                    color: AppColors.primaryColor),
                                hintText: 'E-mail',
                                hintStyle: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 16,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        UIHelper.verticalSpace(20),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(60)),
                          child: CustomContainer(
                            child: TextField(
                              controller: model.passwordCtrl,
                              onChanged: (String value) {
                                model.checkForm();
                              },
                              keyboardType: TextInputType.text,
                              obscureText: model.isObscureText,
                              obscuringCharacter: "*",
                              cursorColor: AppColors.systemBlackColor,
                              // inputFormatters: [model.phoneFormatter],
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      model.setReverisObscured();
                                    },
                                    icon: Icon(Icons.remove_red_eye_rounded,
                                        color: model.isObscureText
                                            ? AppColors.primaryColor
                                            : AppColors.systemRedColor)),
                                prefixIcon: const Icon(Icons.security,
                                    color: AppColors.primaryColor),
                                hintText: 'Пароль',
                                hintStyle: const TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 16,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(
                          flex: 3,
                        )
                      ],
                    ),
                    floatingActionButton: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const RegisterScreen()));
                            },
                            child: Text("Зарегистрироваться".toUpperCase())),
                        SizedBox(
                          height: getProportionateScreenHeight(8),
                        ),
                        DefaultButton(
                          width: model.size!.width * 0.9,
                          color: model.isButtonEnabled
                              ? AppColors.primaryColor
                              : AppColors.inactiveColor,
                          text: 'Дальше',
                          press: model.isButtonEnabled
                              ? () async {
                                  await model.toLogin(context);
                                }
                              : () {
                                  showCustomToast(
                                    "Номер телефона пустой или не совпадает формату",
                                  );
                                },
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),
                      ],
                    ),
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.centerDocked,
                  ),
                );
        },
        model: LoginProvider());
  }
}

import 'package:flutter/material.dart';
import 'package:kettik_business/base/base_provider.dart';
import 'package:kettik_business/pages/auth/provider/register_provider.dart';
import 'package:kettik_business/shared/size_config.dart';
import 'package:kettik_business/shared/theme.dart';
import 'package:kettik_business/shared/ui_helper.dart';
import 'package:kettik_business/widgets/custom_container.dart';
import 'package:kettik_business/widgets/default_button.dart';
import 'package:kettik_business/widgets/loading_view.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseProvider<RegisterProvider>(
        onReady: (_) => _.init(context),
        builder: (context, model, child) {
          return model.isLoading
              ? const LoadingView()
              : Scaffold(
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      UIHelper.verticalSpace(
                        getProportionateScreenHeight(500),
                      ),
                      Text(
                        'Регистрация!',
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
                          'Введите ваш номер телефона для регистрации.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(24),
                            color: AppColors.systemDarkGrayColor,
                          ),
                        ),
                      ),
                      UIHelper.verticalSpace(30),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(60)),
                        child: CustomContainer(
                          child: TextField(
                            controller: model.usernameCtrl,
                            onChanged: (String value) {
                              model.checkForm();
                            },
                            keyboardType: TextInputType.text,
                            cursorColor: AppColors.systemBlackColor,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.person,
                                  color: AppColors.primaryColor),
                              hintText: 'Имя Фамилия',
                              hintStyle: TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 16,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      UIHelper.verticalSpace(30),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(60)),
                        child: CustomContainer(
                          child: TextField(
                            controller: model.emailCtrl,
                            onChanged: (String value) {
                              model.checkForm();
                            },
                            keyboardType: TextInputType.text,
                            cursorColor: AppColors.systemBlackColor,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.mail,
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
                            controller: model.phoneCtrl,
                            onChanged: (String value) {
                              model.checkForm();
                            },
                            keyboardType: TextInputType.number,
                            cursorColor: AppColors.systemBlackColor,
                            inputFormatters: [model.phoneFormatter],
                            decoration: InputDecoration(
                              prefixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.phone,
                                      color: AppColors.primaryColor),
                                  Container(
                                      padding: const EdgeInsets.only(
                                          right: 5, bottom: 1),
                                      margin: EdgeInsets.only(left: 20),
                                      child: const Text(
                                        "+7",
                                        style: TextStyle(
                                            color: AppColors.systemBlackColor,
                                            fontSize: 17),
                                      )),
                                ],
                              ),
                              hintText: 'Номер телефона',
                              hintStyle: const TextStyle(
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
                      UIHelper.verticalSpace(20),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(60)),
                        child: CustomContainer(
                          child: TextField(
                            controller: model.rePasswordCtrl,
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
                              hintText: 'Повоторите пароль',
                              hintStyle: const TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 16,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  floatingActionButton: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text("авторизоваться".toUpperCase())),
                      SizedBox(
                        height: getProportionateScreenHeight(8),
                      ),
                      DefaultButton(
                          width: model.size!.width * 0.9,
                          color: AppColors.primaryColor,
                          text: 'Дальше',
                          press: () {
                            model.toVerification(context);
                          }),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                    ],
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerDocked,
                );
        },
        model: RegisterProvider());
  }
}

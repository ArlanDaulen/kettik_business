import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kettik_business/base/base_provider.dart';
import 'package:kettik_business/pages/auth/provider/verification_provider.dart';
import 'package:kettik_business/shared/size_config.dart';
import 'package:kettik_business/shared/theme.dart';
import 'package:kettik_business/shared/ui_helper.dart';
import 'package:kettik_business/widgets/default_button.dart';
import 'package:kettik_business/widgets/loading_view.dart';

class NotifyUserAboutEmailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseProvider<VerifyInfoProvider>(
        onReady: (_) => _.init(context),
        builder: (context, model, child) {
          return Scaffold(
            body: model.isLoading
                ? const LoadingView()
                : Container(
                    width: model.size!.width,
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(50)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Spacer(
                          flex: 5,
                        ),
                        Text(
                          "Проверьте почту!",
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(48),
                              fontWeight: FontWeight.w500),
                        ),
                        UIHelper.verticalSpace(20),
                        Text(
                          "Мы отправили вам на почту сообщение! Подтвердите свой аккаунт через почту.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(28),
                              fontWeight: FontWeight.w500),
                        ),
                        const Spacer(),
                        // SvgPicture.asset(AppSvgImages.),
                        Icon(Icons.check),
                        const Spacer(
                          flex: 5,
                        ),
                      ],
                    ),
                  ),
            floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DefaultButton(
                    width: model.size!.width * 0.9,
                    color: AppColors.primaryColor,
                    text: 'Логин',
                    press: () {
                      model.toLogin(context);
                    }),
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          );
        },
        model: VerifyInfoProvider());
  }
}

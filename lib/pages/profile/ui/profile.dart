import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kettik_business/base/base_provider.dart';
import 'package:kettik_business/pages/profile/provider/profile_provider.dart';
import 'package:kettik_business/shared/size_config.dart';
import 'package:kettik_business/shared/theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseProvider<ProfileProvider>(
      model: ProfileProvider(),
      onReady: (p0) => p0.init(context),
      builder: (context, model, child) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(40),
          ),
          child: Column(
            children: [
              SizedBox(
                height: getProportionateScreenHeight(30),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    AppSvgImages.avatar_ic,
                    height: getProportionateScreenHeight(242),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.user.fullName!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: getProportionateScreenHeight(24),
                        ),
                      ),
                      Text(
                        model.user.email!,
                        style: TextStyle(
                          fontSize: getProportionateScreenHeight(24),
                        ),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppSvgImages.telegram_ic,
                            height: getProportionateScreenHeight(45),
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(25),
                          ),
                          Text(
                            model.user.telegramPhone!,
                            style: TextStyle(
                              fontSize: getProportionateScreenHeight(24),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(AppPngPaths.whatsapp_ic),
                          SizedBox(
                            width: getProportionateScreenWidth(25),
                          ),
                          Text(
                            model.user.telegramPhone!,
                            style: TextStyle(
                              fontSize: getProportionateScreenHeight(24),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

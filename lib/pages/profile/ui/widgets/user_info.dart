import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kettik_business/pages/profile/provider/profile_provider.dart';
import 'package:kettik_business/widgets/default_button.dart';

import '../../../../shared/size_config.dart';
import '../../../../shared/theme.dart';

class UserInfo extends StatelessWidget {
  final ProfileProvider model;
  const UserInfo({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        model.user.image == null
            ? SvgPicture.asset(
                AppSvgImages.avatar_ic,
                height: getProportionateScreenHeight(242),
              )
            : ClipOval(
                child: Image.file(
                  model.user.image!,
                  width: getProportionateScreenWidth(242),
                  height: getProportionateScreenHeight(242),
                  fit: BoxFit.cover,
                ),
              ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.user.fullName!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: getProportionateScreenHeight(30),
              ),
            ),
            Text(
              model.user.email!,
              style: TextStyle(
                fontSize: getProportionateScreenHeight(24),
              ),
            ),
            _buildMessangerPhones(
                SvgPicture.asset(
                  AppSvgImages.telegram_ic,
                  height: getProportionateScreenHeight(45),
                ),
                model.user.telegramPhone!),
            _buildMessangerPhones(
                Image.asset(
                  AppPngPaths.whatsapp_ic,
                  width: getProportionateScreenWidth(45),
                  height: getProportionateScreenHeight(50),
                ),
                model.user.whatsappPhone!),
          ],
        ),
      ],
    );
  }

  _buildMessangerPhones(Widget icon, String phone) {
    return Row(
      children: [
        icon,
        SizedBox(
          width: getProportionateScreenWidth(25),
        ),
        Text(
          phone,
          style: TextStyle(
            fontSize: getProportionateScreenHeight(24),
          ),
        ),
      ],
    );
  }
}

import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kettik_business/pages/profile/provider/profile_provider.dart';
import 'package:kettik_business/pages/profile/ui/help_screen.dart';
import 'package:kettik_business/pages/profile/ui/widgets/change_language_alert_dialog.dart';
import 'package:kettik_business/pages/profile/ui/widgets/lang.dart';
import 'package:kettik_business/shared/size_config.dart';
import 'package:kettik_business/shared/theme.dart';

import '../about_business_screen.dart';

class Settings extends StatelessWidget {
  Settings({Key? key, required this.model}) : super(key: key);
  final ProfileProvider model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSettings(
            AppSvgImages.about_business_ic,
            'aboutBusiness'.tr(),
            context,
            () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => AboutBusinessScreen(
                          model: model,
                        )))),
        _buildSettings(
          AppSvgImages.language_ic,
          'lang'.tr(),
          context,
          () => changeLanguage(context),
        ),
        _buildSettings(
          AppSvgImages.help_ic,
          'help'.tr(),
          context,
          () => Navigator.push(
              context, MaterialPageRoute(builder: (_) => HelpScreen())),
        ),
        _buildSettings(
          AppSvgImages.logout_ic,
          'logout'.tr(),
          context,
          () => logout(context),
        ),
      ],
    );
  }

  _buildSettings(String icon, String title, context, Function() ontap) {
    return ListTile(
      leading: SvgPicture.asset(
        icon,
        width: getProportionateScreenWidth(60),
        height: getProportionateScreenHeight(60),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: getProportionateScreenHeight(32),
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: AppColors.primaryColor,
      ),
      onTap: () => ontap(),
      // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => )),
    );
  }

  changeLanguage(context) => showModalBottomSheet(
      context: context, builder: (_) => LangWidget(profileProvider: model));

  // showDialog(
  //       context: context,
  //       builder: (_) => ChangeLanguageAlertDialog(),
  //     );

  logout(context) => showDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: Text(
            'logOutProfileQuestion'.tr(),
            style: TextStyle(
              fontSize: getProportionateScreenHeight(36),
            ),
          ),
          actions: [
            CupertinoDialogAction(
              child: Text(
                'no'.tr(),
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(32),
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text(
                'yes'.tr(),
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(32),
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
}

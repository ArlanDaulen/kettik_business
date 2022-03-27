import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kettik_business/pages/profile/provider/profile_provider.dart';
import 'package:kettik_business/pages/profile/ui/help_screen.dart';
import 'package:kettik_business/pages/profile/ui/widgets/change_language_alert_dialog.dart';
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
            'О бизнесе',
            context,
            () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => AboutBusinessScreen(
                          model: model,
                        )))),
        _buildSettings(
          AppSvgImages.language_ic,
          'Сменить язык',
          context,
          () => changeLanguage(context),
        ),
        _buildSettings(
          AppSvgImages.help_ic,
          'Помощь',
          context,
          () => Navigator.push(
              context, MaterialPageRoute(builder: (_) => HelpScreen())),
        ),
        _buildSettings(
          AppSvgImages.logout_ic,
          'Выйти',
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

  changeLanguage(context) => showDialog(
        context: context,
        builder: (_) => ChangeLanguageAlertDialog(),
      );

  logout(context) => showDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: Text(
            'Э ска точно шыккын келе ма, щенок?',
            style: TextStyle(
              fontSize: getProportionateScreenHeight(36),
            ),
          ),
          actions: [
            CupertinoDialogAction(
              child: Text(
                'Нет',
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(32),
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text(
                'Да',
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

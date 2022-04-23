import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kettik_business/base/base_provider.dart';
import 'package:kettik_business/pages/profile/provider/profile_provider.dart';
import 'package:kettik_business/pages/profile/ui/change_profile.dart';
import 'package:kettik_business/pages/profile/ui/widgets/settings.dart';
import 'package:kettik_business/pages/profile/ui/widgets/user_info.dart';
import 'package:kettik_business/shared/size_config.dart';
import 'package:kettik_business/shared/theme.dart';
import 'package:kettik_business/widgets/default_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<TextEditingController>? controllers;

  void _onProfileChanged(List<TextEditingController> ctrls) {
    setState(() {
      controllers = ctrls;
    });
  }

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
                height: getProportionateScreenHeight(150),
              ),
              UserInfo(model: model),
              SizedBox(
                height: getProportionateScreenHeight(30),
              ),
              DefaultButton(
                text: "chaange".tr(),
                press: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChangeProfileScreen(
                      onProfileChanged: _onProfileChanged,
                      model: model,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(30),
              ),
              Settings(
                model: model,
              ),
            ],
          ),
        );
      },
    );
  }
}

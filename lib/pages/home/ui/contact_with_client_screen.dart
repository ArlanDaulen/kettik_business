import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kettik_business/shared/size_config.dart';
import 'package:kettik_business/shared/theme.dart';
import 'package:kettik_business/widgets/custom_app_bar.dart';
import 'package:kettik_business/widgets/default_text.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactWithClientScreen extends StatelessWidget {
  const ContactWithClientScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'contactTheClient'.tr(),
        isWithBackButton: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(40),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: getProportionateScreenHeight(30),
                  ),
                  SvgPicture.asset(
                    AppSvgImages.avatar_ic,
                    width: getProportionateScreenWidth(200),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  Text(
                    'Amangeldi Sparta',
                    style: TextStyle(
                      fontSize: getProportionateScreenHeight(36),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  Text(
                    'Amazon, South America',
                    style:
                        TextStyle(fontSize: getProportionateScreenHeight(24)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            DefaultText(
              text: 'write'.tr(),
              fontSize: 28,
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            Row(
              children: [
                _buildMessangers(
                  SvgPicture.asset(
                    AppSvgImages.telegram_ic,
                    width: getProportionateScreenWidth(75),
                  ),
                  'https://t.me/Spatay7',
                ),
                SizedBox(
                  width: getProportionateScreenWidth(30),
                ),
                _buildMessangers(
                  Image.asset(
                    AppPngPaths.whatsapp_ic,
                    width: getProportionateScreenWidth(80),
                    height: getProportionateScreenHeight(80),
                  ),
                  'https://api.whatsapp.com/send?phone=77082473700',
                ),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            DefaultText(
              text: 'contact'.tr() + ' Sparta',
              fontSize: 28,
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            GestureDetector(
              onTap: () async => await launch('tel: +77082473700'),
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                  vertical: getProportionateScreenHeight(20),
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  border: Border.all(color: AppColors.primaryColor),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    DefaultText(
                      text: '+7 (705) 278 07 38',
                      color: AppColors.primaryColor,
                      fontSize: 28,
                    ),
                    Spacer(),
                    SizedBox(
                      height: getProportionateScreenHeight(66),
                      child: const VerticalDivider(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(20),
                    ),
                    SvgPicture.asset(
                      AppSvgImages.phone_home_outlined_ic,
                      width: getProportionateScreenWidth(40),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildMessangers(Widget icon, String onTap) {
    return GestureDetector(
      onTap: () async => await launch(onTap),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(38),
          vertical: getProportionateScreenHeight(38),
        ),
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: icon,
      ),
    );
  }
}

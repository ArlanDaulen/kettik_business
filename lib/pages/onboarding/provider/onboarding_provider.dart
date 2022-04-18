// import 'package:animated_onboarding/animated_onboarding.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kettik_business/app/main/user_data.dart';
import 'package:kettik_business/base/base_bloc.dart';
import 'package:kettik_business/pages/index/ui/index.dart';
import 'package:kettik_business/pages/onboarding/ui/animated_onboarding.dart';
import 'package:kettik_business/shared/size_config.dart';
import 'package:kettik_business/shared/theme.dart';

class OnboardingProvider extends BaseBloc {
  Size? size;
  PageController controller = PageController();
  List<OnboardingPage> pages = [];
  final UserData _userData = UserData();

  init(BuildContext context) {
    setLoading(true);
    size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    setPages();
    setLoading(false);
  }

  setPages() {
    pages = [
      OnboardingPage(
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              // SvgPicture.asset(
              //   AppSvgImages.onboarding_1,
              //   width: size!.width,
              // ),
              SizedBox(
                height: getProportionateScreenHeight(0),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("onboardingTitleFirst".tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.systemBlackColor,
                          fontSize: getProportionateScreenHeight(48),
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: getProportionateScreenHeight(15),
                  ),
                  Text("onboardingTextFirst".tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.systemDarkGrayColor,
                          fontSize: getProportionateScreenHeight(36),
                          fontWeight: FontWeight.w400)),
                ],
              ),
            ],
          ),
        ),
        color: Colors.white,
      ),
      OnboardingPage(
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(
                height: getProportionateScreenHeight(70),
              ),
              // SvgPicture.asset(
              //   AppSvgImages.onboarding_2,
              //   width: size!.width,
              // ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("onboardingTitleSecond".tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: getProportionateScreenHeight(48),
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: getProportionateScreenHeight(15),
                  ),
                  Text("onboardingTextSecond".tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: getProportionateScreenHeight(36),
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ],
          ),
        ),
        // color: const Color(0xff56adff),
        color: const Color(0xff5e70a0),
      ),
      OnboardingPage(
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              // SvgPicture.asset(
              //   AppSvgImages.onboarding_3,
              //   width: size!.width,
              // ),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("onboardingTitleThird".tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.systemBlackColor,
                          fontSize: getProportionateScreenHeight(48),
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: getProportionateScreenHeight(15),
                  ),
                  Text("onboardingTextThird".tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.systemDarkGrayColor,
                          fontSize: getProportionateScreenHeight(36),
                          fontWeight: FontWeight.w400)),
                ],
              ),
            ],
          ),
        ),
        color: Colors.blue.withOpacity(0.45),
      ),
    ];
  }

  void goToHomeScreen(BuildContext context) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (_) => IndexScreen()), (route) => false);
  }

  void setIsOnboardingSkipped(bool value) {
    _userData.setUserOnboardingSkipped(value);
  }

//TODO check onboarding skipped
//TODO set onboarding skipped
}

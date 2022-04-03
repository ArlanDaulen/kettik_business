import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kettik_business/base/base_provider.dart';
import 'package:kettik_business/pages/profile/provider/choose_city_screen_provider.dart';
import 'package:kettik_business/pages/profile/provider/profile_provider.dart';
import 'package:kettik_business/shared/size_config.dart';
import 'package:kettik_business/shared/theme.dart';
import 'package:kettik_business/widgets/custom_app_bar.dart';
import 'package:kettik_business/widgets/default_button.dart';

typedef OnCityChosen = void Function(String city);

class ChooseCityScreen extends StatefulWidget {
  ChooseCityScreen(
      {Key? key, required this.profileProvider, required this.onCityChosen})
      : super(key: key);
  final ProfileProvider profileProvider;
  final OnCityChosen onCityChosen;

  @override
  State<ChooseCityScreen> createState() => _ChooseCityScreenState();
}

class _ChooseCityScreenState extends State<ChooseCityScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseProvider<ChooseCityProvider>(
      model: ChooseCityProvider(),
      onReady: (p0) => p0.initCity(context, widget.profileProvider),
      builder: (context, model, child) {
        return Scaffold(
          appBar: CustomAppBar(
            title: 'Choose city',
            isWithBackButton: true,
          ),
          bottomSheet: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(40),
              vertical: getProportionateScreenHeight(20),
            ),
            child: DefaultButton(
              text: 'Save',
              press: () {
                // model.saveSelectedCity();
                Navigator.of(context)
                    .pop({widget.onCityChosen(model.currentCity!)});
              },
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(40),
            ),
            child: ListView.separated(
              padding: EdgeInsets.only(
                bottom: getProportionateScreenHeight(80),
              ),
              shrinkWrap: true,
              itemCount: model.cities.length,
              separatorBuilder: (_, index) => const Divider(
                color: AppColors.primaryColor,
              ),
              itemBuilder: (_, index) => ListTile(
                onTap: () {
                  model.changeSelectedCity(index);
                },
                leading: SvgPicture.asset(
                  model.cityBools[index]
                      ? AppSvgImages.chosen_ic
                      : AppSvgImages.unchosen_ic,
                  width: getProportionateScreenWidth(50),
                  height: getProportionateScreenHeight(50),
                ),
                title: Text(
                  model.cities.values.toList()[index],
                  style: TextStyle(
                    fontSize: getProportionateScreenHeight(32),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

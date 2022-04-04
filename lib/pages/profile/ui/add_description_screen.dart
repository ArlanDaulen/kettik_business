import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kettik_business/shared/size_config.dart';
import 'package:kettik_business/shared/theme.dart';
import 'package:kettik_business/widgets/custom_app_bar.dart';
import 'package:kettik_business/widgets/default_button.dart';

typedef OnDescriptionAdded = void Function(String text);

class AddDescriptionScreen extends StatelessWidget {
  final OnDescriptionAdded onDescriptionAdded;
  AddDescriptionScreen({Key? key, required this.onDescriptionAdded})
      : super(key: key);

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'addDescription'.tr(),
          isWithBackButton: true,
        ),
        bottomSheet: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(40),
            vertical: getProportionateScreenHeight(30),
          ),
          child: DefaultButton(
            text: 'save'.tr(),
            press: () => Navigator.of(context)
                .pop({onDescriptionAdded(controller.text)}),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(40),
          ),
          child: Column(
            children: [
              SizedBox(
                height: getProportionateScreenHeight(30),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(30),
                  vertical: getProportionateScreenHeight(20),
                ),
                decoration: BoxDecoration(
                  color: AppColors.systemLightGrayColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                  cursorColor: AppColors.systemBlackColor,
                  style: TextStyle(
                    fontSize: getProportionateScreenHeight(28),
                  ),
                  decoration: InputDecoration(
                    hintText: 'writeAboutYourCompany'.tr(),
                    hintStyle: TextStyle(
                      fontSize: getProportionateScreenHeight(28),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

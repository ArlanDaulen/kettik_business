import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kettik_business/shared/size_config.dart';
import 'package:kettik_business/shared/theme.dart';
import 'package:kettik_business/widgets/custom_app_bar.dart';
import 'package:kettik_business/widgets/default_button.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

typedef OnContactAdded = void Function(List<TextEditingController>);

class AddContactsScreen extends StatelessWidget {
  AddContactsScreen({Key? key, required this.onContactAdded}) : super(key: key);

  final OnContactAdded onContactAdded;

  List<String> titles = [
    'email'.tr(),
    'surname'.tr(),
    'name'.tr(),
    'addWhatsAppNumber'.tr(),
    'addTelegramNumber'.tr(),
  ];

  List<TextEditingController> controllers =
      List.generate(5, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          title: 'addContacts'.tr(),
          isWithBackButton: true,
        ),
        bottomSheet: Padding(
          padding: EdgeInsets.only(
            bottom: getProportionateScreenHeight(30),
            left: getProportionateScreenWidth(40),
            right: getProportionateScreenWidth(40),
          ),
          child: DefaultButton(
            text: 'save'.tr(),
            press: () => Navigator.of(context).pop({
              onContactAdded(controllers),
            }),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(40),
            right: getProportionateScreenWidth(40),
            top: getProportionateScreenHeight(30),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: controllers.length,
            separatorBuilder: (_, index) => SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            itemBuilder: (_, index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titles[index],
                  style: TextStyle(
                    color: AppColors.systemDarkGrayColor,
                    fontSize: getProportionateScreenHeight(24),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                TextField(
                  textAlign: TextAlign.left,
                  keyboardType: index == 3 || index == 4
                      ? TextInputType.number
                      : index == 0
                          ? TextInputType.emailAddress
                          : TextInputType.name,
                  inputFormatters: [
                    if (index == 3 || index == 4) numberFormatter
                  ],
                  controller: controllers[index],
                  style: TextStyle(
                    fontSize: getProportionateScreenHeight(28),
                  ),
                  cursorColor: AppColors.systemBlackColor,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.systemLightGrayColor.withOpacity(0.3),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    contentPadding:
                        EdgeInsets.only(left: getProportionateScreenWidth(20)),
                    prefixIcon: index == 3
                        ? Padding(
                            padding: EdgeInsets.only(
                              right: getProportionateScreenWidth(20),
                            ),
                            child: SvgPicture.asset(
                              AppSvgImages.telegram_ic,
                              width: 1,
                              height: 1,
                              fit: BoxFit.scaleDown,
                            ),
                          )
                        : index == 4
                            ? Image.asset(
                                AppPngPaths.whatsapp_ic,
                                width: getProportionateScreenWidth(15),
                                height: getProportionateScreenHeight(15),
                              )
                            : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  var numberFormatter = MaskTextInputFormatter(
      mask: '+# (###) ###-##-##', filter: {'#': RegExp(r'[0-9]')});
}

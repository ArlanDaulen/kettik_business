import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../shared/size_config.dart';
import '../../../../shared/theme.dart';

class ChangeLanguageAlertDialog extends StatefulWidget {
  const ChangeLanguageAlertDialog({Key? key}) : super(key: key);

  @override
  State<ChangeLanguageAlertDialog> createState() =>
      _ChangeLanguageAlertDialogState();
}

class _ChangeLanguageAlertDialogState extends State<ChangeLanguageAlertDialog> {
  List<bool> bools = [true, false, false];
  List<String> texts = [
    'Қазақша',
    'Русский',
    'Язык жестов',
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 0,
      alignment: Alignment.center,
      backgroundColor: AppColors.whiteColor,
      child: Container(
        padding: EdgeInsets.only(
          top: getProportionateScreenHeight(60),
          bottom: getProportionateScreenHeight(60),
          left: getProportionateScreenWidth(120),
        ),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: bools.length,
          separatorBuilder: (_, index) => SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          itemBuilder: (_, index) => GestureDetector(
            onTap: () => changeLanguage(index),
            child: Container(
              color: AppColors.primaryColor.withOpacity(0),
              child: Row(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    bools[index]
                        ? AppSvgImages.chosen_ic
                        : AppSvgImages.unchosen_ic,
                    width: getProportionateScreenWidth(60),
                    height: getProportionateScreenHeight(60),
                  ),
                  SizedBox(
                    width: getProportionateScreenWidth(30),
                  ),
                  Text(
                    texts[index],
                    style: TextStyle(
                      fontSize: getProportionateScreenHeight(32),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  changeLanguage(int index) {
    setState(() {
      for (int buttonIndex = 0; buttonIndex < bools.length; buttonIndex++) {
        if (buttonIndex == index) {
          bools[buttonIndex] = true;
        } else {
          bools[buttonIndex] = false;
        }
      }
    });
  }
}

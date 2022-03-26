import 'package:flutter/material.dart';
import 'package:kettik_business/shared/size_config.dart';
import 'package:kettik_business/shared/theme.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton(
      {this.text,
      this.press,
      this.color = AppColors.primaryColor,
      this.width = double.maxFinite});
  final String? text;
  final Function? press;
  final Color color;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          primary: color,
        ),
        onPressed: press as void Function()?,
        child: Text(
          text!,
          style: TextStyle(
            fontFamily: 'Rubik',
            fontSize: getProportionateScreenWidth(26),
            fontWeight: FontWeight.w500,
            color: AppColors.systemWhiteColor,
          ),
        ),
      ),
    );
  }
}

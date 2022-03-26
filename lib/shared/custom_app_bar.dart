import 'package:flutter/material.dart';
import 'package:kettik_business/shared/size_config.dart';
import 'package:kettik_business/shared/theme.dart';

class CustomAppBar extends PreferredSize {
  final String title;

  CustomAppBar({
    Key? key,
    required this.title,
  }) : super(
          key: key,
          child: Container(),
          preferredSize: Size.fromHeight(
            getProportionateScreenHeight(140),
          ),
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
      ),
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.whiteColor,
          fontSize: getProportionateScreenWidth(36),
        ),
      ),
    );
  }
}

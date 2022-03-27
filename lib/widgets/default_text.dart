
import 'package:flutter/material.dart';
import 'package:kettik_business/shared/size_config.dart';

import '../shared/theme.dart';

class DefaultText extends StatelessWidget {
  final String text;
  final FontWeight? fontWeight;
  final double fontSize;
  final Color? color;
  final bool? isCenter;

  DefaultText({
    required this.text,
    this.fontWeight = FontWeight.w400,
    this.fontSize = 14,
    this.color = Colors.black,
    this.isCenter = true,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: isCenter! ? TextAlign.center : TextAlign.start,
      style: TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: getProportionateScreenHeight(fontSize),
      ),
    );
  }
}

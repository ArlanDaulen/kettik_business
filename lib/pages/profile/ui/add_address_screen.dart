import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../shared/size_config.dart';
import '../../../shared/theme.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/default_button.dart';

typedef OnAddressAdded = void Function(List<TextEditingController>);

class AddAddressScreen extends StatelessWidget {
  AddAddressScreen({Key? key, required this.onAddressAdded}) : super(key: key);
  final OnAddressAdded onAddressAdded;

  List<String> titles = [
    'Адрес компании',
    'Телефон компании',
    'Сайт',
  ];

  List<TextEditingController> controllers =
      List.generate(3, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          title: 'Добавить контакты',
          isWithBackButton: true,
        ),
        bottomSheet: Padding(
          padding: EdgeInsets.only(
            bottom: getProportionateScreenHeight(30),
            left: getProportionateScreenWidth(40),
            right: getProportionateScreenWidth(40),
          ),
          child: DefaultButton(
            text: 'Сохранить',
            press: () => Navigator.of(context).pop({
              onAddressAdded(controllers),
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

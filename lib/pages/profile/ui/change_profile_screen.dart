import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kettik_business/pages/profile/provider/profile_provider.dart';
import 'package:kettik_business/pages/profile/ui/widgets/avatar_bottom_sheet.dart';
import 'package:kettik_business/shared/size_config.dart';
import 'package:kettik_business/widgets/custom_app_bar.dart';
import 'package:kettik_business/widgets/default_button.dart';
import 'package:kettik_business/widgets/default_text.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../shared/theme.dart';

typedef OnProfileChanged = void Function(List<TextEditingController>);

class ChangeProfileScreen extends StatefulWidget {
  ChangeProfileScreen(
      {Key? key, required this.onProfileChanged, required this.model})
      : super(key: key);
  final OnProfileChanged onProfileChanged;
  final ProfileProvider model;

  @override
  State<ChangeProfileScreen> createState() => _ChangeProfileScreenState();
}

class _ChangeProfileScreenState extends State<ChangeProfileScreen> {
  List<String> titles = [
    'Имя',
    'E-mail',
    'Telegram',
    'What\'sapp',
  ];

  List<TextEditingController> controllers =
      List.generate(4, (index) => TextEditingController());

  File? image;
  void _onImagePicked(File? _image) {
    setState(() {
      image = _image;
    });
  }

  void _checkChanges() {
    controllers.forEach((element) {
      if (element.text != '') {
        widget.model.setUser(controllers, image!);
      } 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        title: 'Изменить профиль',
        isWithBackButton: true,
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(40),
          vertical: getProportionateScreenHeight(30),
        ),
        child: DefaultButton(
          text: 'Сохранить',
          press: () => Navigator.of(context).pop({
            widget.onProfileChanged,
            _checkChanges(),
          }),
        ),
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
                  image == null
                      ? SvgPicture.asset(
                          AppSvgImages.avatar_ic,
                          width: getProportionateScreenWidth(250),
                        )
                      : ClipOval(
                          child: Image.file(
                            image!,
                            width: getProportionateScreenWidth(250),
                            height: getProportionateScreenHeight(250),
                            fit: BoxFit.cover,
                          ),
                        ),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                  GestureDetector(
                      onTap: () => showModalBottomSheet(
                          backgroundColor: AppColors.whiteColor.withOpacity(0),
                          context: context,
                          builder: (context) {
                            return AvatarBottomSheet(
                                model: widget.model,
                                onImagePicked: _onImagePicked);
                          }),
                      child: DefaultText(
                        text: 'Выбрать фотографию',
                        color: AppColors.primaryColor,
                        fontSize: 28,
                      )),
                ],
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            ListView.separated(
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
                    keyboardType: index == 2 || index == 3
                        ? TextInputType.number
                        : index == 1
                            ? TextInputType.emailAddress
                            : TextInputType.name,
                    controller: controllers[index],
                    inputFormatters: [
                      if (index == 2 || index == 3) numberFormatter
                    ],
                    style: TextStyle(
                      fontSize: getProportionateScreenHeight(28),
                    ),
                    cursorColor: AppColors.systemBlackColor,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor:
                          AppColors.systemLightGrayColor.withOpacity(0.3),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      contentPadding: EdgeInsets.only(
                          left: getProportionateScreenWidth(20)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  var numberFormatter = MaskTextInputFormatter(
      mask: '+# (###) ###-##-##', filter: {'#': RegExp(r'[0-9]')});
}

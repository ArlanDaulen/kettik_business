import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kettik_business/pages/profile/provider/profile_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import '../../../../shared/size_config.dart';
import '../../../../shared/theme.dart';
import '../../../../widgets/default_text.dart';

typedef OnImagePicked = void Function(File? image);

class AvatarBottomSheet extends StatelessWidget {
  AvatarBottomSheet(
      {Key? key, required this.model, required this.onImagePicked})
      : super(key: key);
  final ProfileProvider model;
  final OnImagePicked onImagePicked;

  File? mainImage;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imagePermanent = await saveImagePermanently(image.path);
      this.mainImage = imagePermanent;
      log(mainImage!.toString());
      onImagePicked(mainImage!);
    } on PlatformException catch (e) {
      throw ('Failed to pick image : $e');
    }
  }

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');

    return File(imagePath).copy(image.path);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(40),
        vertical: getProportionateScreenHeight(40),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenHeight(15),
            ),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop({
                    pickImage(ImageSource.camera),
                  }),
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                      // horizontal: double.infinity,
                      vertical: getProportionateScreenHeight(20),
                    ),
                    child: DefaultText(
                      text: 'Снять фотографию',
                      color: AppColors.primaryColor,
                      fontSize: 32,
                    ),
                  ),
                ),
                const Divider(),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop({
                    pickImage(ImageSource.gallery),
                  }),
                  child: Container(
                    color: AppColors.primaryColor.withOpacity(0),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                      // horizontal: double.infinity,
                      vertical: getProportionateScreenHeight(20),
                    ),
                    child: DefaultText(
                      text: 'Открыть галерею',
                      color: AppColors.primaryColor,
                      fontSize: 32,
                    ),
                  ),
                ),
                model.isCanDelete ? const Divider() : const SizedBox(),
                model.isCanDelete
                    ? GestureDetector(
                        onTap: () =>
                            Navigator.of(context).pop(model.deleteImage()),
                        child: Container(
                          color: AppColors.primaryColor.withOpacity(0),
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                            // horizontal: double.infinity,
                            vertical: getProportionateScreenHeight(20),
                          ),
                          child: DefaultText(
                            text: 'Удалить фотографию',
                            color: AppColors.primaryColor,
                            fontSize: 32,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(35),
              ),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: DefaultText(
                text: 'Отменить',
                color: AppColors.primaryColor,
                fontSize: 32,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

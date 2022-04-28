import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kettik_business/base/base_provider.dart';
import 'package:kettik_business/pages/my_tour/provider/add_image_provider.dart';
import 'package:kettik_business/pages/my_tour/ui/edit_images.dart';
import 'package:kettik_business/shared/size_config.dart';
import 'package:kettik_business/shared/theme.dart';
import 'package:kettik_business/widgets/default_button.dart';

class AddImageScreen extends StatelessWidget {
  const AddImageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseProvider<AddImageProvider>(
        onReady: (_) => _.init(context),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              foregroundColor: AppColors.systemBlackColor,
              title: const Text(
                "Add images",
                style: TextStyle(
                  color: AppColors.systemBlackColor,
                  fontSize: 18,
                ),
              ),
              backgroundColor: AppColors.whiteColor,
            ),
            body: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    "Шаг 5. Добавьте изображения.",
                    style: TextStyle(
                        color: AppColors.systemBlackColor.withOpacity(0.7)),
                  ),
                  const SizedBox(height: 5),
                  model.images != null && model.images!.isEmpty
                      ? InkWell(
                          onTap: () async {
                            await model.loadImages(context);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            width: model.size!.width,
                            decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                boxShadow: [
                                  BoxShadow(
                                      color: AppColors.systemDarkGrayColor
                                          .withOpacity(0.2),
                                      offset: const Offset(0, 2),
                                      blurRadius: 3,
                                      spreadRadius: 3)
                                ],
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              "addImages".tr(),
                              style: const TextStyle(
                                  color: AppColors.systemBlackColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          ))
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CarouselSlider(
                              options: CarouselOptions(
                                  height: 250,
                                  viewportFraction: 0.95,
                                  autoPlay: true),
                              items: model.images!.map((i) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        decoration: const BoxDecoration(
                                            color: Colors.deepPurple),
                                        child: Image.file(
                                          File(i.path),
                                          fit: BoxFit.cover,
                                        ));
                                  },
                                );
                              }).toList(),
                            ),
                            SizedBox(height: getProportionateScreenHeight(40)),
                            Container(
                              padding: EdgeInsets.only(
                                  right: getProportionateScreenWidth(30)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      // await model.addImages(context);
                                      await model.loadImages(context);
                                    },
                                    child: Container(
                                      width: model.size!.width * 0.2,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      decoration: BoxDecoration(
                                          color: AppColors.primaryColor
                                              .withOpacity(0.8),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: const Text(
                                        "Add",
                                        style: TextStyle(
                                            color: AppColors.whiteColor),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      width: getProportionateScreenWidth(20)),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => EditImagesScreen(
                                                    addImageProvider: model,
                                                  )));
                                    },
                                    child: Container(
                                      width: model.size!.width * 0.2,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      decoration: BoxDecoration(
                                          color: AppColors.primaryColor
                                              .withOpacity(0.8),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: const Text(
                                        "Edit",
                                        style: TextStyle(
                                            color: AppColors.whiteColor),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      width: getProportionateScreenWidth(20)),
                                  InkWell(
                                    onTap: () {
                                      _clearDialog(context, model);
                                    },
                                    child: Container(
                                      width: model.size!.width * 0.2,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      decoration: BoxDecoration(
                                          color: AppColors.systemRedColor
                                              .withOpacity(0.7)
                                              .withOpacity(0.8),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: const Text(
                                        "Clear",
                                        style: TextStyle(
                                            color: AppColors.whiteColor),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: getProportionateScreenHeight(20)),
                          ],
                        ),
                ],
              ),
            ),
            floatingActionButton: DefaultButton(
              text: model.images!.isEmpty ? "Пропустить" : "Завершить",
              width: model.size!.width * 0.9,
              press: () async {
                await model.addImages(context);
              },
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          );
        },
        model: AddImageProvider());
  }
}

_clearDialog(BuildContext context, AddImageProvider createTourProvider) {
  return showDialog(
    context: context,
    builder: (_) => CupertinoAlertDialog(
      title: Text(
        'Вы действительно хотите очистить картинки?',
        style: TextStyle(
          fontSize: getProportionateScreenHeight(36),
        ),
      ),
      actions: [
        CupertinoDialogAction(
          child: Text(
            'Нет',
            style: TextStyle(
              fontSize: getProportionateScreenHeight(32),
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text(
            'Да',
            style: TextStyle(
              fontSize: getProportionateScreenHeight(32),
            ),
          ),
          onPressed: () {
            createTourProvider.clearImages();
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}

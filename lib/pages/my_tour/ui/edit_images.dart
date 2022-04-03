import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kettik_business/base/base_provider.dart';
import 'package:kettik_business/pages/my_tour/provider/create_tour_provider.dart';
import 'package:kettik_business/pages/my_tour/provider/edit_images_provider.dart';
import 'package:kettik_business/shared/size_config.dart';
import 'package:kettik_business/shared/theme.dart';
import 'package:kettik_business/widgets/loading_view.dart';

class EditImagesScreen extends StatelessWidget {
  // final List<XFile> images;
  final CreateTourProvider createTourProvider;
  EditImagesScreen({required this.createTourProvider});
  @override
  Widget build(BuildContext context) {
    return BaseProvider<EditImagesProvider>(
        onReady: (_) => _.init(context),
        builder: (context, model, child) {
          return model.isLoading
              ? const LoadingView()
              : Scaffold(
                  appBar: AppBar(
                    elevation: 0,
                    leading: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    title: const Text(
                      "Editing",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            model.applyChanges(context, createTourProvider);
                          },
                          child: Text(
                            "Apply",
                            style: TextStyle(
                                fontSize: getProportionateScreenHeight(33),
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ))
                    ],
                    backgroundColor: AppColors.bgColor,
                    centerTitle: true,
                  ),
                  body: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListView.separated(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: createTourProvider.images!.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider(height: 50, thickness: 1);
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: model.size!.width,
                                  child: Image.file(
                                    File(
                                        createTourProvider.images![index].path),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                    height: getProportionateScreenHeight(50)),
                                SizedBox(
                                  width: model.size!.width,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          model.replaceThisImage(context,
                                              createTourProvider, index);
                                        },
                                        child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical:
                                                    getProportionateScreenHeight(
                                                        20)),
                                            width: model.size!.width * 0.4,
                                            decoration: BoxDecoration(
                                                color: AppColors.bgBlueColor
                                                    .withOpacity(0.8)
                                                    .withOpacity(0.9),
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: const Text(
                                              "Replace",
                                              style: TextStyle(
                                                color: AppColors.whiteColor,
                                              ),
                                              textAlign: TextAlign.center,
                                            )),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          model.deleteThisImage(context,
                                              createTourProvider, index);
                                        },
                                        child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical:
                                                    getProportionateScreenHeight(
                                                        20)),
                                            width: model.size!.width * 0.4,
                                            decoration: BoxDecoration(
                                                color: AppColors.systemRedColor
                                                    .withOpacity(0.9),
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: const Text(
                                              "Delete",
                                              style: TextStyle(
                                                color: AppColors.whiteColor,
                                              ),
                                              textAlign: TextAlign.center,
                                            )),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ));
        },
        model: EditImagesProvider());
  }
}

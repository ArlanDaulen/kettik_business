import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kettik_business/base/base_bloc.dart';
import 'package:kettik_business/pages/my_tour/provider/add_image_provider.dart';
import 'package:kettik_business/pages/my_tour/provider/create_tour_provider.dart';
import 'package:kettik_business/shared/size_config.dart';

class EditImagesProvider extends BaseBloc {
  Size? size;

  init(BuildContext context) {
    setLoading(true);
    size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    setLoading(false);
  }

  void deleteThisImage(
      BuildContext context, AddImageProvider createTourProvider, int index) {
    createTourProvider.deleteImageByXFile(createTourProvider.images![index]);
    notifyListeners();
  }

  void replaceThisImage(BuildContext context,
      AddImageProvider createTourProvider, int index) async {
    await createTourProvider
        .replaceImageByXFile(createTourProvider.images![index]);
    notifyListeners();
  }

  void applyChanges(BuildContext context, AddImageProvider createTourProvider) {
    Navigator.pop(context);
  }
}

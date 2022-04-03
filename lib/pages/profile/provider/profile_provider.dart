import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kettik_business/base/base_bloc.dart';
import 'package:kettik_business/shared/size_config.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import '../../../app/data/models/user_profile_model.dart';

class ProfileProvider extends BaseBloc {
  String currentCity = 'Almaty';

  UserProfile user = UserProfile(
    id: 1,
    fullName: 'Amangeldi Spatay',
    email: 'arlanvladelets@gmail.com',
    phone: '+7 (705) 278-07-38',
    telegramPhone: '+7 (705) 278-07-38',
    whatsappPhone: '+7 (705) 278-07-38',
    image: null,
  );

  File? image;

  init(BuildContext context) {
    setLoading(true);
    SizeConfig().init(context);

    setLoading(false);
  }

  setCurrentCity(String city) {
    currentCity = city;
    notifyListeners();
    log(currentCity);
  }

  setUser(List<TextEditingController> controllers, File? _image) {
    user = user.copyWith(
      fullName: controllers[0].text,
      email: controllers[1].text,
      telegramPhone: controllers[2].text,
      whatsappPhone: controllers[3].text,
      image: _image!,
    );
    notifyListeners();
  }

  // Future pickImage(ImageSource source) async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: source);
  //     notifyListeners();
  //     if (image == null) return;
  //     final imagePermanent = await saveImagePermanently(image.path);
  //     this.image = imagePermanent;
  //     setIsCanDelete(true);
  //     notifyListeners();
  //     log(image.toString());
  //   } on PlatformException catch (e) {
  //     throw ('Failed to pick image : $e');
  //   }
  // }

  // Future<File> saveImagePermanently(String imagePath) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final name = basename(imagePath);
  //   final image = File('${directory.path}/$name');

  //   return File(imagePath).copy(image.path);
  // }

  bool isCanDelete = false;
  setIsCanDelete(bool value) {
    isCanDelete = value;
    notifyListeners();
  }

  deleteImage() {
    image = null;
    // ProfileProvider().profileModel!.image = '';
    setIsCanDelete(false);
    notifyListeners();
  }
}

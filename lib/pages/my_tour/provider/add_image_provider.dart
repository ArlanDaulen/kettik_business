import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kettik_business/base/base_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:kettik_business/pages/my_tour/ui/result_of_created_tour.dart';

class AddImageProvider extends BaseBloc {
  List<XFile>? images = [];
  Size? size;

  init(BuildContext context) {
    setLoading(true);
    size = MediaQuery.of(context).size;
    setLoading(false);
  }

  Future<void> uploadImage() async {
    String url = "EbalIaTvoiRot.com";
    var request = http.MultipartRequest('POST', Uri.parse(url));
    for (XFile xFile in images!) {
      request.files.add(http.MultipartFile(
          'image',
          File(xFile.path).readAsBytes().asStream(),
          File(xFile.path).lengthSync(),
          filename: xFile.path.split("/").last));
    }
    var res = await request.send();

    res.statusCode == 200
        ? log("SUCCESS UPLOAD")
        : log("FAILED statuc code is ${res.statusCode}");
  }

  loadImages(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    var imagesWithoutCroppedList = await _picker.pickMultiImage();
    if (imagesWithoutCroppedList != null) {
      for (XFile xFile in imagesWithoutCroppedList) {
        File f = await cropImage(File(xFile.path));

        images!.add(XFile(f.path));
      }
    }

    notifyListeners();
  }

  cropImage(File imageFile) async {
    File? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [CropAspectRatioPreset.ratio16x9],
      androidUiSettings: const AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      iosUiSettings: const IOSUiSettings(
        minimumAspectRatio: 1.0,
      ),
    );
    if (croppedFile != null) {
      return croppedFile;
    }
    return null;
  }

  void clearImages() {
    images!.clear();
    notifyListeners();
  }

  void deleteImageByXFile(XFile xFile) {
    images!.remove(xFile);
    notifyListeners();
  }

  replaceImageByXFile(XFile xFileForDelete) async {
    final ImagePicker _picker = ImagePicker();
    XFile? choosedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (choosedImage != null) {
      File f = await cropImage(File(choosedImage.path));
      images![images!.indexOf(xFileForDelete)] = XFile(f.path);
      notifyListeners();
    }
  }

  addImages(BuildContext context) {
    //TODO? send images and check success - after push to result page
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const ResultOfCreatedTourScreen()),
        (route) => false);
  }
}

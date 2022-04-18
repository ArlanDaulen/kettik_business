import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kettik_business/app/data/models/place_model.dart';
import 'package:kettik_business/base/base_bloc.dart';
import 'package:kettik_business/pages/my_tour/ui/add_image.dart';
import 'package:kettik_business/shared/size_config.dart';
import 'package:intl/src/intl/date_format.dart';
import 'package:http/http.dart' as http;

class CreateTourProvider extends BaseBloc {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceOfTourController = TextEditingController();
  List<TourDateAndCountPersonsModel> tourDateAndCountPersonsList = [];

  String city = "Алматы";

  // List<XFile>? images = [];
  List<String> cities = [
    "Алматы",
    "Астана",
    "Тараз",
    "Кызылорда",
  ];

  List<PlaceModel> placesList = [];

  List<String> containList = [
    "Услуги профессионального гида",
    "Комфортабельный транспорт",
    "Крутой костер 🔥",
    "Вечерняя программа"
  ];

  Size? size;

  init(BuildContext context, List<PlaceModel> choosedPlaces) {
    setLoading(true);
    size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    placesList = choosedPlaces;
    addTourDateAndCountPersonsToList();
    setLoading(false);
  }

  // Future<void> uploadImage() async {
  //   String url = "EbalIaTvoiRot.com";
  //   var request = http.MultipartRequest('POST', Uri.parse(url));
  //   for (XFile xFile in images!) {
  //     request.files.add(http.MultipartFile(
  //         'image',
  //         File(xFile.path).readAsBytes().asStream(),
  //         File(xFile.path).lengthSync(),
  //         filename: xFile.path.split("/").last));
  //   }
  //   var res = await request.send();

  //   res.statusCode == 200
  //       ? log("SUCCESS UPLOAD")
  //       : log("FAILED statuc code is ${res.statusCode}");
  // }

  getDateRangeOfTour(TourDateAndCountPersonsModel tourDateAndCountPersons) {
    return getDateFormattedTextForView(tourDateAndCountPersons.fromDate) +
        " - " +
        getDateFormattedTextForView(tourDateAndCountPersons.toDate);
  }

  getDateFormattedTextForView(DateTime dateTime) {
    return DateFormat('dd.MM').format(dateTime);
  }

  void setCity(String newValue) {
    city = newValue;
    notifyListeners();
  }

  void setFromDate(
      DateTime dateTime, TourDateAndCountPersonsModel tourDateAndCountPersons) {
    tourDateAndCountPersons.fromDate = dateTime;
    notifyListeners();
  }

  void setToDate(
      DateTime dateTime, TourDateAndCountPersonsModel tourDateAndCountPersons) {
    tourDateAndCountPersons.toDate = dateTime;
    notifyListeners();
  }

  getCountRangeTextList() {
    List<Text> list = [];
    for (int i = 10; i <= 40; i++) {
      list.add(Text(i.toString()));
    }
    return list;
  }

  getCountRange() {
    List<int> list = [];
    for (int i = 10; i <= 40; i++) {
      list.add(i);
    }
    return list;
  }

  void setCountOfPerson(
      value, TourDateAndCountPersonsModel tourDateAndCountPersons) {
    tourDateAndCountPersons.countPersonsOfTour = getCountRange()[value];
    notifyListeners();
  }

  void setContainList(List<String> newContainList) {
    containList = newContainList;
    notifyListeners();
  }

  // void setPlacesList(List<PlaceModel> newPlaceList) {
  //   placesList = newPlaceList;
  //   notifyListeners();
  // }

  void addMoreDatesForTours() {
    addTourDateAndCountPersonsToList();
  }

  void addTourDateAndCountPersonsToList() {
    TourDateAndCountPersonsModel t = TourDateAndCountPersonsModel(
        fromDate: DateTime.now().add(const Duration(days: 21)),
        toDate: DateTime.now().add(const Duration(days: 22)),
        countPersonsOfTour: 10);
    tourDateAndCountPersonsList.add(t);
    notifyListeners();
  }

  void deleteDateAndCountOfPersons(int index) {
    tourDateAndCountPersonsList.removeAt(index);
    notifyListeners();
  }

  createTour(BuildContext context) async {
    setIsSendRequest(true);
    //TODO request to create tour
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const AddImageScreen()));
    setIsSendRequest(false);
  }

  // loadImages(BuildContext context) async {
  //   final ImagePicker _picker = ImagePicker();
  //   var imagesWithoutCroppedList = await _picker.pickMultiImage();
  //   if (imagesWithoutCroppedList != null) {
  //     for (XFile xFile in imagesWithoutCroppedList) {
  //       File f = await cropImage(File(xFile.path));

  //       images!.add(XFile(f.path));
  //     }
  //   }

  //   notifyListeners();
  // }

  // cropImage(File imageFile) async {
  //   File? croppedFile = await ImageCropper().cropImage(
  //     sourcePath: imageFile.path,
  //     aspectRatioPresets: [CropAspectRatioPreset.ratio16x9],
  //     androidUiSettings: const AndroidUiSettings(
  //         toolbarTitle: 'Cropper',
  //         toolbarColor: Colors.deepOrange,
  //         toolbarWidgetColor: Colors.white,
  //         initAspectRatio: CropAspectRatioPreset.original,
  //         lockAspectRatio: false),
  //     iosUiSettings: const IOSUiSettings(
  //       minimumAspectRatio: 1.0,
  //     ),
  //   );
  //   if (croppedFile != null) {
  //     return croppedFile;
  //   }
  //   return null;
  // }

  // addImages(BuildContext context) async {
  //   final ImagePicker _picker = ImagePicker();
  //   List<XFile>? additionalImages = await _picker.pickMultiImage();

  //   if (additionalImages != null) {
  //     additionalImages.forEach((element) {
  //       images!.add(element);
  //     });
  //   }

  //   notifyListeners();
  // }

  // void clearImages() {
  //   images!.clear();
  //   notifyListeners();
  // }

  // void deleteImageByXFile(XFile xFile) {
  //   images!.remove(xFile);
  //   notifyListeners();
  // }

//   replaceImageByXFile(XFile xFileForDelete) async {
//     final ImagePicker _picker = ImagePicker();
//     XFile? choosedImage = await _picker.pickImage(source: ImageSource.gallery);

//     if (choosedImage != null) {
//       File f = await cropImage(File(choosedImage.path));
//       images![images!.indexOf(xFileForDelete)] = XFile(f.path);
//       notifyListeners();
//     }
//   }
}

class TourDateAndCountPersonsModel {
  DateTime fromDate = DateTime.now().add(const Duration(days: 21));
  DateTime toDate = DateTime.now().add(const Duration(days: 22));
  int countPersonsOfTour = 10;
  TourDateAndCountPersonsModel(
      {required this.fromDate,
      required this.toDate,
      required this.countPersonsOfTour});
}

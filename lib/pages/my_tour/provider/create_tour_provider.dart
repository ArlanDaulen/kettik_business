import 'package:flutter/material.dart';
import 'package:kettik_business/app/data/models/place_model.dart';
import 'package:kettik_business/base/base_bloc.dart';
import 'package:kettik_business/shared/size_config.dart';
import 'package:intl/src/intl/date_format.dart';

class CreateTourProvider extends BaseBloc {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceOfTourController = TextEditingController();
  List<TourDateAndCountPersonsModel> tourDateAndCountPersonsList = [];

  String city = "Алматы";
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
  var testImages = [
    "https://poehali.kz/upload/iblock/967/967f5166b65098f4aa8f0c918a155326.jpg",
    "https://static.tildacdn.com/tild6233-3838-4738-b961-366635366463/412A8269_.JPG",
    "https://avatars.mds.yandex.net/get-altay/1525683/2a0000016abd21f373347a5e15e4a92645cf/XXL",
    "https://im0-tub-kz.yandex.net/i?id=52624fc5c5278486c8ab6b676e35ccd9-l&n=13",
    "https://funart.pro/uploads/posts/2021-04/thumbs/1617302291_19-p-oboi-mertvoe-ozero-kazakhstan-21.jpg",
    "https://adrenalinicsilence.kz/wp-content/uploads/2016/12/kolsaykayndy22.jpg",
  ];

  Size? size;

  init(BuildContext context) {
    setLoading(true);
    size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    addTourDateAndCountPersonsToList();
    setLoading(false);
  }

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

  void setPlacesList(List<PlaceModel> newPlaceList) {
    placesList = newPlaceList;
    notifyListeners();
  }

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

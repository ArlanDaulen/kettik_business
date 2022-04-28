import 'package:flutter/material.dart';
import 'package:kettik_business/base/base_bloc.dart';
import 'package:kettik_business/pages/my_tour/ui/add_image.dart';
import 'package:kettik_business/shared/size_config.dart';
import 'package:intl/src/intl/date_format.dart';

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

  Size? size;

  init(BuildContext context) {
    setLoading(true);
    size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    // placesList = choosedPlaces;
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

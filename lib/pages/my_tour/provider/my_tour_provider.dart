import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kettik_business/base/base_bloc.dart';
import 'package:kettik_business/shared/size_config.dart';
import 'package:kettik_business/shared/theme.dart';

class MyTourProvider extends BaseBloc {
  TextEditingController searchController = TextEditingController();
  Size? size;
  List<TourTestModel> tourList = [];
  List<bool> tourListShowTextList = [];

  String filterType = "";
  String filterTypeGroup = "";
  List<String> filterTypesList = [
    "Сначала горячие",
    "Сначала новые",
    "От дешевых к дорогим",
    "От дорогих к дешевым",
  ];

  init(BuildContext context) {
    setLoading(true);
    size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    fillTourList();
    generateTourListShowTextList();
    setLoading(false);
  }

  generateTourListShowTextList() {
    tourList.forEach((element) {
      if (element.description!.length <= 150) {
        tourListShowTextList.add(true);
      } else {
        tourListShowTextList.add(false);
      }
    });
    notifyListeners();
  }

  void fillTourList() {
    tourList = [
      TourTestModel(
        name: "Atlyn-emel",
        city: "Алматы, Казахстан",
        rating: 8.5,
        timeRange: "12.04 - 17.04, 5 ночей",
        countOfPlaces: 50,
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      ),
      TourTestModel(
        name: "Atlyn-emel",
        city: "Алматы, Казахстан",
        rating: 8.5,
        timeRange: "12.04 - 17.04, 5 ночей",
        countOfPlaces: 50,
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      ),
      TourTestModel(
        name: "Atlyn-emel",
        city: "Алматы, Казахстан",
        rating: 8.5,
        timeRange: "12.04 - 17.04, 5 ночей",
        countOfPlaces: 50,
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      ),
      TourTestModel(
        name: "Atlyn-emel",
        city: "Алматы, Казахстан",
        rating: 8.5,
        timeRange: "12.04 - 17.04, 5 ночей",
        countOfPlaces: 50,
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
      ),
      TourTestModel(
        name: "Atlyn-emel",
        city: "Алматы, Казахстан",
        rating: 8.5,
        timeRange: "12.04 - 17.04, 5 ночей",
        countOfPlaces: 50,
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      ),
    ];
    notifyListeners();
  }

  getShortText(String text, int index) {
    if (text.length >= 150) {
      return TextButton(
          onPressed: () {
            tourListShowTextList[index] = !tourListShowTextList[index];
            notifyListeners();
          },
          child: tourListShowTextList[index]
              ? Text(
                  text,
                  style: getStyleForDescriptionText(),
                )
              : Text(
                  text.substring(0, 150) + " ...  more",
                  style: getStyleForDescriptionText(),
                ));
    }
    return Text(
      text,
      style: getStyleForDescriptionText(),
    );
  }

  TextStyle getStyleForDescriptionText() {
    return TextStyle(color: Colors.black87);
  }

  setTourShowTextList(int index) {
    log("index is: $index");
    tourListShowTextList[index] = !tourListShowTextList[index];

    notifyListeners();
  }
}

class TourTestModel {
  String? name;
  String? city;
  double? rating;
  String? timeRange;
  int? countOfPlaces;
  String? description;

  TourTestModel({
    required this.name,
    required this.city,
    required this.rating,
    required this.timeRange,
    required this.countOfPlaces,
    required this.description,
  });
}

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:kettik_business/app/data/models/place_model.dart';
import 'package:kettik_business/base/base_bloc.dart';
import 'package:kettik_business/pages/my_tour/ui/create_tour.dart';
import 'package:kettik_business/shared/size_config.dart';

class AddPlaceProvider extends BaseBloc {
  Size? size;
  List<PlaceModel> placeList = [];
  TextEditingController controller = TextEditingController();
  List<bool> isChoosedTestList = [];
  init(BuildContext context) {
    setLoading(true);
    size = MediaQuery.of(context).size;
    isChoosedTestList = List.generate(testPlaces.length, (index) => false);
    SizeConfig().init(context);
    setLoading(false);
  }

  void addItemToContainListBySearch() {
    //TODO request
  }

  void deleteItemFromContainList(int index) {
    placeList.removeAt(index);
    notifyListeners();
  }

  void save(BuildContext context) {
    if (placeList.isNotEmpty) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => CreateTourScreen(placeList: placeList)));
    } else {
      showMessageAboutEmptyPlaces(context);
    }
  }

  void showMessageAboutEmptyPlaces(BuildContext context) {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.info,
      title: "",
      text: "Place list can't be empty!",
    );
  }

  void addPlaceToPlaceList(PlaceModel placeModel) {
    placeList.add(placeModel);
    notifyListeners();
  }

  // --------------------
  List<PlaceModel> testPlaces = [
    PlaceModel(name: "Чарын", lattitude: "", longitude: "", isMain: false),
    PlaceModel(name: "Kolsai", lattitude: "", longitude: "", isMain: false),
    PlaceModel(name: "Qaiyndy", lattitude: "", longitude: "", isMain: false),
    PlaceModel(
        name: "Zherdyn bir zheri", lattitude: "", longitude: "", isMain: false),
    PlaceModel(
        name: "Globustyn' шеті", lattitude: "", longitude: "", isMain: false),
  ];

  void addOrDeleteInList(int index) {
    isChoosedTestList[index] = !isChoosedTestList[index];
    placeList.add(testPlaces[index]);
    notifyListeners();
  }
}

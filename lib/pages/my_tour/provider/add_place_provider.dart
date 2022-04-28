import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:kettik_business/app/data/models/place_model.dart';
import 'package:kettik_business/base/base_bloc.dart';
import 'package:kettik_business/pages/my_tour/ui/add_favour.dart';
import 'package:kettik_business/pages/my_tour/ui/create_place.dart';
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
          builder: (_) => AddFavourScreen(placeList: placeList),
        ),
      );
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
    PlaceModel(
      name: "Чарын",
      lattitude: "",
      longitude: "",
    ),
    PlaceModel(
      name: "Kolsai",
      lattitude: "",
      longitude: "",
    ),
    PlaceModel(
      name: "Qaiyndy",
      lattitude: "",
      longitude: "",
    ),
    PlaceModel(
      name: "Zherdyn bir zheri",
      lattitude: "",
      longitude: "",
    ),
    PlaceModel(
      name: "Globustyn' шеті",
      lattitude: "",
      longitude: "",
    ),
  ];

  void addOrDeleteInList(int index) {
    isChoosedTestList[index] = !isChoosedTestList[index];
    if (isChoosedTestList[index]) {
      placeList.add(testPlaces[index]);
    } else {
      placeList.remove(testPlaces[index]);
    }
    notifyListeners();
  }

  void navigateToAddFavour(BuildContext context) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (_) => AddFavourScreen(
    //       placeList: placeList,
    //     ),
    //   ),
    // );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CreatePlaceScreen(
          addPlaceProvider: this,
        ),
      ),
    );
  }
}

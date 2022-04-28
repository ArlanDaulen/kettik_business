import 'package:flutter/material.dart';
import 'package:kettik_business/app/data/models/favour_model.dart';
import 'package:kettik_business/app/data/models/place_model.dart';
import 'package:kettik_business/base/base_bloc.dart';

import '../ui/add_item.dart';

class AddFavourProvider extends BaseBloc {
  Size? size;
  List<FavourModel> favourList = [];
  TextEditingController controller = TextEditingController();
  List<bool> isChoosedTestList = [];

  init(BuildContext context) {
    setLoading(true);
    size = MediaQuery.of(context).size;
    isChoosedTestList = List.generate(testFavours.length, (index) => false);
    setLoading(false);
  }

  List<FavourModel> testFavours = [
    FavourModel(id: 1, name: "Конная прогулка"),
    FavourModel(
        id: 2, name: "Услуги гида (гидка карап журындер ,озы адасып кетед)"),
    FavourModel(id: 3, name: "Большой костер вечером"),
  ];

  void deleteItemFromContainList(int index) {}

  // TODO need method when create favour , Navigator.pop with adding new favour to list

  void saveAndNavigateToAddItems(
      BuildContext context, List<PlaceModel> placesList) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            AddItemScreen(placesList: placesList, favourList: favourList),
      ),
    );
  }

  void addOrDeleteInList(int index) {
    isChoosedTestList[index] = !isChoosedTestList[index];
    if (isChoosedTestList[index]) {
      favourList.add(testFavours[index]);
    } else {
      favourList.remove(testFavours[index]);
    }
    notifyListeners();
  }

  void navigateToAddItems(BuildContext context, List<PlaceModel> placeList) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddItemScreen(
          placesList: placeList,
          favourList: favourList,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kettik_business/app/data/models/favour_model.dart';
import 'package:kettik_business/app/data/models/place_model.dart';
import 'package:kettik_business/base/base_bloc.dart';

import '../ui/add_item.dart';

class AddFavourProvider extends BaseBloc {
  Size? size;
  List<FavourModel> favourList = [];
  TextEditingController controller = TextEditingController();
  List<FavourModel> testFavours = [];
  List<bool> isChoosedTestList = [];
  List<PlaceModel>? placeList;

  init(BuildContext context, List<PlaceModel> list) {
    setLoading(true);
    size = MediaQuery.of(context).size;
    placeList = list;
    setLoading(false);
  }

  void deleteItemFromContainList(int index) {}

  void save(BuildContext context) {
     Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddItemScreen(
          placesList: placeList!,
          favourList: favourList,
        ),
      ),
    );
  }

  void navigateToAddItems(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddItemScreen(
          placesList: placeList!,
          favourList: favourList,
        ),
      ),
    );
  }

  void addOrDeleteInList(int index) {}
}

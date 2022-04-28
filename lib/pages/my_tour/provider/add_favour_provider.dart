import 'package:flutter/material.dart';
import 'package:kettik_business/app/data/models/favour_model.dart';
import 'package:kettik_business/base/base_bloc.dart';

class AddFavourProvider extends BaseBloc {
  Size? size;
  List<FavourModel> favourList = [];
  TextEditingController controller = TextEditingController();
  List<FavourModel> testFavours = [];
  List<bool> isChoosedTestList = [];

  init(BuildContext context) {
    setLoading(true);
    size = MediaQuery.of(context).size;
    setLoading(false);
  }

  void deleteItemFromContainList(int index) {}

  void save(BuildContext context) {}

  void navigateToAddItems(BuildContext context) {}

  void addOrDeleteInList(int index) {}
}

import 'package:flutter/material.dart';
import 'package:kettik_business/base/base_bloc.dart';
import 'package:kettik_business/shared/size_config.dart';

class AddItemProvider extends BaseBloc {
  Size? size;
  List<String> containList = [];
  TextEditingController controller = TextEditingController();

  init(BuildContext context) {
    setLoading(true);
    size = MediaQuery.of(context).size;

    SizeConfig().init(context);
    setLoading(false);
  }

  void addItemToContainList() {
    if (controller.text.isNotEmpty) {
      containList.add(controller.text);
      notifyListeners();
    }
    controller.text = "";
    notifyListeners();
  }

  void deleteItemFromContainList(int index) {
    containList.removeAt(index);
    notifyListeners();
  }

  void navigateToServicesAddScreen(BuildContext context) {}

  void save(BuildContext context) {}
}

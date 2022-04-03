import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kettik_business/base/base_bloc.dart';
import 'package:kettik_business/pages/my_tour/provider/create_tour_provider.dart';
import 'package:kettik_business/shared/size_config.dart';
import 'package:kettik_business/shared/theme.dart';

class AddContainProvider extends BaseBloc {
  Size? size;
  List<String> containList = [];
  TextEditingController controller = TextEditingController();

  init(BuildContext context, CreateTourProvider createTourProvider) {
    setLoading(true);
    size = MediaQuery.of(context).size;
    containList = createTourProvider.containList;
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

  void save(BuildContext context, CreateTourProvider createTourProvider) {
    createTourProvider.setContainList(containList);
    Navigator.pop(context);
  }
}

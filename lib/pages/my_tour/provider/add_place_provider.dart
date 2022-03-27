import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kettik_business/app/data/models/place_model.dart';
import 'package:kettik_business/base/base_bloc.dart';
import 'package:kettik_business/pages/my_tour/provider/create_tour_provider.dart';
import 'package:kettik_business/shared/size_config.dart';

class AddPlaceProvider extends BaseBloc {
  Size? size;
  List<PlaceModel> placeList = [];
  TextEditingController controller = TextEditingController();

  init(BuildContext context, CreateTourProvider createTourProvider) {
    setLoading(true);
    size = MediaQuery.of(context).size;
    placeList = createTourProvider.placesList;
    SizeConfig().init(context);
    setLoading(false);
  }

  void addItemToContainList() {
    if (controller.text.isNotEmpty) {
      PlaceModel p = PlaceModel(
          name: controller.text,
          lattitude: "lattitude",
          longitude: "longitude",
          isMain: false);
      placeList.add(p);
      notifyListeners();
    }
    controller.text = "";
    notifyListeners();
  }

  void deleteItemFromContainList(int index) {
    placeList.removeAt(index);
    notifyListeners();
  }

  void save(BuildContext context, CreateTourProvider createTourProvider) {
    createTourProvider.setPlacesList(placeList);
    Navigator.pop(context);
  }
}

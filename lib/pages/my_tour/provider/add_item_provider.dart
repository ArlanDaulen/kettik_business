import 'package:flutter/material.dart';
import 'package:kettik_business/app/data/models/favour_model.dart';
import 'package:kettik_business/app/data/models/item_model.dart';
import 'package:kettik_business/app/data/models/place_model.dart';
import 'package:kettik_business/base/base_bloc.dart';
import 'package:kettik_business/pages/my_tour/ui/create_tour.dart';
import 'package:kettik_business/shared/size_config.dart';

class AddItemProvider extends BaseBloc {
  Size? size;
  List<ItemModel> itemList = [];
  TextEditingController controller = TextEditingController();
  int itemCount = 0;
  List<PlaceModel>? placeList;
  List<FavourModel>? favourList;

  init(
    BuildContext context,
    List<PlaceModel> _placeList,
    List<FavourModel> _favourList,
  ) {
    setLoading(true);
    size = MediaQuery.of(context).size;
    placeList = _placeList;
    favourList = _favourList;
    SizeConfig().init(context);
    setLoading(false);
  }

  void addItem() {
    itemList.add(
      ItemModel(
        id: itemCount,
        name: controller.text,
      ),
    );
    itemCount++;
    controller.text = '';
    notifyListeners();
  }

  void deleteItemFromContainList(int index) {
    itemList.removeAt(index);
    notifyListeners();
  }

  void navigateToCreateTourPage(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CreateTourScreen(
            placeList: placeList!,
            favourList: favourList!,
            itemList: itemList,
          ),
        ),
      );

  void save(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CreateTourScreen(
          placeList: placeList!,
          favourList: favourList!,
          itemList: itemList,
        ),
      ),
    );
  }
}

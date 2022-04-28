import 'package:flutter/material.dart';
import 'package:kettik_business/app/data/models/favour_model.dart';
import 'package:kettik_business/app/data/models/item_model.dart';
import 'package:kettik_business/app/data/models/place_model.dart';
import 'package:kettik_business/base/base_bloc.dart';
import 'package:kettik_business/pages/my_tour/ui/create_item.dart';
import 'package:kettik_business/pages/my_tour/ui/create_tour.dart';
import 'package:kettik_business/shared/size_config.dart';

class AddItemProvider extends BaseBloc {
  Size? size;
  List<ItemModel> itemList = [];
  TextEditingController controller = TextEditingController();
  int itemCount = 0;
  List<bool> isChoosedTestList = [];

  init(
    BuildContext context,
  ) {
    setLoading(true);
    size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    isChoosedTestList = List.generate(testItems.length, (index) => false);
    setLoading(false);
  }

  List<ItemModel> testItems = [
    ItemModel(id: 1, name: "Плед"),
    ItemModel(id: 2, name: "Фонари"),
    ItemModel(id: 3, name: "Палатки"),
  ];
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

  void addOrDeleteInList(int index) {
    isChoosedTestList[index] = !isChoosedTestList[index];
    if (isChoosedTestList[index]) {
      itemList.add(testItems[index]);
    } else {
      itemList.remove(testItems[index]);
    }
    notifyListeners();
  }

  void deleteItemFromContainList(int index) {
    itemList.removeAt(index);
    notifyListeners();
  }

  void navigateToCreateTourPage(BuildContext context,
          List<PlaceModel> placeList, List<FavourModel> favourList) =>
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CreateTourScreen(
            placesList: placeList,
            favourList: favourList,
            itemList: itemList,
          ),
        ),
      );

  void toCreateItem(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => CreateItemScreen(
                  addItemProvider: this,
                )));
  }
}

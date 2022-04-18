import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kettik_business/base/base_bloc.dart';

class TourDetailProvider extends BaseBloc {
  Size? size;
  bool isMoreInfoShow = false;
  bool isServiceShow = false;
  bool isAdditionLocationsShow = false;

  init(BuildContext context, int id) {
    setLoading(true);
    //TODO get detail info about tour by id
    size = MediaQuery.of(context).size;
    setLoading(false);
  }

  var testImages = [
    "https://poehali.kz/upload/iblock/967/967f5166b65098f4aa8f0c918a155326.jpg",
    "https://static.tildacdn.com/tild6233-3838-4738-b961-366635366463/412A8269_.JPG",
    "https://avatars.mds.yandex.net/get-altay/1525683/2a0000016abd21f373347a5e15e4a92645cf/XXL",
    "https://im0-tub-kz.yandex.net/i?id=52624fc5c5278486c8ab6b676e35ccd9-l&n=13",
    "https://funart.pro/uploads/posts/2021-04/thumbs/1617302291_19-p-oboi-mertvoe-ozero-kazakhstan-21.jpg",
    "https://adrenalinicsilence.kz/wp-content/uploads/2016/12/kolsaykayndy22.jpg",
  ];

  var testServices = [
    "Вкусный обед",
    "Конная прогулка",
    "Классные фотки",
  ];

  List<String> testAdditionalLocations = [
    "Колсай",
    "Чунджа",
    "Арланнын уйы",
  ];

  toggleIsAdditionalLocationsShow() {
    isAdditionLocationsShow = !isAdditionLocationsShow;
    notifyListeners();
  }

  toggleIsMoreInfo() {
    isMoreInfoShow = !isMoreInfoShow;
    notifyListeners();
  }

  toggleIsServiceShow() {
    isServiceShow = !isServiceShow;
    notifyListeners();
  }
}

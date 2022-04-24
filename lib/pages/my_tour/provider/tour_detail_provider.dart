import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kettik_business/app/data/models/client_model.dart';
import 'package:kettik_business/base/base_bloc.dart';

class TourDetailProvider extends BaseBloc {
  Size? size;
  bool isMoreInfoShow = false;
  bool isServiceShow = false;
  bool isAdditionLocationsShow = false;
  bool isShowClients = false;

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

  String description =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";

  List<ClientModel> clients = [
    ClientModel(
        name: "Asylzhanovna Natasha",
        phone: "+7 707 934 2344",
        status: "ВСЁ ЕЩЁ СПИТ"),
    ClientModel(
        name: "Arlan Daulen", phone: "+7 702 123 2344", status: "В ОЖИДАНИИ"),
    ClientModel(
        name: "Adilbekov Aliomar",
        phone: "+7 702 934 2344",
        status: "ОПЛАЧЕНО"),
    ClientModel(
        name: "Dauytbekov Meruert",
        phone: "+7 707 934 2344",
        status: "ОПЛАЧЕНО"),
    ClientModel(
        name: "Diplomov Sotka", phone: "+7 747 934 2344", status: "В ОЖИДАНИИ"),
    ClientModel(
        name: "Magistrova Tuseikgul",
        phone: "+7 705 934 2344",
        status: "В ОЖИДАНИИ"),
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

  void toggleClientsList() {
    isShowClients = !isShowClients;
    notifyListeners();
  }
}

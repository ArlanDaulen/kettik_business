import 'dart:developer';

import 'package:kettik_business/base/base_bloc.dart';
import 'package:kettik_business/pages/profile/provider/profile_provider.dart';

class ChooseCityProvider extends BaseBloc {
  ProfileProvider? profileProvider;

  List<bool> cityBools = List.generate(12, (index) => false);

  Map<int, String> cities = {
    0: 'Алматы',
    1: 'Нур-Султан (Астана)',
    2: 'Караганда',
    3: 'Шымкент',
    4: 'Актобе',
    5: 'Костанай',
    6: 'Актау',
    7: 'Уральск',
    8: 'Усть-Каменогорск',
    9: 'Атырау',
    10: 'Сарыбулак',
    11: 'Фабричный',
  };

  int? currentCityIndex;
  String? currentCity;

  initCity(context, ProfileProvider model) {
    setLoading(true);
    profileProvider = model;
    notifyListeners();
    cities.forEach((key, value) {
      if (profileProvider!.currentCity == value) {
        cityBools[key] = true;
        log(key.toString());
        currentCityIndex = key;
      }
    });
    notifyListeners();
    setLoading(false);
  }

  changeSelectedCity(int index) {
    currentCityIndex = cities.keys.firstWhere((element) => element == index);
    currentCity = cities.values.toList()[currentCityIndex!];
    for (int buttonIndex = 0; buttonIndex < cityBools.length; buttonIndex++) {
      if (buttonIndex == index) {
        cityBools[buttonIndex] = true;
      } else {
        cityBools[buttonIndex] = false;
      }
    }
    cityBools[currentCityIndex!] = true;
    log(currentCityIndex.toString());
    log(profileProvider!.currentCity);
    notifyListeners();
  }

  saveSelectedCity() {
    profileProvider!.setCurrentCity(currentCity!);
    notifyListeners();
    log(currentCity!);
  }
}

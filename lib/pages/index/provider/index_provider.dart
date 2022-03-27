import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kettik_business/base/base_bloc.dart';

import '../../../shared/size_config.dart';
import '../../../shared/theme.dart';

class IndexProvider extends BaseBloc {
  int bottomIndex = 0;
  List<BottomNavigationBarItem>? items;
  String currentTitle = 'Статистика';
  final List<String> _titles = [
    'Статистика',
    'Мои туры',
    'Профиль',
  ];

  init(BuildContext context) {
    setLoading(true);
    SizeConfig().init(context);
    items = [
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          AppSvgImages.statistics_unchosen_ic,
          width: getProportionateScreenHeight(50),
          height: getProportionateScreenHeight(50),
        ),
        activeIcon: SvgPicture.asset(
          AppSvgImages.statistics_chosen_ic,
          width: getProportionateScreenHeight(50),
          height: getProportionateScreenHeight(50),
        ),
        label: 'Статистика',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          AppSvgImages.my_tours_unchosen_ic,
          width: getProportionateScreenHeight(50),
          height: getProportionateScreenHeight(45),
        ),
        activeIcon: SvgPicture.asset(
          AppSvgImages.my_tours_chosen_ic,
          width: getProportionateScreenHeight(50),
          height: getProportionateScreenHeight(45),
        ),
        label: 'Мои туры',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          AppSvgImages.profile_unchosen_ic,
          width: getProportionateScreenHeight(50),
          height: getProportionateScreenHeight(50),
        ),
        activeIcon: SvgPicture.asset(
          AppSvgImages.profile_chosen_ic,
          width: getProportionateScreenHeight(50),
          height: getProportionateScreenHeight(50),
        ),
        label: 'Профиль',
      ),
    ];
    setLoading(false);
  }

  setBottomIndex(int index) {
    bottomIndex = index;
    currentTitle = _titles[index];
    notifyListeners();
  }
}

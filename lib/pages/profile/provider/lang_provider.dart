import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kettik_business/base/base_bloc.dart';
import 'package:kettik_business/pages/profile/provider/profile_provider.dart';
import 'package:kettik_business/shared/size_config.dart';

class LangProvider extends BaseBloc {
  List<String> langs = [
    'Қазақша',
    'Русский',
    'English',
  ];

  String langGroupValue = "";
  Locale? _locale;
  Size? size;

  init(context) {
    setLoading(true);
    size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    setInitCurrentLang(context);
    setLoading(false);
  }

  setInitCurrentLang(context) {
    switch (EasyLocalization.of(context)!.currentLocale!.languageCode) {
      case "kk":
        setGroupedLangValue(langs[0]);
        break;
      case "ru":
        setGroupedLangValue(langs[1]);
        break;
      case "en":
        setGroupedLangValue(langs[2]);
        break;
    }
  }

  setGroupedLangValue(String value) {
    langGroupValue = value;
    notifyListeners();
  }

  applyChoosedLang(context, ProfileProvider profileProvider) async {
    log("Apply lang is called");
    EasyLocalization.of(context)!.supportedLocales.forEach((element) async {
      if (_locale != null && element.languageCode == _locale!.languageCode) {
        await EasyLocalization.of(context)!.setLocale(element);
        Navigator.of(context).pop(profileProvider.init(context));
      }
    });
  }

  void changeLangByIndex(BuildContext context, int index) {
    setGroupedLangValue(langs[index]);

    switch (index) {
      case 0:
        //kz
        setLocale(context, const Locale('kk'));
        break;

      case 1:
        // ru
        setLocale(context, const Locale('ru'));
        break;

      case 2:
        //en
        setLocale(context, const Locale('en'));
        break;
    }
  }

  setLocale(BuildContext context, Locale newLocale) {
    log("new locale is ${newLocale.languageCode}");
    _locale = newLocale;
    notifyListeners();
  }
}

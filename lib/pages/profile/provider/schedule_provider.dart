import 'package:flutter/material.dart';
import 'package:kettik_business/base/base_bloc.dart';
import 'package:kettik_business/core/freezed/network_error.dart';
import 'package:kettik_business/core/freezed/result.dart';
import 'package:kettik_business/shared/utils.dart';

class ScheduleProvider extends BaseBloc {
  TextEditingController day1Ctrl = TextEditingController();
  TextEditingController day2Ctrl = TextEditingController();
  TextEditingController day3Ctrl = TextEditingController();
  TextEditingController day4Ctrl = TextEditingController();
  TextEditingController day5Ctrl = TextEditingController();
  TextEditingController day6Ctrl = TextEditingController();
  TextEditingController day7Ctrl = TextEditingController();

  List scheduleTypes = [
    {
      'type': '5/2',
      'disabledDays': [
        5,
        6,
      ],
    },
    {
      'type': '6/1',
      'disabledDays': [
        6,
      ],
    },
    {
      'type': 'Без выходных',
      'disabledDays': [],
    },
  ];

  List<TextEditingController> controllerList = [];

  List daysOfTheWeek = [
    'Понедельник',
    'Вторник',
    'Среда',
    'Четверг',
    'Пятница',
    'Суббота',
    'Воскресенье',
  ];

  int _pageNumber = 0;
  int get pageNumber => _pageNumber;

  TabController? tabController;

  init(TickerProvider vsync) {
    tabController = TabController(length: scheduleTypes.length, vsync: vsync);
    controllerList = [
      day1Ctrl,
      day2Ctrl,
      day3Ctrl,
      day4Ctrl,
      day5Ctrl,
      day6Ctrl,
      day7Ctrl,
    ];
    notifyListeners();
  }

  clearTimes() {
    for (TextEditingController ctrl in controllerList) {
      ctrl.text = "";
      notifyListeners();
    }
  }

  setSelected(value) {
    _pageNumber = value;
    notifyListeners();
  }

  getConvertedToStartTime(TextEditingController ctrl) {
    return ctrl.text.substring(0, 5);
  }

  getConvertedToEndTime(TextEditingController ctrl) {
    return ctrl.text.substring(ctrl.text.length - 5, ctrl.text.length);
  }

  checkFilledTimesHelper(BuildContext context, int index) {
    for (int i = 0; i < index; i++) {
      if (controllerList[i].text.length != 11) {
        return true;
      }
    }
    return false;
  }

  checkIsFilledTimes(BuildContext context) {
    if (tabController!.index == 0) {
      // check to filling 5 days
      return checkFilledTimesHelper(context, 5);
    } else if (tabController!.index == 1) {
      // check to filling 6 days
      return checkFilledTimesHelper(context, 6);
    } else {
      // check to filling 7 days
      return checkFilledTimesHelper(context, 7);
    }
  }

  save(BuildContext context) async {
    bool isNotFilled = checkIsFilledTimes(context);
    if (isNotFilled) {
      showCustomSnackBar(context: context, message: "Заполните поле!");
    } else {
      var data = {
        "schedules": [
          {
            "week": "monday",
            "from_time": "${getConvertedToStartTime(day1Ctrl)}",
            "to_time": "${getConvertedToEndTime(day1Ctrl)}"
          },
          {
            "week": "tuesday",
            "from_time": "${getConvertedToStartTime(day2Ctrl)}",
            "to_time": "${getConvertedToEndTime(day2Ctrl)}"
          },
          {
            "week": "wednesday",
            "from_time": "${getConvertedToStartTime(day3Ctrl)}",
            "to_time": "${getConvertedToEndTime(day3Ctrl)}"
          },
          {
            "week": "thursday",
            "from_time": "${getConvertedToStartTime(day4Ctrl)}",
            "to_time": "${getConvertedToEndTime(day4Ctrl)}"
          },
          {
            "week": "friday",
            "from_time": "${getConvertedToStartTime(day5Ctrl)}",
            "to_time": "${getConvertedToEndTime(day5Ctrl)}"
          },
        ]
      };
      var saturday = {
        "week": "saturday",
        "from_time": "${getConvertedToStartTime(day6Ctrl)}",
        "to_time": "${getConvertedToEndTime(day6Ctrl)}"
      };
      if (tabController!.index == 1) {
        data["schedules"]!.add(saturday);
      } else if (tabController!.index == 2) {
        var sunday = {
          "week": "sunday",
          "from_time": "${getConvertedToStartTime(day7Ctrl)}",
          "to_time": "${getConvertedToEndTime(day7Ctrl)}"
        };
        data["schedules"]!.add(saturday);
        data["schedules"]!.add(sunday);
      }
      setLoading(true);
      // Result<dynamic, NetworkError> changeScheduleWork =
      //     await ProfileService().changeScheduleWork(data);

      // changeScheduleWork.when(
      //     success: (response) {
      //       Navigator.of(context).pop();
      //     },
      //     error: (error) {});

      setLoading(false);
    }
  }
}

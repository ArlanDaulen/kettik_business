import 'dart:developer';

import 'package:kettik_business/base/base_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:kettik_business/pages/my_tour/provider/create_tour_provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class PeriodPickerOfTourProvider extends BaseBloc {
  String? selectedDate;
  String? dateCount;
  String? startDate;
  String? endDate;
  String? rangeCount;
  DateTime? pickedFromDate;
  DateTime? pickedToDate;
  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      startDate =
          DateFormat('dd MMMM', 'kk').format(args.value.startDate).toString();
      pickedFromDate = args.value.startDate;
      if (args.value.endDate != null) {
        endDate =
            DateFormat('dd MMMM', 'kk').format(args.value.endDate).toString();
        pickedToDate = args.value.endDate;
        notifyListeners();
      }
    } else if (args.value is DateTime) {
      selectedDate = args.value.toString();
    } else if (args.value is List<DateTime>) {
      dateCount = args.value.length.toString();
    } else {
      rangeCount = args.value.length.toString();
    }
    notifyListeners();
  }

  void saveChangedDate(
      BuildContext context,
      CreateTourProvider createTourProvider,
      TourDateAndCountPersonsModel tourDateAndCountPersons) {
    if (pickedFromDate != null) {
      print("Saved Date!!!");
      createTourProvider.setFromDate(pickedFromDate!, tourDateAndCountPersons);

      if (pickedToDate != null) {
        createTourProvider.setToDate(pickedToDate!, tourDateAndCountPersons);
      } else {
        createTourProvider.setToDate(pickedFromDate!, tourDateAndCountPersons);
      }
    }
    Navigator.pop(context);
  }
}

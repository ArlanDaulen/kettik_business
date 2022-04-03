import 'dart:ffi';

import 'package:kettik_business/base/base_provider.dart';
import 'package:kettik_business/pages/my_tour/provider/create_tour_provider.dart';
import 'package:kettik_business/pages/my_tour/provider/period_picker_tour_provider.dart';
import 'package:kettik_business/shared/size_config.dart';
import 'package:kettik_business/shared/theme.dart';
import 'package:kettik_business/shared/ui_helper.dart';
import 'package:kettik_business/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class PeriodPickerOfTour extends StatelessWidget {
  final CreateTourProvider createTourProvider;
  final TourDateAndCountPersonsModel tourDateAndCountPersons;

  PeriodPickerOfTour(
      {required this.createTourProvider,
      required this.tourDateAndCountPersons});

  @override
  Widget build(BuildContext context) {
    return BaseProvider<PeriodPickerOfTourProvider>(
      model: PeriodPickerOfTourProvider(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primaryColor.withOpacity(0.9),
            title: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text("Time period"),
            ),
          ),
          backgroundColor: AppColors.whiteColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  top: 30,
                  height: 40,
                  child: model.startDate == null
                      // && model.endDate == null
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0xffF8F8F8),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            DateFormat('dd MMMM', 'kk').format(
                              DateTime.now(),
                            ),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: model.endDate == null
                              ? MainAxisAlignment.center
                              : MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color(0xffF8F8F8),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                model.startDate!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            model.endDate == null
                                ? const SizedBox()
                                : SvgPicture.asset(AppSvgImages.line_ic),
                            model.endDate == null
                                ? const SizedBox()
                                : Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: const Color(0xffF8F8F8),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      model.endDate!,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                ),
                _buildCalendar(context, model, createTourProvider),
              ],
            ),
          ),
          bottomNavigationBar: _buildBottomNavbar(context, model),
        );
      },
    );
  }

  _buildCalendar(BuildContext context, PeriodPickerOfTourProvider model,
      CreateTourProvider createTourProvider) {
    return Positioned(
      left: 0,
      top: 80,
      right: 0,
      bottom: 0,
      child: SfDateRangePicker(
        selectionTextStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.whiteColor,
        ),
        selectionRadius: 15,
        headerStyle: const DateRangePickerHeaderStyle(
          backgroundColor: AppColors.bgColor,
          textAlign: TextAlign.start,
          textStyle: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        monthViewSettings: const DateRangePickerMonthViewSettings(
          weekendDays: [6, 7],
          dayFormat: 'EEE',
          showTrailingAndLeadingDates: true,
          firstDayOfWeek: 1,
          viewHeaderHeight: 38,
          viewHeaderStyle: DateRangePickerViewHeaderStyle(
            textStyle: TextStyle(
              fontSize: 12,
              color: Color(0xff6E7781),
              fontFamily: 'Roboto',
            ),
          ),
        ),
        showNavigationArrow: true,
        navigationMode: DateRangePickerNavigationMode.scroll,
        view: DateRangePickerView.month,
        viewSpacing: 5,
        navigationDirection: DateRangePickerNavigationDirection.vertical,
        onSelectionChanged: model.onSelectionChanged,
        selectionMode: DateRangePickerSelectionMode.range,
        todayHighlightColor: Color(0xff6E7781),
        startRangeSelectionColor: AppColors.primaryColor,
        endRangeSelectionColor: AppColors.primaryColor,
        rangeSelectionColor: AppColors.primaryColor.withOpacity(0.05),
        initialSelectedDate: tourDateAndCountPersons.fromDate,
        initialSelectedRange: PickerDateRange(
          tourDateAndCountPersons.fromDate,
          tourDateAndCountPersons.toDate,
        ),
      ),
    );
  }

  _buildBottomNavbar(BuildContext context, PeriodPickerOfTourProvider model) {
    return Container(
      padding: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -20),
            blurRadius: 16,
            spreadRadius: -4,
            color: Colors.black.withOpacity(0.05),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 25,
            right: 25,
            top: 20,
          ),
          child: DefaultButton(
            text: "Select",
            width: double.infinity,
            press: () {
              model.saveChangedDate(
                  context, createTourProvider, tourDateAndCountPersons);
            },
          ),
        ),
      ),
    );
  }
}

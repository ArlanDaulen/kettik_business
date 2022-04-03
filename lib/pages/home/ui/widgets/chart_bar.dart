import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kettik_business/shared/size_config.dart';

import '../../../../shared/theme.dart';

class ChartBar extends StatefulWidget {
  @override
  _ChartBarState createState() => _ChartBarState();
}

class _ChartBarState extends State<ChartBar> {
  final Color barBackgroundColor = AppColors.whiteColor;
  final Duration animDuration = const Duration(microseconds: 250);

  final touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.4,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(8),
                vertical: getProportionateScreenHeight(3)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(8)),
                    child: BarChart(
                      mainBarData(),
                      swapAnimationDuration: animDuration,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = AppColors.primaryColor,
    double width = 13,
    List<int> showToolTips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: [barColor],
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 500,
            colors: [Colors.white],
          ),
        )
      ],
      showingTooltipIndicators: showToolTips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, 150, isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, 293, isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, 400, isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, 350, isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, 430, isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, 360, isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, 270, isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: AppColors.primaryColor,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String weekDay;
            switch (group.x.toInt()) {
              case 0:
                weekDay = 'monday'.tr();
                break;
              case 1:
                weekDay = 'tuesday'.tr();
                break;
              case 2:
                weekDay = 'wednesday'.tr();
                break;
              case 3:
                weekDay = 'thursday'.tr();
                break;
              case 4:
                weekDay = 'friday'.tr();
                break;
              case 5:
                weekDay = 'saturday'.tr();
                break;
              case 6:
                weekDay = 'sunday'.tr();
                break;
              default:
                throw Error();
            }
            return BarTooltipItem(
              weekDay + '\n',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: (rod.y - 1).toInt().toString(),
                  style: const TextStyle(
                    color: Colors.yellow,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'M';
              case 1:
                return 'T';
              case 2:
                return 'W';
              case 3:
                return 'T';
              case 4:
                return 'F';
              case 5:
                return 'S';
              case 6:
                return 'S';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(showTitles: false),
      ),
      borderData: FlBorderData(show: false),
      barGroups: showingGroups(),
      gridData: FlGridData(show: false),
    );
  }
}

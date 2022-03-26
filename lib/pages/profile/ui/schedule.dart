import 'dart:html';

import 'package:flutter/material.dart';
import 'package:kettik_business/base/base_provider.dart';
import 'package:kettik_business/pages/profile/provider/schedule_provider.dart';
import 'package:kettik_business/shared/custom_app_bar.dart';

import '../../../shared/theme.dart';
import '../../../shared/ui_helper.dart';
import '../../../widgets/default_button.dart';

class Schedule extends StatefulWidget {
  const Schedule({Key? key}) : super(key: key);

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: BaseProvider<ScheduleProvider>(
        model: ScheduleProvider(),
        onReady: (value) => value.init(this),
        builder: (context, model, child) {
          return Scaffold(
            body: Column(
              children: [
                CustomAppBar(title: 'График работы'),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UIHelper.verticalSpace(30),
                        const Text(
                          'Смена графика',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.systemBlackColor,
                          ),
                        ),
                        UIHelper.verticalSpace(15),
                        _buildTabs(model),
                        UIHelper.verticalSpace(30),
                        const Text(
                          'Время работы',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.systemBlackColor,
                          ),
                        ),
                        UIHelper.verticalSpace(20),
                        Expanded(
                          // height: 40,
                          child: TabBarView(
                            controller: model.tabController,
                            children: [
                              _buildList(model, 0),
                              _buildList(model, 1),
                              _buildList(model, 2),
                            ],
                          ),
                        ),
                        UIHelper.verticalSpace(10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: DefaultButton(
                            width: double.infinity,
                            text: 'Сохранить',
                            press: () async {
                              // await model.save(context);
                            },
                          ),
                        ),
                        UIHelper.verticalSpace(40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  ListView _buildList(ScheduleProvider model, int typeIndex) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Row(
          children: [
            Text(
              model.daysOfTheWeek[index],
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.systemBlackColor,
              ),
            ),
            const Spacer(),
            model.scheduleTypes[typeIndex]['disabledDays'].contains(index)
                ? TimeSeterDisabled()
                : TimeSeter(
                    controller: model.controllerList[index],
                  ),
          ],
        );
      },
      separatorBuilder: (context, index) => UIHelper.verticalSpace(15),
      itemCount: model.daysOfTheWeek.length,
    );
  }

  _buildTabs(ScheduleProvider model) {
    return Container(
      height: 40,
      child: TabBar(
        controller: model.tabController,
        isScrollable: true,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.primaryColor,
        ),
        labelColor: AppColors.whiteColor,
        unselectedLabelColor: AppColors.primaryColor,
        onTap: (value) {
          model.setSelected(value);
        },
        tabs: model.scheduleTypes
            .map(
              (tab) => Tab(
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 13),
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    tab['type'],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class TimeSeter extends StatelessWidget {
  final TextEditingController controller;

  TimeSeter({required this.controller});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 142,
      padding: const EdgeInsets.only(left: 18),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xffF8F8F8),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        controller: controller,
        inputFormatters: [
          // MaskedInputFormatter('00:00-00:00'),
        ],
        keyboardType: TextInputType.number,
        cursorColor: AppColors.systemBlackColor,
        decoration: const InputDecoration(
          hintText: '00:00-00:00',
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class TimeSeterDisabled extends StatelessWidget {
  const TimeSeterDisabled({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 142,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xffF8F8F8),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text(
        '---',
        style: TextStyle(
          fontSize: 16,
          color: AppColors.systemDarkGrayColor,
        ),
      ),
    );
  }
}

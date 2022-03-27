import 'package:flutter/material.dart';
import 'package:kettik_business/base/base_provider.dart';
import 'package:kettik_business/pages/my_tour/provider/my_tour_provider.dart';
import 'package:kettik_business/shared/theme.dart';
import 'package:kettik_business/widgets/default_button.dart';
import 'package:kettik_business/widgets/loading_view.dart';

class SortToursBottomSheet extends StatelessWidget {
  final MyTourProvider model;

  SortToursBottomSheet({required this.model});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: EdgeInsets.only(top: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio<String>(
                        value: model.filterType,
                        groupValue: model.filterTypeGroup,
                        onChanged: (value) {}),
                    Text(model.filterTypesList[index])
                  ],
                );
              },
              separatorBuilder: (context, index) =>
                  const Divider(color: AppColors.primaryColor),
              itemCount: model.filterTypesList.length),
          SizedBox(
            height: 10,
          ),
          DefaultButton(
            text: "Выбрать",
            width: model.size!.width * 0.8,
            press: () {},
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kettik_business/base/base_provider.dart';
import 'package:kettik_business/pages/my_tour/provider/tour_detail_provider.dart';
import 'package:kettik_business/shared/theme.dart';
import 'package:kettik_business/widgets/default_button.dart';
import 'package:kettik_business/widgets/loading_view.dart';
import 'package:line_icons/line_icons.dart';

class TourDetailScreen extends StatelessWidget {
  final int id;
  TourDetailScreen({required this.id});

  @override
  Widget build(BuildContext context) {
    return BaseProvider<TourDetailProvider>(
        onReady: (_) => _.init(context, id),
        builder: (context, model, child) {
          return model.isLoading
              ? const LoadingView()
              : Scaffold(
                  appBar: AppBar(
                    foregroundColor: AppColors.systemBlackColor,
                    backgroundColor: AppColors.systemWhiteColor,
                    title: Text("Tour name ahsdbajsbdjasdas"),
                    centerTitle: true,
                  ),
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //TODO carousel
                      CarouselSlider(
                        options: CarouselOptions(
                            height: 250,
                            viewportFraction: 0.95,
                            autoPlay: true),
                        items: model.testImages.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  decoration: const BoxDecoration(
                                      color: Colors.deepPurple),
                                  child: Image.network(
                                    i,
                                    fit: BoxFit.cover,
                                  ));
                            },
                          );
                        }).toList(),
                      ),

                      //TODO info
                      Column(
                        children: [
                          ListTile(
                              onTap: () {
                                model.toggleIsMoreInfo();
                              },
                              dense: true,
                              title: const Text(
                                "Подробнее",
                                style: TextStyle(fontSize: 18),
                              ),
                              trailing: Icon(model.isMoreInfoShow
                                  ? Icons.arrow_upward
                                  : Icons.arrow_downward)),
                          model.isMoreInfoShow
                              ? Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: const Text(
                                      "Dropdown button dadssad adhbdhasd hdadg ygdyasgd jkad jh kausd kjahsjdhasjdh uahusd uadh uasishu iauih a haishdui"),
                                )
                              : const SizedBox(),
                          const SizedBox(height: 10),
                          ListTile(
                              onTap: () {
                                model.toggleIsServiceShow();
                              },
                              dense: true,
                              title: const Text(
                                "Услуги",
                                style: TextStyle(fontSize: 18),
                              ),
                              trailing: Icon(model.isServiceShow
                                  ? Icons.arrow_upward
                                  : Icons.arrow_downward)),
                          model.isServiceShow
                              ? ListView.separated(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(0),
                                  itemCount: model.testServices.length,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const Divider();
                                  },
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Text(model.testServices[index]);
                                  },
                                )
                              : const SizedBox(),
                          ListTile(
                              onTap: () {
                                model.toggleIsAdditionalLocationsShow();
                              },
                              dense: true,
                              title: const Text(
                                "Дополнительные локации",
                                style: TextStyle(fontSize: 18),
                              ),
                              trailing: Icon(model.isAdditionLocationsShow
                                  ? Icons.arrow_upward
                                  : Icons.arrow_downward)),
                          model.isAdditionLocationsShow
                              ? ListView.separated(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(0),
                                  itemCount:
                                      model.testAdditionalLocations.length,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const Divider();
                                  },
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Text(
                                        model.testAdditionalLocations[index]);
                                  },
                                )
                              : const SizedBox(),
                        ],
                      ),
                      SizedBox(height: 10),
                      DefaultButton(
                        color: AppColors.systemGreenColor,
                        width: model.size!.width * 0.9,
                        text: "Edit tour",
                        press: () {
                          //TODO edit tour
                        },
                      ),
                      SizedBox(height: 10),
                      DefaultButton(
                        color: AppColors.systemRedColor,
                        width: model.size!.width * 0.9,
                        text: "Delete tour",
                        press: () {
                          //TODO edit tour
                        },
                      )
                    ],
                  ),
                );
        },
        model: TourDetailProvider());
  }
}

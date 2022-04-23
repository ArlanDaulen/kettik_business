import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kettik_business/base/base_provider.dart';
import 'package:kettik_business/pages/my_tour/provider/tour_detail_provider.dart';
import 'package:kettik_business/pages/my_tour/ui/client_info.dart';
import 'package:kettik_business/shared/theme.dart';
import 'package:kettik_business/widgets/default_button.dart';
import 'package:kettik_business/widgets/loading_view.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:line_icons/line_icon.dart';
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
                    title: const Text("Tour name"),
                    centerTitle: true,
                  ),
                  body: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
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
                        Column(
                          children: [
                            _getListTileInfo("Клиенты", model.isShowClients,
                                () {
                              model.toggleClientsList();
                            },
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: model.clients.length,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const Divider();
                                  },
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ListTile(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    ClientInfoScreen(
                                                        client: model
                                                            .clients[index])));
                                      },
                                      leading: const Icon(Icons.person),
                                      title: Text(model.clients[index].name!),
                                      subtitle: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(model.clients[index].phone!),
                                          const SizedBox(height: 3),
                                          Text(model.clients[index].status!),
                                        ],
                                      ),
                                      trailing:
                                          const Icon(Icons.arrow_forward_ios),
                                    );
                                  },
                                )),

                            const SizedBox(height: 10),
                            //* toggle info descriptions
                            _getListTileInfo("Подробнее", model.isMoreInfoShow,
                                () {
                              model.toggleIsMoreInfo();
                            },
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: const Text(
                                      "Dropdown button dadssad adhbdhasd hdadg ygdyasgd jkad jh kausd kjahsjdhasjdh uahusd uadh uasishu iauih a haishdui"),
                                )),

                            //* toggle service list
                            _getListTileInfo("Услуги", model.isServiceShow, () {
                              model.toggleIsServiceShow();
                            },
                                ListView.separated(
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
                                )),

                            //* toggle location list list
                            _getListTileInfo("Дополнительные локации",
                                model.isAdditionLocationsShow, () {
                              model.toggleIsAdditionalLocationsShow();
                            },
                                ListView.separated(
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
                                )),
                          ],
                        ),
                        const SizedBox(height: 30),
                        DefaultButton(
                          color: Colors.amber,
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
                            //TODO delete tour
                          },
                        )
                      ],
                    ),
                  ),
                );
        },
        model: TourDetailProvider());
  }
}

_getListTileInfo(
    String title, bool isShow, Function togglePress, Widget contentWidget) {
  return Column(
    children: [
      ListTile(
          onTap: () {
            togglePress();
          },
          title: Text(
            title,
            style: TextStyle(fontSize: 17.5, fontWeight: FontWeight.w600),
          ),
          trailing: Icon(isShow
              ? CupertinoIcons.chevron_up
              : CupertinoIcons.chevron_down)),
      isShow ? contentWidget : const SizedBox(),
    ],
  );
}

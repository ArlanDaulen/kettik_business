import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:kettik_business/app/data/models/place_model.dart';
import 'package:kettik_business/base/base_provider.dart';
import 'package:kettik_business/pages/my_tour/provider/add_favour_provider.dart';
import 'package:kettik_business/shared/size_config.dart';
import 'package:kettik_business/shared/theme.dart';
import 'package:kettik_business/widgets/default_button.dart';
import 'package:kettik_business/widgets/loading_view.dart';

class AddFavourScreen extends StatelessWidget {
  const AddFavourScreen({Key? key, required this.placeList}) : super(key: key);
  final List<PlaceModel> placeList;

  @override
  Widget build(BuildContext context) {
    return BaseProvider<AddFavourProvider>(
        onReady: (_) => _.init(context, placeList),
        builder: ((context, model, child) {
          return model.isLoading
              ? const LoadingView()
              : KeyboardDismissOnTap(
                  child: Scaffold(
                    appBar: AppBar(
                      backgroundColor: AppColors.whiteColor,
                      foregroundColor: AppColors.systemBlackColor,
                      title: const Text(
                        "Услуги",
                        style: TextStyle(
                            fontSize: 19, color: AppColors.systemBlackColor),
                      ),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: IconButton(
                              onPressed: () {
                                model.save(context);
                              },
                              icon: const Icon(Icons.arrow_forward_ios)),
                        )
                      ],
                    ),
                    body: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Container(
                        width: model.size!.width,
                        padding: const EdgeInsets.symmetric(
                            vertical: 30, horizontal: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Шаг 2. Выберите услуги или создайте собственные для создание тура.",
                              style: TextStyle(
                                  color: AppColors.systemBlackColor
                                      .withOpacity(0.7)),
                            ),
                            SizedBox(height: getProportionateScreenHeight(50)),

                            //TODO here tours by search

                            _addItemOfContainWidget(model),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text("Services in my Tour:"),
                            ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        width: model.size!.width * 0.7,
                                        child: Text(
                                            model.favourList[index].name ?? ""),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            model.deleteItemFromContainList(
                                                index);
                                          },
                                          icon: const Icon(Icons.delete,
                                              color: Colors.red))
                                    ],
                                  );
                                },
                                separatorBuilder: (context, index) => SizedBox(
                                    height: getProportionateScreenHeight(20)),
                                itemCount: model.favourList.length),
                          ],
                        ),
                      ),
                    ),
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.centerDocked,
                    floatingActionButton: DefaultButton(
                      width: model.size!.width * 0.9,
                      text: "Дальше",
                      press: () {
                        model.navigateToAddItems(context);
                      },
                    ),
                  ),
                );
        }),
        model: AddFavourProvider());
  }

  Widget _addItemOfContainWidget(AddFavourProvider model) {
    return Container(
      color: AppColors.systemDarkGrayColor.withOpacity(0.005),
      width: model.size!.width,
      padding: const EdgeInsets.only(top: 10, bottom: 30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: model.size!.width * 0.79,
                child: TextField(
                  controller: model.controller,
                  decoration: const InputDecoration(
                      hintText: "Search service", border: OutlineInputBorder()),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.all(0),
            itemCount: model.testFavours.length,
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                height: 1,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                  onTap: () {
                    model.addOrDeleteInList(index);
                  },
                  title: Text(model.testFavours[index].name ?? "---"),
                  trailing: Icon(
                    model.isChoosedTestList[index]
                        ? Icons.check_box
                        : Icons.add_box,
                    color: model.isChoosedTestList[index]
                        ? AppColors.primaryColor.withOpacity(0.95)
                        : AppColors.primaryColor.withOpacity(0.55),
                  ));
            },
          ),
        ],
      ),
    );
  }
}

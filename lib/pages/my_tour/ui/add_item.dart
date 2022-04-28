import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:kettik_business/app/data/models/favour_model.dart';
import 'package:kettik_business/app/data/models/place_model.dart';
import 'package:kettik_business/base/base_provider.dart';
import 'package:kettik_business/pages/my_tour/provider/add_item_provider.dart';
import 'package:kettik_business/shared/size_config.dart';
import 'package:kettik_business/shared/theme.dart';
import 'package:kettik_business/widgets/loading_view.dart';

import '../../../widgets/default_button.dart';

class AddItemScreen extends StatelessWidget {
  final List<PlaceModel> placesList;
  final List<FavourModel> favourList;

  const AddItemScreen({
    Key? key,
    required this.placesList,
    required this.favourList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseProvider<AddItemProvider>(
      onReady: (_) => _.init(
        context,
        placesList,
        favourList,
      ),
      model: AddItemProvider(),
      builder: (context, model, child) {
        return model.isLoading
            ? const LoadingView()
            : KeyboardDismissOnTap(
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: AppColors.whiteColor,
                    foregroundColor: AppColors.systemBlackColor,
                    title: const Text(
                      "Что входит",
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
                          icon: const Icon(Icons.arrow_forward_ios),
                        ),
                      )
                    ],
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerDocked,
                  floatingActionButton: DefaultButton(
                    width: model.size!.width * 0.9,
                    text: "Дальше",
                    press: () {
                      model.navigateToCreateTourPage(context);
                    },
                  ),
                  body: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Container(
                      width: model.size!.width,
                      padding: const EdgeInsets.symmetric(
                        vertical: 30,
                        horizontal: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Шаг 3. Создайте вещи для создание тура.",
                            style: TextStyle(
                              color:
                                  AppColors.systemBlackColor.withOpacity(0.7),
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(50),
                          ),
                          _addItemOfContainWidget(model),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: const Icon(
                                  Icons.check,
                                  color: AppColors.systemGreenColor,
                                ),
                                title: Text(
                                  model.itemList[index].name!,
                                  textAlign: TextAlign.left,
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    model.deleteItemFromContainList(index);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              );
                              // return Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   crossAxisAlignment: CrossAxisAlignment.center,
                              //   mainAxisSize: MainAxisSize.min,
                              //   children: [
                              //     SizedBox(
                              //       width: model.size!.width * 0.7,
                              //       child: Text(model.containList[index]),
                              //     ),
                              //     IconButton(
                              //         onPressed: () {
                              //           model.deleteItemFromContainList(index);
                              //         },
                              //         icon: const Icon(Icons.delete,
                              //             color: Colors.red))
                              //   ],
                              // );
                            },
                            separatorBuilder: (context, index) => SizedBox(
                              height: getProportionateScreenHeight(20),
                            ),
                            itemCount: model.itemList.length,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }
}

Widget _addItemOfContainWidget(AddItemProvider model) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(
        width: model.size!.width * 0.75,
        child: TextField(
          controller: model.controller,
          decoration: const InputDecoration(
              hintText: "Item or Event in Tour", border: OutlineInputBorder()),
        ),
      ),
      SizedBox(
        child: IconButton(
          icon: Icon(
            Icons.add_box,
            color: AppColors.bgBlueColor,
          ),
          onPressed: () {
            model.addItem();
          },
        ),
      ),
    ],
  );
}

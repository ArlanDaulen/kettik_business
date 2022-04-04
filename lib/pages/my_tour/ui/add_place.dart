import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:kettik_business/base/base_provider.dart';
import 'package:kettik_business/pages/my_tour/provider/add_place_provider.dart';
import 'package:kettik_business/pages/my_tour/provider/create_tour_provider.dart';
import 'package:kettik_business/pages/my_tour/ui/map.dart';
import 'package:kettik_business/shared/size_config.dart';
import 'package:kettik_business/shared/theme.dart';
import 'package:kettik_business/widgets/loading_view.dart';

class AddPlaceScreen extends StatelessWidget {
  final CreateTourProvider createTourProvider;
  AddPlaceScreen({required this.createTourProvider});
  @override
  Widget build(BuildContext context) {
    return BaseProvider<AddPlaceProvider>(
        onReady: (_) => _.init(context, createTourProvider),
        builder: (context, model, child) {
          return model.isLoading
              ? const LoadingView()
              : KeyboardDismissOnTap(
                  child: Scaffold(
                    appBar: AppBar(
                      backgroundColor: AppColors.primaryColor.withOpacity(0.8),
                      title: const Text(
                        "Tour's places",
                        style: TextStyle(fontSize: 19),
                      ),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: IconButton(
                              onPressed: () {
                                model.save(context, createTourProvider);
                              },
                              icon: const Icon(Icons.check)),
                        )
                      ],
                    ),
                    bottomSheet: _addItemOfContainWidget(model),
                    body: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Container(
                        width: model.size!.width,
                        padding: const EdgeInsets.symmetric(
                            vertical: 30, horizontal: 20),
                        child: Column(
                          children: [
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
                                            model.placeList[index].name ?? ""),
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
                                itemCount: model.placeList.length),
                            _addPoinOnMap(model),
                            SizedBox(height: getProportionateScreenHeight(50)),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
        },
        model: AddPlaceProvider());
  }

  Widget _addPoinOnMap(AddPlaceProvider model) {
    return Container(
      width: model.size!.width,
      height: model.size!.height,
      decoration: BoxDecoration(
        color: AppColors.bgBlueColor,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  Widget _addItemOfContainWidget(AddPlaceProvider model) {
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
                hintText: "Additional place name in Tour",
                border: OutlineInputBorder()),
          ),
        ),
        SizedBox(
          child: IconButton(
            icon: Icon(
              Icons.add_box,
              color: AppColors.bgBlueColor,
              size: 30,
            ),
            onPressed: () {
              model.addItemToContainList();
            },
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:kettik_business/base/base_provider.dart';
import 'package:kettik_business/pages/my_tour/provider/add_place_provider.dart';
import 'package:kettik_business/pages/my_tour/provider/create_tour_provider.dart';
import 'package:kettik_business/pages/my_tour/ui/create_place.dart';
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
                            _addItemOfContainWidget(model),

                            //TODO here tours by search
                            const Divider(
                              thickness: 2,
                              color: AppColors.primaryColor,
                            ),
                            const Text("Places in my Tour"),
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
                            SizedBox(height: getProportionateScreenHeight(50)),
                          ],
                        ),
                      ),
                    ),
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.centerDocked,
                    floatingActionButton: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => CreatePlaceScreen(
                                      createTourProvider: createTourProvider,
                                    )));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                            color: AppColors.systemBlackColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: const Text(
                          "Create place",
                          style: TextStyle(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                );
        },
        model: AddPlaceProvider());
  }

  Widget _addItemOfContainWidget(AddPlaceProvider model) {
    return Container(
      color: AppColors.systemDarkGrayColor.withOpacity(0.005),
      width: model.size!.width,
      padding: EdgeInsets.only(top: 10, bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: model.size!.width * 0.8,
            child: TextField(
              controller: model.controller,
              decoration: const InputDecoration(
                  hintText: "Additional place name in Tour",
                  border: OutlineInputBorder()),
            ),
          ),
          // SizedBox(
          //   child: IconButton(
          //     icon: Icon(
          //       Icons.add_box,
          //       color: AppColors.bgBlueColor,
          //       size: 30,
          //     ),
          //     onPressed: () {
          //       model.addItemToContainList();
          //     },
          //   ),
          // )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:kettik_business/base/base_provider.dart';
import 'package:kettik_business/pages/my_tour/provider/add_contain_provider.dart';
import 'package:kettik_business/pages/my_tour/provider/create_tour_provider.dart';
import 'package:kettik_business/shared/size_config.dart';
import 'package:kettik_business/shared/theme.dart';
import 'package:kettik_business/widgets/loading_view.dart';

class AddContainScreen extends StatelessWidget {
  final CreateTourProvider createTourProvider;

  AddContainScreen({required this.createTourProvider});

  @override
  Widget build(BuildContext context) {
    return BaseProvider<AddContainProvider>(
        onReady: (_) => _.init(context, createTourProvider),
        builder: (context, model, child) {
          return model.isLoading
              ? const LoadingView()
              : KeyboardDismissOnTap(
                  child: Scaffold(
                    appBar: AppBar(
                      backgroundColor: AppColors.primaryColor.withOpacity(0.8),
                      title: const Text(
                        "Tour's contains",
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
                                        child: Text(model.containList[index]),
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
                                itemCount: model.containList.length),
                            _addItemOfContainWidget(model)
                          ],
                        ),
                      ),
                    ),
                  ),
                );
        },
        model: AddContainProvider());
  }

  Widget _addItemOfContainWidget(AddContainProvider model) {
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
                hintText: "Item or Event in Tour",
                border: OutlineInputBorder()),
          ),
        ),
        SizedBox(
          child: IconButton(
            icon: Icon(
              Icons.add_box,
              color: AppColors.bgBlueColor,
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kettik_business/base/base_provider.dart';
import 'package:kettik_business/pages/my_tour/provider/add_place_provider_2.0.dart';
import 'package:kettik_business/pages/my_tour/ui/map.dart';
import 'package:kettik_business/shared/size_config.dart';
import 'package:kettik_business/shared/theme.dart';

import '../provider/create_tour_provider.dart';

class AddPlaceScreen2 extends StatelessWidget {
  const AddPlaceScreen2({Key? key, required this.createTourProvider})
      : super(key: key);
  final CreateTourProvider createTourProvider;

  @override
  Widget build(BuildContext context) {
    return BaseProvider<AddPlaceProvider2>(
      onReady: (p0) => p0.init(context, createTourProvider),
      model: AddPlaceProvider2(),
      builder: (_, model, child) {
        return KeyboardDismissOnTap(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Tour\'s places'),
              centerTitle: true,
              backgroundColor: AppColors.primaryColor,
              automaticallyImplyLeading: false,
              leading: InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back_ios),
              ),
              actions: [
                InkWell(
                  onTap: () => model.setDeleteMode(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                    ),
                    child: Icon(
                      model.isDeleteMode
                          ? CupertinoIcons.trash_slash
                          : CupertinoIcons.trash,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => model.save(context, createTourProvider),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                    ),
                    child: const Icon(
                      Icons.check,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ],
            ),
            body: Column(
              // physics: const NeverScrollableScrollPhysics(),
              children: [
                TextField(
                  focusNode: model.myFocusNode,
                  controller: model.controller,
                  onEditingComplete: () {
                    model.addPlace();
                  },
                ),
                SizedBox(
                  height: model.size!.height * 0.5,
                  child: MapScreen(
                    model: model,
                  ),
                ),
                model.markers.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: model.markers.length,
                          itemBuilder: (_, index) => ListTile(
                            leading: const Icon(Icons.location_on),
                            title: Text(
                                model.markers.toList()[index].markerId.value),
                            trailing: model.isDeleteMode
                                ? InkWell(
                                    onTap: () => model.removePlace(model.markers
                                        .toList()[index]
                                        .markerId
                                        .value),
                                    child: Icon(
                                      CupertinoIcons.xmark,
                                      color: AppColors.bgBlueColor,
                                    ),
                                  )
                                : const SizedBox(),
                            onTap: () =>
                                model.googleMapController!.animateCamera(
                              CameraUpdate.newCameraPosition(
                                CameraPosition(
                                  target:
                                      model.markers.toList()[index].position,
                                  zoom: 11.5,
                                  tilt: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        );
      },
    );
  }
}

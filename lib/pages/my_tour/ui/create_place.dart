import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kettik_business/base/base_provider.dart';
import 'package:kettik_business/pages/my_tour/provider/add_place_provider.dart';
import 'package:kettik_business/pages/my_tour/provider/create_place_provider.dart';
import 'package:kettik_business/shared/size_config.dart';
import 'package:kettik_business/shared/theme.dart';

class CreatePlaceScreen extends StatelessWidget {
  final AddPlaceProvider addPlaceProvider;

  CreatePlaceScreen({required this.addPlaceProvider});

  @override
  Widget build(BuildContext context) {
    return BaseProvider<CreatePlaceProvider>(
      onReady: (p0) => p0.init(context, addPlaceProvider),
      model: CreatePlaceProvider(),
      builder: (_, model, child) {
        return KeyboardDismissOnTap(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Choose place'),
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
                  onTap: () => model.save(context, addPlaceProvider),
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
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  width: model.size!.width * 0.9,
                  child: TextField(
                    focusNode: model.myFocusNode,
                    controller: model.placeNameContoller,
                    onEditingComplete: () {
                      model.addPlace();
                    },
                    decoration: const InputDecoration(
                        hintText: "Name of place",
                        border: OutlineInputBorder()),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                    height: model.size!.height * 0.5,
                    child: GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: model.initialCameraPosition,
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                      onMapCreated: (controller) =>
                          model.googleMapController = controller,
                      markers: model.markers,
                      onTap: (pos) => model.focusRequestAndSavePosition(pos),
                    )),
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

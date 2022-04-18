import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kettik_business/app/data/models/place_model.dart';
import 'package:kettik_business/base/base_bloc.dart';
import 'package:kettik_business/pages/my_tour/provider/add_place_provider.dart';
import 'package:kettik_business/pages/my_tour/provider/create_tour_provider.dart';
import 'package:kettik_business/shared/size_config.dart';

class CreatePlaceProvider extends BaseBloc {
  Size? size;
  PlaceModel? placeModel;
  TextEditingController placeNameContoller = TextEditingController();

  final initialCameraPosition = const CameraPosition(
    target: LatLng(43.238949, 76.889709),
    zoom: 10.5,
  );

  GoogleMapController? googleMapController;
  Set<Marker> markers = <Marker>{};
  FocusNode? myFocusNode;
  LatLng? position;
  bool isDeleteMode = false;

  init(BuildContext context, AddPlaceProvider addPlaceProvider) {
    setLoading(true);
    size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    myFocusNode = FocusNode();
    setLoading(false);
  }

  addPlace() {
    log("add marker");
    markers.add(
      Marker(
        markerId: MarkerId(placeNameContoller.text),
        icon: BitmapDescriptor.defaultMarker,
        position: position!,
      ),
    );
    myFocusNode!.unfocus();
    placeNameContoller.clear();
    notifyListeners();
  }

  void save(BuildContext context, AddPlaceProvider addPlaceProvider) {
    if (markers.isEmpty ||
        placeModel == null ||
        placeNameContoller.text.isEmpty) {
    } else {
      addPlaceProvider.addPlaceToPlaceList(placeModel!);
      notifyListeners();
    }
    Navigator.pop(context);
  }

  focusRequestAndSavePosition(LatLng pos) {
    myFocusNode!.requestFocus();
    position = pos;
    notifyListeners();
  }

  removePlace(String value) {
    markers.removeWhere((element) => element.markerId.value == value);
    notifyListeners();
  }

  setDeleteMode() {
    isDeleteMode = !isDeleteMode;
    notifyListeners();
  }
}

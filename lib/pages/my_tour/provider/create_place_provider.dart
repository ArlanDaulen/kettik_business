import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kettik_business/app/data/models/place_model.dart';
import 'package:kettik_business/base/base_bloc.dart';
import 'package:kettik_business/pages/my_tour/provider/create_tour_provider.dart';
import 'package:kettik_business/shared/size_config.dart';

class CreatePlaceProvider extends BaseBloc {
  Size? size;
  List<PlaceModel> placeList = [];
  TextEditingController controller = TextEditingController();

  final initialCameraPosition = const CameraPosition(
    target: LatLng(43.238949, 76.889709),
    zoom: 10.5,
  );

  GoogleMapController? googleMapController;
  Set<Marker> markers = <Marker>{};
  FocusNode? myFocusNode;
  LatLng? position;
  bool isDeleteMode = false;

  init(BuildContext context, CreateTourProvider createTourProvider) {
    setLoading(true);
    size = MediaQuery.of(context).size;
    placeList = createTourProvider.placesList;
    for (var e in placeList) {
      Marker m = Marker(
        markerId: MarkerId(e.name!),
        position: LatLng(
          double.parse(e.lattitude!),
          double.parse(e.longitude!),
        ),
      );
      markers.add(m);
    }
    SizeConfig().init(context);
    myFocusNode = FocusNode();
    setLoading(false);
  }

  addPlace() {
    markers.add(
      Marker(
        markerId: MarkerId(controller.text),
        icon: BitmapDescriptor.defaultMarker,
        position: position!,
      ),
    );
    myFocusNode!.unfocus();
    controller.clear();
    notifyListeners();
  }

  void save(BuildContext context, CreateTourProvider createTourProvider) {
    placeList.clear();
    for (var e in markers) {
      PlaceModel p = PlaceModel(
        name: e.markerId.value,
        lattitude: e.position.latitude.toString(),
        longitude: e.position.longitude.toString(),
        isMain: false,
      );
      placeList.add(p);
      notifyListeners();
    }
    if (markers.isEmpty) placeList.clear();
    notifyListeners();
    createTourProvider.setPlacesList(placeList);
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

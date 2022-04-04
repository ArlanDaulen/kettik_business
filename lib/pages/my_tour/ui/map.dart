import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kettik_business/pages/my_tour/provider/add_place_provider_2.0.dart';
import 'package:kettik_business/shared/theme.dart';

import '../../../shared/size_config.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key, required this.model}) : super(key: key);
  final AddPlaceProvider2 model;

  static const _initialCameraPosition = CameraPosition(
    target: LatLng(43.238949, 76.889709),
    zoom: 10.5,
  );

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _initialCameraPosition,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      onMapCreated: (controller) => model.googleMapController = controller,
      markers: model.markers,
      onTap: (pos) => model.focusRequestAndSavePosition(pos),
    );
  }
}

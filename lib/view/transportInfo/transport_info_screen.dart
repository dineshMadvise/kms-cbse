// ignore_for_file: use_key_in_widget_constructors, prefer_final_fields, avoid_print

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_btn.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_transport_info_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/services/google_map_marker_pin.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/transport_info_viewmodel.dart';

class TransportInfoScreen extends StatefulWidget {
  @override
  _TransportInfoScreenState createState() => _TransportInfoScreenState();
}

class _TransportInfoScreenState extends State<TransportInfoScreen> {
  TransportInfoViewModel viewModel =
      Get.find(tag: TransportInfoViewModel().toString());
  LatLng? stopLocation, schLocation, currentLocation;
  final Completer<GoogleMapController> _controller = Completer();
  CameraPosition? initialLocation;

  // late LatLng currentLatLg;
  bool isAlreadyCreated = false;
  Set<Marker> _markers = {};
  Set<Polyline> polyLines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    // currentLatLg = LatLng(GetLocation.latitude, GetLocation.longitude);
    await viewModel.getTransportInfo();
    if (viewModel.getTransportInfoApiResponse.status == Status.COMPLETE) {
      GetTransportInfoResModel model =
          viewModel.getTransportInfoApiResponse.data;
      print('LOCATIOn LENGTH:${model.data!.length}');
      if (model.data!.isNotEmpty) {
        isAlreadyCreated = true;
        final data = model.data!.first;
        final currentLat = LatLng(
            ConstUtils.kConvertStringToDouble(data.currentLatitude!),
            ConstUtils.kConvertStringToDouble(data.currentLongitude!));
        schLocation = LatLng(
            ConstUtils.kConvertStringToDouble(data.schoolLatitude!),
            ConstUtils.kConvertStringToDouble(data.schoolLongitude!));
        stopLocation = LatLng(
            ConstUtils.kConvertStringToDouble(data.stopLatitude!),
            ConstUtils.kConvertStringToDouble(data.stopLongitude!));
        setInitLocation(currentLocation: currentLat);
        currentLocation = currentLat;
        print('CURRET LAT :$currentLocation');
        setMapPins();
        setPolyLines();
        setState(() {});
      }
    }
  }

  void setInitLocation({
    required LatLng currentLocation,
  }) {
    initialLocation = CameraPosition(
        zoom: ConstUtils.kCameraZoom,
        bearing: ConstUtils.kCameraBearing,
        tilt: ConstUtils.kCameraTilt,
        target: currentLocation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: VariableUtils.transport, centerTitle: true),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return GetBuilder<TransportInfoViewModel>(
        tag: TransportInfoViewModel().toString(),
        builder: (controller) {
          if (controller.getTransportInfoApiResponse.status == Status.LOADING ||
              controller.getTransportInfoApiResponse.status == Status.INITIAL) {
            return getDataLoadingIndicator();
          }
          if (controller.getTransportInfoApiResponse.status == Status.ERROR) {
            return getDataErrorMsg();
          }
          GetTransportInfoResModel model =
              controller.getTransportInfoApiResponse.data;
          print('LENGTH:${model.data!.length}');
          return model.data!.isEmpty
              ? getNotApplicableMsg(msg: model.msg)
              : mapWidget();
        });
  }

  Stack mapWidget() {
    return Stack(
      children: [
        GoogleMap(
            // myLocationEnabled: true,
            tiltGesturesEnabled: true,
            compassEnabled: false,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            markers: _markers,
            polylines: polyLines,
            mapType: MapType.normal,
            initialCameraPosition: initialLocation!,
            onMapCreated: onMapCreated),
        Positioned(
            top: Get.height * 0.02,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.2),
              child: CustomBtn(
                  bgColor: ColorUtils.blue,
                  onTap: init,
                  title: VariableUtils.refresh,
                  height: 45),
            )),
      ],
    );
  }

  void onMapCreated(GoogleMapController controller) {
    if (!isAlreadyCreated) {
      _controller.complete(controller);
    }
  }

  void setMapPins() {
    if (mounted) {
      print("Marker Updated");
      setState(() {
        _markers.add(Marker(
            markerId: const MarkerId('Current'),
            position: currentLocation!,
            infoWindow: const InfoWindow(title: 'Current'),
            icon: GoogleMapMarkerPinService.busIcon ??
                BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueYellow)));
        _markers.add(Marker(
            markerId: const MarkerId('School'),
            position: schLocation!,
            infoWindow: const InfoWindow(title: 'School'),
            icon: GoogleMapMarkerPinService.schoolIcon ??
                BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueRose)));
        _markers.add(Marker(
            markerId: const MarkerId('Stop'),
            position: stopLocation!,
            infoWindow: const InfoWindow(title: 'Stop'),
            icon: GoogleMapMarkerPinService.stopIcon ??
                BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueRed)));
      });
    }
  }

  setPolyLines() async {
    polyLines = {};
    polylineCoordinates = [];
    for (int index = 0; index < 2; index++) {
      final sourceLocation = index == 0
          ? PointLatLng(currentLocation!.latitude, currentLocation!.longitude)
          : PointLatLng(schLocation!.latitude, schLocation!.longitude);
      final destLocation = index == 0
          ? PointLatLng(schLocation!.latitude, schLocation!.longitude)
          : PointLatLng(stopLocation!.latitude, stopLocation!.longitude);
      PolylineResult? result = await polylinePoints.getRouteBetweenCoordinates(
        ConstUtils.kGoogleKey,
        sourceLocation,
        destLocation,
      );
      print('PolylineResult :=> ${result.status}');
      print('PolylineResult... :=> ${result.points}');

      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }

      print('polylineCoordinates :=> ${polylineCoordinates.length}');

      if (mounted) {
        setState(() {
          Polyline polyline = Polyline(
              width: 5,
              polylineId: const PolylineId("poly"),
              color: ColorUtils.blue,
              points: polylineCoordinates);

          polyLines.add(polyline);
        });
      }
    }
  }

  // setPolyLines() async {
  //   polyLines = {};
  //   polylineCoordinates = [];
  //   final sourceLocation =
  //       PointLatLng(schLocation!.latitude, schLocation!.longitude);
  //   final destLocation =
  //       PointLatLng(stopLocation!.latitude, stopLocation!.longitude);
  //   PolylineResult? result = await polylinePoints.getRouteBetweenCoordinates(
  //     ConstUtils.googleKey,
  //     sourceLocation,
  //     destLocation,
  //   );
  //   print('PolylineResult :=> ${result.status}');
  //   print('PolylineResult... :=> ${result.points}');
  //
  //   for (var point in result.points) {
  //     polylineCoordinates.add(LatLng(point.latitude, point.longitude));
  //   }
  //
  //   print('polylineCoordinates :=> ${polylineCoordinates.length}');
  //
  //   if (mounted) {
  //     setState(() {
  //       Polyline polyline = Polyline(
  //           width: 5,
  //           polylineId: const PolylineId("poly"),
  //           color: ColorUtils.blue,
  //           points: polylineCoordinates);
  //
  //       polyLines.add(polyline);
  //     });
  //   }
  // }
}

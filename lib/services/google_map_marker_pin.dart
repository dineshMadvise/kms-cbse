import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:msp_educare_demo/utils/assets/images_utils.dart';

class GoogleMapMarkerPinService {
  /// for my custom icons
  static BitmapDescriptor? busIcon;
  static BitmapDescriptor? stopIcon;
  static BitmapDescriptor? schoolIcon;

  static void setSourceAndDestinationIcons() async {
    schoolIcon =
        await getBitmapDescriptorFromAssetBytes(ImagesWidgets.schoolPin, 90);
    stopIcon =
        await getBitmapDescriptorFromAssetBytes(ImagesWidgets.stopPin, 70);
    busIcon =
        await getBitmapDescriptorFromAssetBytes(ImagesWidgets.busPin, 130);
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  static Future<BitmapDescriptor> getBitmapDescriptorFromAssetBytes(
      String path, int width) async {
    final Uint8List imageData = await getBytesFromAsset(path, width);
    return BitmapDescriptor.fromBytes(imageData);
  }
}

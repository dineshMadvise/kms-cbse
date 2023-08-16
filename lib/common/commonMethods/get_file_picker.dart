import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';

/// KEY : imagePicker
/// Desc. : Add Image Picker (Pick Image or Video from Gallery and Camera)

/// NOTE :
/// ADD PACKAGES : image_picker: ^0.8.2

/* import 'package:image_picker/image_picker.dart';

Future<XFile> getImageFromGallery() async {
  ImagePicker imagePicker = ImagePicker();
  XFile file = await imagePicker.pickImage(
      source: ImageSource.gallery, preferredCameraDevice: CameraDevice.front);
  print('Path:${file.path}');
  return file;
}

Future<XFile> getImageFromCamera() async {
  ImagePicker imagePicker = ImagePicker();
  XFile file = await imagePicker.pickImage(source: ImageSource.camera);
  return file;
}*/

Future<File> getFile({FileType? fileType}) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(type: fileType??FileType.any);

  if (result != null) {
    File file = File(result.files.single.path!);
    return file;
  } else {
    return File('');
  }
}

String convertFileToBase64(String path) {
  if (path == null || path == '') {
    return '';
  }
  final file = File(path);
  List<int> imageBytes = file.readAsBytesSync();
  return base64Encode(imageBytes);
}

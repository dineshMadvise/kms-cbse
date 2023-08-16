// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/model/repo/get_gallery_repo.dart';

class GalleryViewModel extends GetxController {
  ApiResponse getGalleryApiResponse = ApiResponse.initial('INITIAL');

  /// GET GALLERY
  Future<void> getGallery() async {
    getGalleryApiResponse = ApiResponse.loading('LOADING');
    // update();
    try {
      final response = await GetGalleryRepo().getGallery();
      getGalleryApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getGalleryApiResponse ERROR :=> $e');
      getGalleryApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }
}

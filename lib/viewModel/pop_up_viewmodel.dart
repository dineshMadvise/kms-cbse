// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/model/repo/get_popup_repo.dart';

import '../model/repo/post_read_popup_repo.dart';

class PopUpViewModel extends GetxController {
  ApiResponse getPopUpApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse postReadPopUpApiResponse = ApiResponse.initial('INITIAL');

  /// GET POP UP
  Future<void> getPopUp() async {
    getPopUpApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetPopUpRepo().getPopUpRepo();
      getPopUpApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getPopUpApiResponse ERROR :=> $e');
      getPopUpApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// POST READ POP UP
  Future<void> postReadPopUp(String popUpId) async {
    postReadPopUpApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await PostReadPopUpRepo().postReadPopUpRepo(popUpId);
      postReadPopUpApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('postReadPopUpApiResponse ERROR :=> $e');
      postReadPopUpApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }
}

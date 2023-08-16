// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/model/repo/get_certificate_list_repo.dart';

class CertificateViewModel extends GetxController {
  ApiResponse getCertificateListApiResponse = ApiResponse.initial('INITIAL');

  /// GET CERTIFICATE LIST
  Future<void> getCertificateList() async {
    getCertificateListApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetCertificateListRepo().getCertificateList();
      getCertificateListApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getCertificateListApiResponse ERROR :=> $e');
      getCertificateListApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }
}

import 'package:get/get.dart';
import 'package:msp_educare_demo/viewModel/certificate_viewmodel.dart';

class CertificateBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CertificateViewModel>(CertificateViewModel(),
        tag: CertificateViewModel().toString(),permanent: true);
  }
}

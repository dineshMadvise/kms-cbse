import 'package:get/get.dart';
import 'package:msp_educare_demo/viewModel/claim_viewmodel.dart';

class ClaimBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ClaimViewModel>(ClaimViewModel(), tag: ClaimViewModel().toString(),permanent: true);
  }
}

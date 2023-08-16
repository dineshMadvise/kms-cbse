import 'package:get/get.dart';
import 'package:msp_educare_demo/viewModel/enquiry_viewmodel.dart';

class EnquiryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<EnquiryViewModel>(EnquiryViewModel(),
        tag: EnquiryViewModel().toString(),permanent: true);
  }
}

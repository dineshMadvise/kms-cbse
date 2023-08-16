import 'package:get/get.dart';
import 'package:msp_educare_demo/viewModel/new_admission_inquiry_viewmodel.dart';

class NewAdmissionEnquiryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<NewAdmissionInquiryViewModel>(NewAdmissionInquiryViewModel(),
        tag: NewAdmissionInquiryViewModel().toString(),permanent: true);
  }
}

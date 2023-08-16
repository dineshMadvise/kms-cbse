import 'package:get/get.dart';
import 'package:msp_educare_demo/viewModel/complaint_viewmodel.dart';

class ComplaintBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ComplaintViewModel>(ComplaintViewModel(),
        tag: ComplaintViewModel().toString(),permanent: true);
  }
}

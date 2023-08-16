import 'package:get/get.dart';
import 'package:msp_educare_demo/viewModel/leave_viewmodel.dart';

class LeaveBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LeaveViewModel>(LeaveViewModel(), tag: LeaveViewModel().toString(),permanent: true);
  }
}

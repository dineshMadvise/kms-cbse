import 'package:get/get.dart';
import 'package:msp_educare_demo/viewModel/attendance_viewmodel.dart';

class AttendanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AttendanceViewModel>(AttendanceViewModel(),
        tag: AttendanceViewModel().toString(),permanent: true);
  }
}

import 'package:get/get.dart';
import 'package:msp_educare_demo/viewModel/teacher_viewmodel.dart';

class TeacherAttendanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<TeacherAttendanceViewModel>(TeacherAttendanceViewModel(),
        tag: TeacherAttendanceViewModel().toString(),permanent: true);
  }
}

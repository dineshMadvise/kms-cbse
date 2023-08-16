import 'package:get/get.dart';
import 'package:msp_educare_demo/viewModel/class_timetable_viewmodel.dart';

class ClassTimeTableBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ClassTimeTableViewModel>(ClassTimeTableViewModel(),
        tag: ClassTimeTableViewModel().toString(),permanent: true);
  }
}

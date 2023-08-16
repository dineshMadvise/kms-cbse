import 'package:get/get.dart';
import 'package:msp_educare_demo/viewModel/exam_timetable_viewmodel.dart';

class ExamTimetableBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ExamTimetableViewModel>(ExamTimetableViewModel(),
        tag: ExamTimetableViewModel().toString(),permanent: true);
  }
}

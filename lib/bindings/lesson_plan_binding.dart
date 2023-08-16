import 'package:get/get.dart';
import 'package:msp_educare_demo/viewModel/lesson_plan_viewmodel.dart';

class LessonPlanBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LessonPlanViewModel>(LessonPlanViewModel(),
        tag: LessonPlanViewModel().toString(),permanent: true);
  }
}

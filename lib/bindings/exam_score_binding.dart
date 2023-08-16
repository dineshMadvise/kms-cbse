import 'package:get/get.dart';
import 'package:msp_educare_demo/viewModel/exam_score_viewmodel.dart';

class ExamScoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ExamScoreViewModel>(ExamScoreViewModel(),
        tag: ExamScoreViewModel().toString(),permanent: true);
  }
}

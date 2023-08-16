import 'package:get/get.dart';
import 'package:msp_educare_demo/viewModel/progress_report_viewmodel.dart';

class ProgressReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ProgressReportViewModel>(ProgressReportViewModel(),
        tag: ProgressReportViewModel().toString(),permanent: true);
  }
}

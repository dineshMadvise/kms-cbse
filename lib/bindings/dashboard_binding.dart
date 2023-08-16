import 'package:get/get.dart';
import 'package:msp_educare_demo/viewModel/dashboard_viewmodel.dart';
import 'package:msp_educare_demo/viewModel/report_viewmodel.dart';

class DashBoardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DashBoardViewModel>(DashBoardViewModel(),
        tag: DashBoardViewModel().toString(), permanent: true);
    Get.put<ReportViewModel>(ReportViewModel(),
        tag: ReportViewModel().toString(), permanent: true);
  }
}

import 'package:get/get.dart';
import 'package:msp_educare_demo/viewModel/academic_year_plan_viewmodel.dart';

class AcademicYearPlanBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AcademicYearPlanVideModel>(AcademicYearPlanVideModel(),
        tag: AcademicYearPlanVideModel().toString(),permanent: true);
  }
}

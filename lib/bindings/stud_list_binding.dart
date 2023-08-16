import 'package:get/get.dart';
import 'package:msp_educare_demo/viewModel/student_list_viewmodel.dart';

class StudentListBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<StudentListViewModel>(StudentListViewModel(),
        tag: StudentListViewModel().toString(),permanent: true);
  }
}

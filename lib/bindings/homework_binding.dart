import 'package:get/get.dart';
import 'package:msp_educare_demo/viewModel/homework_viewmodel.dart';

class HomeworkBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeWorkViewModel>(HomeWorkViewModel(),
        tag: HomeWorkViewModel().toString(),permanent: true);
  }
}

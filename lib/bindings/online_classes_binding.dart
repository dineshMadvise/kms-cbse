import 'package:get/get.dart';
import 'package:msp_educare_demo/viewModel/online_classes_viewmodel.dart';

class OnlineClassesBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<OnlineClassesViewModel>(OnlineClassesViewModel(),
        tag: OnlineClassesViewModel().toString(),permanent: true);
  }
}

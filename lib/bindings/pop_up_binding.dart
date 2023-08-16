import 'package:get/get.dart';
import 'package:msp_educare_demo/viewModel/pop_up_viewmodel.dart';

class PopUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PopUpViewModel>(PopUpViewModel(), tag: PopUpViewModel().toString(),permanent: true);
  }
}

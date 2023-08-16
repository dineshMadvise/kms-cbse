import 'package:get/get.dart';
import 'package:msp_educare_demo/viewModel/dropdown_options_viewmodel.dart';

class DropdownOptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DropdownOptionViewModel>(DropdownOptionViewModel(),
        tag: DropdownOptionViewModel().toString(),permanent: true);
  }
}

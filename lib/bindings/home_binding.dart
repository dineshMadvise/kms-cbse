import 'package:get/get.dart';
import 'package:msp_educare_demo/viewModel/home_viewmodel.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeViewModel>(HomeViewModel(), tag: HomeViewModel().toString(),permanent: true);
  }
}

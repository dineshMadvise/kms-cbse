import 'package:get/get.dart';
import 'package:msp_educare_demo/viewModel/auth_viewmodel.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthViewModel>(AuthViewModel(), tag: AuthViewModel().toString(),permanent: true);
  }
}

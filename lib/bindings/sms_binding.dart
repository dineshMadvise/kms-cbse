import 'package:get/get.dart';
import 'package:msp_educare_demo/viewModel/sms_viewmodel.dart';

class SmsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SmsViewModel>(SmsViewModel(),
        tag: SmsViewModel().toString(),permanent: true);
  }
}

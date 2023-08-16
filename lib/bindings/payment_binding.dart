import 'package:get/get.dart';
import 'package:msp_educare_demo/viewModel/announcement_viewmodel.dart';
import 'package:msp_educare_demo/viewModel/payment_viewmodel.dart';

class PaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PaymentViewModel>(PaymentViewModel(),
        tag: PaymentViewModel().toString(),permanent: true);
  }
}

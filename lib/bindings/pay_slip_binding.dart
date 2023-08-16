import 'package:get/get.dart';
import 'package:msp_educare_demo/viewModel/pay_slip_viewmodel.dart';

class PaySlipBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PaySlipViewModel>(PaySlipViewModel(),
        tag: PaySlipViewModel().toString(),permanent: true);
  }
}

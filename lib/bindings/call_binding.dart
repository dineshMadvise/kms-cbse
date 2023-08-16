
import 'package:get/get.dart';
import 'package:msp_educare_demo/viewModel/call_view_model.dart';

class CallBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<CallViewModel>(CallViewModel(),
        tag: CallViewModel().toString(),permanent: true);
  }

}
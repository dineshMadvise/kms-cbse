import 'package:get/get.dart';
import 'package:msp_educare_demo/viewModel/transport_info_viewmodel.dart';

class TransportInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<TransportInfoViewModel>(TransportInfoViewModel(),
        tag: TransportInfoViewModel().toString(),permanent: true);
  }
}

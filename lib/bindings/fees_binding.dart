import 'package:get/get.dart';

import '../viewModel/fees_viewmodel.dart';

class FeesBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<FeesViewModel>(FeesViewModel(), tag: FeesViewModel().toString(),permanent: true);
  }
}

import 'package:get/get.dart';
import 'package:msp_educare_demo/viewModel/notification_viewmodel.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<NotificationViewModel>(NotificationViewModel(),
        tag: NotificationViewModel().toString(),permanent: true);
  }
}

import 'package:get/get.dart';
import 'package:msp_educare_demo/viewModel/announcement_viewmodel.dart';

class AnnouncementBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AnnouncementViewModel>(AnnouncementViewModel(),
        tag: AnnouncementViewModel().toString(),permanent: true);
  }
}

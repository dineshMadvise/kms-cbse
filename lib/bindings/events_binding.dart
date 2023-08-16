import 'package:get/get.dart';
import 'package:msp_educare_demo/viewModel/events_viewmodel.dart';

class EventsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<EventsViewModel>(EventsViewModel(),
        tag: EventsViewModel().toString(),permanent: true);
  }
}

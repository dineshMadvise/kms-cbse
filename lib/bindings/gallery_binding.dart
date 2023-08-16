import 'package:get/get.dart';
import 'package:msp_educare_demo/viewModel/gallery_viewmodel.dart';

class GalleryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<GalleryViewModel>(GalleryViewModel(),
        tag: GalleryViewModel().toString(),permanent: true);
  }
}

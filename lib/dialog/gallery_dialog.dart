import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/download_file.dart';
import 'package:msp_educare_demo/common/commonWidgets/add_or_forword_circle_box.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_video_player.dart';
import 'package:msp_educare_demo/common/commonWidgets/dialog_close_btn.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';

import '../common/commonWidgets/octo_image_network.dart';
import '../model/apiModel/responseModel/get_gallery_res_model.dart';

void showGalleryDialog(Data data) {
  PageController pageController = PageController();

  Get.dialog(Dialog(
    insetPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    child: Container(
      decoration: DecorationUtils.dialogDecorationBox(),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  // VariableUtils.gallery.toUpperCase(),
                  data.title ?? VariableUtils.none,
                  style: FontTextStyle.poppinsW6S13Grey,
                ),
                const DialogCloseBtn(),
              ],
            ),
          ),
          SizeConfig.sH10,
          const Divider(),
          SizeConfig.sH20,
          Container(
            height: Get.width * 0.45,
            width: Get.width,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Stack(
              children: [
                PageView.builder(
                  controller: pageController,
                  itemCount:
                      data.galleryImgs!.length + data.galleryVideos!.length,
                  itemBuilder: (context, index) {
                    if (index > (data.galleryImgs!.length - 1)) {
                      // return Text('Video ${index - data.galleryImgs!.length}');
                      int i = index - data.galleryImgs!.length;
                      return Stack(
                        children: [
                          BetterPlayer.network(
                            data.galleryVideos![i],
                            betterPlayerConfiguration:
                                BetterPlayerConfiguration(autoPlay: true),
                            // 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
                          ),
                          downloadBtn(
                              link: data.galleryVideos![i], isOpen: true)
                        ],
                      );
                    }
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: OctoImageNetwork(
                            url: data.galleryImgs![index],
                            height: Get.width * 0.45,
                            width: Get.width,
                            circleShape: false,
                            fit: false,
                            boxFit: BoxFit.fill,
                            // fit: true,
                          ),
                        ),
                        downloadBtn(
                            link: data.galleryImgs![index], isOpen: false)
                      ],
                    );
                  },
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            pageController.previousPage(
                                duration: const Duration(milliseconds: 700),
                                curve: Curves.ease);
                          },
                          child: const AddOrForwordCircleBox(
                            icon: ConstUtils.kBackwordArrowIcon,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            pageController.nextPage(
                                duration: const Duration(milliseconds: 700),
                                curve: Curves.ease);
                          },
                          child: const AddOrForwordCircleBox(
                            icon: ConstUtils.kForwordArrowIcon,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  ));
}

Positioned downloadBtn({required String link, required bool isOpen}) {
  return Positioned(
      right: 5,
      top: 5,
      child: InkWell(
          onTap: () {
            downloadFile(link, openFileStatus: isOpen);
          },
          child: const AddOrForwordCircleBox(
            icon: ConstUtils.kDownloadIcon,
          )));
}

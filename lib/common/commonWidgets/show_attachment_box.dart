import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/download_file.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/route_utils.dart';

class ShowAttachmentBox extends StatelessWidget {
  final String link;

  const ShowAttachmentBox({Key? key, required this.link}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return link == ""
        ? SizedBox()
        : InkWell(
            onTap: () {
              if (link != null && link != '') {
                final status = ConstUtils.kCheckFileExtension(link);
                Get.back();
                // if (status) {
                  downloadFile(link, openFileStatus: true);
                // } else {
                //   RouteUtils.navigateRoute(RouteUtils.webViewScreen,
                //       args: link);
                // }
              }
            },
            child: Container(
              width: Get.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: ColorUtils.blue)),
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              alignment: Alignment.center,
              child: Text(
                ConstUtils.kGetFileName(link),
                style: FontTextStyle.poppinsW512Purple,
              ),
            ),
          );
  }
}

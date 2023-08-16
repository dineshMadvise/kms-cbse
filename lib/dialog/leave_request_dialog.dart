import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonWidgets/dialog_close_btn.dart';
import 'package:msp_educare_demo/common/commonWidgets/show_attachment_box.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_leave_req_list_res_model.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';

void showLeaveRequestDialog(Data data) {
  Get.dialog(Dialog(
    insetPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    child: Container(
      decoration: DecorationUtils.dialogDecorationBox(),
      padding: EdgeInsets.symmetric(vertical: 20),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    ConstUtils.kStarIcon,
                    color: ColorUtils.darkGrey,
                    size: 20,
                  ),
                  SizeConfig.sW10,
                  Text(
                    VariableUtils.casualLeave.toUpperCase(),
                    style: FontTextStyle.poppinsW6S13Grey,
                  ),
                  Spacer(),
                  DialogCloseBtn(),
                ],
              ),
            ),
            SizeConfig.sH10,
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    VariableUtils.description + ' : ',
                    style: FontTextStyle.poppinsW6S12Grey,
                  ),
                  SizeConfig.sW10,
                  Expanded(
                    child: Text(data.reason ?? VariableUtils.none,
                        style: FontTextStyle.poppinsW5S12Grey),
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                children: [
                  Text(
                    '${VariableUtils.attachment.capitalizeFirst} : ',
                    style: FontTextStyle.poppinsW6S12Grey,
                  ),
                  SizeConfig.sW10,
                  Expanded(
                      child: ShowAttachmentBox(
                    link: data.attachment!,
                  )
                      // InkWell(
                      //   onTap: () {
                      //     if (data.attachment != "" && data.attachment != null) {
                      //       RouteUtils.navigateRoute(RouteUtils.webViewScreen,
                      //           args: data.attachment);
                      //     }
                      //   },
                      //   child: Text(
                      //       ConstUtils.kGetFileName(
                      //           data.attachment ?? VariableUtils.empty),
                      //       style: FontTextStyle.poppinsW5S12Grey),
                      // ),
                      ),
                ],
              ),
            ),
            Divider(),
            if (data.commentByApprover != "")
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Row(
                  children: [
                    Text(
                      VariableUtils.commentByApprove,
                      style: FontTextStyle.poppinsW6S12Grey,
                    ),
                    SizeConfig.sW10,
                    Expanded(
                      child: Text(data.commentByApprover ?? VariableUtils.none,
                          style: FontTextStyle.poppinsW5S12Grey),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  ));
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonWidgets/dialog_close_btn.dart';
import 'package:msp_educare_demo/common/commonWidgets/dialog_title_des_column.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_notification_list_res_model.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';

void showNotificationListDialog(Data data) {
  Get.dialog(Dialog(
    insetPadding:const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    child: Container(
      decoration: DecorationUtils.dialogDecorationBox(),
      padding:const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: SingleChildScrollView(
        physics:const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    VariableUtils.notification.toUpperCase(),
                    style: FontTextStyle.poppinsW6S13Grey,
                  ),
                 const DialogCloseBtn(),
                ],
              ),
            ),
            SizeConfig.sH10,
           const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                const  CircleAvatar(
                    radius: 5,
                    backgroundColor: ColorUtils.lightRed,
                  ),
                  SizeConfig.sW10,
                  Expanded(
                    child: Text(
                      VariableUtils.notificationDate,
                      style: FontTextStyle.poppinsW7S13DarkGrey,
                    ),
                  )
                ],
              ),
            ),
          const  Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: DialogTitleDesColumn(
                  title: VariableUtils.notificationDate,
                  value: data.aDate ?? VariableUtils.none),
            ),
          const  Padding(
              padding:  EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: DialogTitleDesColumn(
                  title: VariableUtils.description,
                  value: data.description ?? VariableUtils.none),
            ),
          ],
        ),
      ),
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  ));
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/join_link_method.dart';
import 'package:msp_educare_demo/common/commonWidgets/dialog_close_btn.dart';
import 'package:msp_educare_demo/common/commonWidgets/dialog_title_des_column.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_online_class_list_res_model.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';

void showOnlineClassesDialog(Data data) {
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    VariableUtils.onlineClasses,
                    style: FontTextStyle.poppinsW6S13Grey,
                  ),
                  DialogCloseBtn(),
                ],
              ),
            ),
            SizeConfig.sH10,
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 5,
                    backgroundColor: ColorUtils.lightRed,
                  ),
                  SizeConfig.sW10,
                  Expanded(
                    child: Text(
                      data.subjectName ?? VariableUtils.none,
                      style: FontTextStyle.poppinsW7S13DarkGrey,
                    ),
                  )
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DialogTitleDesColumn(
                      title: VariableUtils.teacherName,
                      value: data.teacherName ?? VariableUtils.none),
                  SizeConfig.sH15,
                  DialogTitleDesColumn(
                      title: VariableUtils.startTime,
                      value: data.startTime ?? VariableUtils.none),
                  SizeConfig.sH15,
                  DialogTitleDesColumn(
                      title: VariableUtils.endTime,
                      value: data.endTime ?? VariableUtils.none),
                  SizeConfig.sH15,
                  DialogTitleDesColumn(
                      title: VariableUtils.meetingDate,
                      value: data.cDate ?? VariableUtils.none),
                  SizeConfig.sH20,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          VariableUtils.meetingLink,
                          style: FontTextStyle.poppinsW7S13DarkGrey,
                        ),
                        SizeConfig.sH15,
                        if (data.joinLink != null || data.joinLink2 != null)
                          InkWell(
                            onTap: () {
                              String link = data.joinLink ?? data.joinLink2!;
                              if (link != null) {
                                onTap(link: link);
                              }

                              // urlLaunch(data.joinLink ?? data.joinLink2!);
                            },
                            child: Text(
                              VariableUtils.join,
                              style: FontTextStyle.poppinsW6S10Purple,
                            ),
                          ),
                        SizeConfig.sH15,
                        Text(
                          VariableUtils.meetingId,
                          style: FontTextStyle.poppinsW5S12Grey,
                        ),
                        SizeConfig.sH5,
                        Text(
                          VariableUtils.onlineClassesPassword,
                          style: FontTextStyle.poppinsW5S12Grey,
                        ),
                      ],
                    ),
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

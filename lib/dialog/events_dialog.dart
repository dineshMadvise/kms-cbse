import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonWidgets/dialog_close_btn.dart';
import 'package:msp_educare_demo/utils/assets/icons_utils.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';

import '../../model/apiModel/responseModel/get_event_list_res_model.dart';
import '../common/commonWidgets/octo_image_network.dart';

void showEventsDialog(Data data) {
  Get.dialog(Dialog(
    insetPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    child: Container(
      decoration: DecorationUtils.dialogDecorationBox(),
      padding: EdgeInsets.symmetric(vertical: 20),
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
                  VariableUtils.events.toUpperCase(),
                  style: FontTextStyle.poppinsW6S13Grey,
                ),
                DialogCloseBtn(),
              ],
            ),
          ),
          SizeConfig.sH10,
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  data.title ?? VariableUtils.none,
                  style: FontTextStyle.poppinsW6S16DarkGrey,
                ),
                SizeConfig.sH10,
                buildRow(
                    icon: IconsWidgets.calendar,
                    title: data.startDate ?? VariableUtils.none),
                SizeConfig.sH10,
                buildRow(
                    icon: IconsWidgets.clock,
                    title:
                        '${data.startTime ?? VariableUtils.none} - ${data.endTime ?? VariableUtils.none}'),
                SizeConfig.sH10,
                buildRow(
                    icon: IconsWidgets.locationPin,
                    title: data.venue ?? VariableUtils.none),
                SizeConfig.sH15,
                Text(
                  VariableUtils.description,
                  style: FontTextStyle.poppinsW6S16DarkGrey,
                ),
                Text(
                  data.description ?? VariableUtils.none,
                  style: FontTextStyle.poppinsW5S12Grey,
                ),
                SizeConfig.sH15,
                Text(
                  VariableUtils.participants,
                  style: FontTextStyle.poppinsW6S16DarkGrey,
                ),
                SizeConfig.sH10,
                Wrap(
                  runSpacing: 10,
                  spacing: 5,
                  children: List.generate(
                    data.studentList!.length + 1,
                    (index) => index > 10 ||
                            data.studentList!.isEmpty ||
                            index > data.studentList!.length - 1
                        ? data.moreStudentCnt! > 0
                            ? CircleAvatar(
                                radius: 22,
                                backgroundColor: ColorUtils.lightGrey,
                                child: Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Text(
                                    '+${data.moreStudentCnt}',
                                    style: FontTextStyle.poppinsW5S10Blue,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            : SizedBox()
                        : ClipOval(
                            child: OctoImageNetwork(
                              url: data.studentList![index],
                              radius: 20,
                              width: 40,
                              height: 40,
                            ),
                          ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  ));
}

Widget buildRow({required Widget icon, required String title}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      icon,
      SizeConfig.sW5,
      Expanded(
        child: Text(
          title,
          style: FontTextStyle.poppinsW5S14Grey,
        ),
      )
    ],
  );
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonWidgets/dialog_close_btn.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';

import '../model/apiModel/responseModel/get_class_timetable_list_res_model.dart';

void showClassTimetableDialog(Data data) {
  // print('LENGTH;+>${data.periodlist!.length}');
  UserData userData = ConstUtils.getUserData();
  Get.dialog(Dialog(
    insetPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    child: Container(
      decoration: DecorationUtils.dialogDecorationBox(),
      padding: const EdgeInsets.only(top: 20),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    ConstUtils.kStarIcon,
                    color: ColorUtils.darkGrey,
                    size: 20,
                  ),
                  SizeConfig.sW10,
                  Text(
                    data.day ?? VariableUtils.none,
                    style: FontTextStyle.poppinsW6S13Grey,
                  ),
                  const Spacer(),
                  const DialogCloseBtn(),
                ],
              ),
            ),
            data.periodlist == null
                ? const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(child: Text(VariableUtils.noHaveAnyData)),
                  )
                : SizedBox(
                    width: Get.width,
                    child: DataTable(
                        columnSpacing: 30,
                        headingRowHeight: 40,
                        horizontalMargin: 10,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: ColorUtils.grey, width: 0.2)),
                        // border:
                        //     TableBorder.all(color: ColorUtils.grey, width: 0.2),
                        columns: (userData.usertype ==
                                    ConstUtils.kGetRoleIndex(
                                        VariableUtils.parent)
                                ? ConstUtils
                                    .kClassTimeTableDialogTitleListWithParent
                                : ConstUtils
                                    .kClassTimeTableDialogTitleListWithoutParent)
                            .map(
                              (e) => DataColumn(
                                  label: Text(
                                e,
                                style: FontTextStyle.poppinsW6S14Black,
                                textAlign: TextAlign.left,
                              )),
                            )
                            .toList(),
                        rows: data.periodlist!
                            .map(
                              (e) => DataRow(cells: [
                                e.teacher == VariableUtils.breakStr
                                    ? breakDataCell(str: e.timeduration)
                                    : DataCell(Text(
                                        e.timeduration ?? VariableUtils.none,
                                      )),
                                e.teacher == VariableUtils.breakStr
                                    ? breakDataCell()
                                    : DataCell(
                                        Text(e.subject ?? VariableUtils.none)),
                                e.teacher == VariableUtils.breakStr
                                    ? breakDataCell()
                                    : DataCell(
                                        Text(e.teacher ?? VariableUtils.none)),
                              ]),
                            )
                            .toList()),
                  ),
          ],
        ),
      ),
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  ));
}

DataCell breakDataCell({String? str}) {
  return DataCell(Text(
    str ?? VariableUtils.breakStr,
    style: FontTextStyle.poppinsW6S14Black,
  ));
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonWidgets/dialog_close_btn.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';

import '../model/apiModel/responseModel/get_exam_timetable_list_res_model.dart';

void showExamTimetableDialog(Data data) {
  Get.dialog(Dialog(
    insetPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    child: Container(
      decoration: DecorationUtils.dialogDecorationBox(),
      padding: EdgeInsets.only(top: 20),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
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
                    data.examType ?? VariableUtils.none,
                    style: FontTextStyle.poppinsW6S13Grey,
                  ),
                  Spacer(),
                  DialogCloseBtn(),
                ],
              ),
            ),
            if (data.list != null)
              SizedBox(
                width: Get.width,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Row(
                          children: ConstUtils.kExamTimeTableDialogTitleList
                              .map((e) => Expanded(
                                    flex: e == VariableUtils.syllabus ? 2 : 1,
                                    child: Text(
                                      e,
                                      style: FontTextStyle.poppinsW6S14Black,
                                      textAlign: TextAlign.left,
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: data.list!
                              .map((e) => Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (data.list!.indexOf(e) == 0)
                                        SizeConfig.sH5,
                                      Row(
                                        children: [
                                          Expanded(
                                              flex: 1,
                                              child: Text(
                                                "${e.startDate} ${e.startTime}-${e.endTime}",
                                                textAlign: TextAlign.left,
                                              )),
                                          Expanded(
                                              flex: 1,
                                              child: Text(
                                                "${e.subjectName ?? VariableUtils.none}",
                                                textAlign: TextAlign.left,
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                "${e.syllabus ?? VariableUtils.none}",
                                                textAlign: TextAlign.left,
                                              )),
                                        ],
                                      ),
                                      data.list!.indexOf(e) <
                                              data.list!.length - 1
                                          ? Divider()
                                          : SizeConfig.sH5,
                                    ],
                                  ))
                              .toList(),
                        ),
                      )
                    ],
                  ),
                ),
                // child: DataTable(
                //     columnSpacing: 10,
                //     headingRowHeight: 40,
                //     horizontalMargin: 10,
                //     dataRowHeight: 100,
                //     decoration: BoxDecoration(
                //         border: Border.all(color: ColorUtils.grey, width: 0.2)),
                //     // border: TableBorder.all(color: ColorUtils.grey, width: 0.2),
                //     columns: ConstUtils.kExamTimeTableDialogTitleList
                //         .map(
                //           (e) => DataColumn(
                //               label: Text(
                //             e,
                //             style: FontTextStyle.poppinsW6S14Black,
                //             textAlign: TextAlign.left,
                //           )),
                //         )
                //         .toList(),
                //     rows: data.list!
                //         .map(
                //           (e) => DataRow(cells: [
                //             DataCell(SizedBox(
                //               width: 80,
                //               child: Text(
                //                   "${e.startDate} ${e.startTime}-${e.endTime}"),
                //             )),
                //             DataCell(Text(e.subjectName ?? VariableUtils.none)),
                //             DataCell(Padding(
                //               padding: const EdgeInsets.all(3.0),
                //               child: Text(
                //                 e.syllabus ?? VariableUtils.none,
                //                 // maxLines: 3,
                //                 //    overflow: TextOverflow.ellipsis
                //               ),
                //             )),
                //           ]),
                //         )
                //         .toList()),
              ),
          ],
        ),
      ),
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  ));
}

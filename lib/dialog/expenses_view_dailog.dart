import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonWidgets/dialog_close_btn.dart';
import 'package:msp_educare_demo/common/commonWidgets/dialog_title_des_column.dart';
import 'package:msp_educare_demo/common/commonWidgets/show_attachment_box.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/dateformat_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/route_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';

import '../model/apiModel/responseModel/expenses_report_res_model.dart';
import 'fees_pay_dialog.dart';

void showExpensesDialog(ExpensesData data) {
  Get.dialog(Dialog(
    insetPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: ColorUtils.white),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
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
                    VariableUtils.expensesview,
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
                  const CircleAvatar(
                    radius: 5,
                    backgroundColor: ColorUtils.lightRed,
                  ),
                  SizeConfig.sW10,
                  Expanded(
                    // child: Text(
                    //   data.paymentStatus ?? VariableUtils.none,
                    //   style: FontTextStyle.poppinsW7S13DarkGrey,
                    // ),
                    child: richText(
                      key: VariableUtils.Status,
                      value: data.paymentStatus ?? VariableUtils.none,
                    ),
                  )
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: DialogTitleDesColumn(
                      title: VariableUtils.expenseType,
                      value: data.expenseType ?? VariableUtils.none,
                    ),
                  ),
                  Expanded(
                    child: DialogTitleDesColumn(
                      title: VariableUtils.payee,
                      value: data.payeeName ?? VariableUtils.none,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                      RouteUtils.navigateRoute(RouteUtils.editExpensesReport,
                          args: data);
                    },
                    child: const Icon(Icons.edit),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: DialogTitleDesColumn(
                      title: VariableUtils.dateKey,
                      value: data.paymentDate == "" || data.paymentDate == null
                          ? VariableUtils.none
                          : DateFormatUtils.ddMMMYYYYFormat(
                              DateTime.parse(data.paymentDate!)),
                    ),
                  ),
                  Expanded(
                    child: DialogTitleDesColumn(
                        title: VariableUtils.amount,
                        value: data.amount ?? VariableUtils.none),
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: DialogTitleDesColumn(
                title: VariableUtils.description,
                value: data.description ?? VariableUtils.none,
              ),
            ),
            const Divider(),
            SizeConfig.sH5,
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Text(
                '${VariableUtils.attachment.capitalizeFirst}',
                style: FontTextStyle.poppinsW6S12Grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: ShowAttachmentBox(
                link: data.attachment!,
              ),
              // child: DialogTitleDesColumn(
              //     title: VariableUtils.attachment,
              //     value: data.attachment!,
              //     isAttachment: true),
            ),
          ],
        ),
      ),
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  ));
}

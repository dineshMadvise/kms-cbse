import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonWidgets/dialog_close_btn.dart';
import 'package:msp_educare_demo/common/commonWidgets/dialog_title_des_column.dart';
import 'package:msp_educare_demo/common/commonWidgets/show_attachment_box.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';

import '../model/apiModel/responseModel/get_expenses_list_res_model.dart';

void showExpensesDialog(Data data) {
  Get.dialog(Dialog(
    insetPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: ColorUtils.white),
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
                    VariableUtils.expenses.toUpperCase(),
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
                      data.refno ?? VariableUtils.none,
                      style: FontTextStyle.poppinsW7S13DarkGrey,
                    ),
                  )
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: DialogTitleDesColumn(
                        title: VariableUtils.expenseType,
                        value: data.expenseType ?? VariableUtils.none),
                  ),
                  Expanded(
                    child: DialogTitleDesColumn(
                        title: VariableUtils.mode,
                        value: data.paymentBy ?? VariableUtils.none),
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
                        value: data.createdOn ?? VariableUtils.none),
                  ),
                  Expanded(
                      child: DialogTitleDesColumn(
                          title: VariableUtils.amount,
                          value: data.amountExp ?? VariableUtils.none)),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: DialogTitleDesColumn(
                title: VariableUtils.description,
                value: data.description ?? VariableUtils.none,
              ),
            ),
            Divider(),
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
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
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

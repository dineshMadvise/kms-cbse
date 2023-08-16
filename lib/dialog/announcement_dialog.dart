import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonWidgets/dialog_close_btn.dart';
import 'package:msp_educare_demo/common/commonWidgets/dialog_title_des_column.dart';
import 'package:msp_educare_demo/common/commonWidgets/show_attachment_box.dart';
import 'package:msp_educare_demo/logic/announcement_logic.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_announce_list_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/announcement_viewmodel.dart';

import '../common/commonWidgets/custom_btn.dart';
import '../common/commonWidgets/custom_text_field.dart';
import '../model/apiModel/responseModel/login_res_model.dart';
import '../utils/validation_utils.dart';

void showAnnouncementDialog(Data data) {
  String remark = '';
  GlobalKey<FormState> formKey = GlobalKey();
  UserData userData = ConstUtils.getUserData();
  Get.dialog(Dialog(
    insetPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: ColorUtils.white),
      padding: EdgeInsets.symmetric(vertical: 20),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          key: formKey,
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
                      VariableUtils.announcement.toUpperCase(),
                      style: FontTextStyle.poppinsW6S13Grey,
                    ),
                    DialogCloseBtn(),
                  ],
                ),
              ),
              SizeConfig.sH10,
              Divider(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                        data.title ?? VariableUtils.none,
                        style: FontTextStyle.poppinsW7S13DarkGrey,
                      ),
                    )
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: DialogTitleDesColumn(
                    title: VariableUtils.announcementDate,
                    value: data.aDate ?? VariableUtils.none),
              ),
              Divider(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: DialogTitleDesColumn(
                    title: VariableUtils.description,
                    value: data.description ?? VariableUtils.none),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: ShowAttachmentBox(
                  link: data.attachment!,
                ),
                // child: DialogTitleDesColumn(
                //     title: VariableUtils.attachment,
                //     value: data.attachment!,
                //     isAttachment: true),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                child: CommonTextField(
                  titleText: VariableUtils.remark,
                  regularExpression: RegularExpression.addressValidationPattern,
                  hintText: VariableUtils.feedback,
                  onChange: (value) {
                    remark = value;
                  },
                  isValidate: true,
                  maxLine: 4,
                  validationMessage: ValidationMsg.isRequired,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: GetBuilder<AnnouncementViewModel>(
                  tag: AnnouncementViewModel().toString(),
                  builder: (controller) {
                    if (controller.saveAnnouncementRemarkApiResponse.status ==
                            Status.LOADING ||
                        controller.saveAnnouncementRemarkApiResponse.status ==
                            Status.LOADING) {
                      return getDataLoadingIndicator();
                    }
                    return CustomBtn(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          final status =
                              await AnnouncementLogic.saveAnnounceRemark(
                                  annId: data.id!, remark: remark);
                          if (status) {
                            await Future.delayed(Duration(seconds: 4));
                            // formKey.currentState!.reset();
                            Get.back();
                          }
                        }
                      },
                      radius: 10,
                      title: VariableUtils.save,
                    );
                  },
                ),
              ),
              //data.notihistory!.isNotEmpty&&
              if (userData.usertype !=
                  ConstUtils.kGetRoleIndex(VariableUtils.parent))
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Text(
                        VariableUtils.history,
                        style: FontTextStyle.poppinsW6S12Grey,
                      ),
                    ),
                    Divider(),
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    VariableUtils.sNo,
                                    style: FontTextStyle.poppinsW6S14Black,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    VariableUtils.sent,
                                    style: FontTextStyle.poppinsW6S14Black,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    VariableUtils.readOn,
                                    style: FontTextStyle.poppinsW6S14Black,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    VariableUtils.remark,
                                    style: FontTextStyle.poppinsW6S14Black,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: data.notihistory!
                                  .map((e) => Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    "${data.notihistory!.indexOf(e) + 1}",
                                                    textAlign: TextAlign.left,
                                                  )),
                                              Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    "${e.userType}-${e.name}",
                                                    textAlign: TextAlign.left,
                                                  )),
                                              Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    "${e.readdate ?? VariableUtils.none}",
                                                    textAlign: TextAlign.left,
                                                  )),
                                              Expanded(
                                                  flex: 3,
                                                  child: Text(
                                                    "${e.remark ?? VariableUtils.none}",
                                                    textAlign: TextAlign.left,
                                                  )),
                                            ],
                                          ),
                                          data.notihistory!.indexOf(e) <
                                                  data.notihistory!.length - 1
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
                  ],
                ),
            ],
          ),
        ),
      ),
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  ));
}

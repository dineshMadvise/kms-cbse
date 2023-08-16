import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/common/commonMethods/get_file_picker.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_btn.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_datetime_textfield.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_dropdown.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_text_field.dart';
import 'package:msp_educare_demo/logic/announcement_logic.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/add_announcement_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_class_option_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_multiple_class_section_option_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_multiple_class_stud_option_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/dateformat_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/validation_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/announcement_viewmodel.dart';
import 'package:msp_educare_demo/viewModel/dropdown_options_viewmodel.dart';

class AddAnnouncement extends StatefulWidget {
  @override
  State<AddAnnouncement> createState() => _AddAnnouncementState();
}

class _AddAnnouncementState extends State<AddAnnouncement> {
  final formKey = GlobalKey<FormState>();

  AnnouncementViewModel viewModel =
      Get.find(tag: AnnouncementViewModel().toString());
  final DropdownOptionViewModel _optionViewModel =
      Get.find(tag: DropdownOptionViewModel().toString());
  AddAnnouncementReqModel reqModel = AddAnnouncementReqModel();

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    _optionViewModel.getClassOption();
    _optionViewModel.clearAddAnnounceOption();
    viewModel.clearAddAnnounce();
    viewModel.clearClassList();
    viewModel.clearSelectedSectionList();
    viewModel.clearClassStudList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: VariableUtils.addAnnouncement,
      ),
      body: buildBody(),
    );
  }

  Container buildBody() {
    return Container(
      height: Get.height,
      width: Get.width,
      margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
      decoration: DecorationUtils.commonDecorationBox(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: formData(),
    );
  }

  SingleChildScrollView formData() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(bottom: 5),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomDateTimeTextField(
              titleText: VariableUtils.date,
              onChangeDateTime: (value) {
                reqModel.aDate = DateFormatUtils.yyyyMMDDFormat(value);
                print('DATE :$value');
              },
            ),
            SizeConfig.sH20,
            CommonTextField(
              titleText: VariableUtils.title,
              regularExpression: RegularExpression.addressValidationPattern,
              hintText: VariableUtils.title.capitalizeFirst,
              onChange: (value) {
                reqModel.title = value;
              },
              isValidate: true,
              validationMessage: ValidationMsg.isRequired,
            ),
            CommonTextField(
              titleText: VariableUtils.description,
              regularExpression: RegularExpression.addressValidationPattern,
              hintText: VariableUtils.description,
              onChange: (value) {
                reqModel.description = value;
              },
              isValidate: true,
              maxLine: 4,
              validationMessage: ValidationMsg.isRequired,
            ),
            Text(VariableUtils.attachment.toUpperCase(),
                style: FontTextStyle.poppinsW6S12Grey),
            SizeConfig.sH10,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () async {
                    File file = await getFile();
                    if (file.path != '') {
                      viewModel.selectedFile = file.path;
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: ColorUtils.lightGrey,
                        border: Border.all(color: ColorUtils.grey)),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      ConstUtils.kGetFileName(VariableUtils.chooseFile),
                    ),
                  ),
                ),
                SizeConfig.sW10,
                Expanded(
                    child: GetBuilder<AnnouncementViewModel>(
                  tag: AnnouncementViewModel().toString(),
                  builder: (controller) {
                    if (controller.selectedFile == '') {
                      return Text(VariableUtils.noFileChosen);
                    }
                    return Text(
                        ConstUtils.kGetFileName(controller.selectedFile));
                  },
                )),
              ],
            ),
            SizeConfig.sH20,
            CustomDropDown(
              titleText: VariableUtils.publishTo,
              listData: ConstUtils.kPublicDropDownList,
              onChangeString: (value) {
                reqModel.publishTo = (value as String).capitalize;
                print('PUBLISH VALUE ${reqModel.publishTo}');
                setState(() {});
                _optionViewModel.clearMultiClassSection();
                _optionViewModel.clearMultiClassStud();
                viewModel.clearClassList();
                viewModel.clearSelectedSectionList();
                viewModel.clearClassStudList();
              },
            ),
            if (reqModel.publishTo != VariableUtils.all &&
                reqModel.publishTo != null &&
                reqModel.publishTo != VariableUtils.teacher)
              classListTile(),
            if (reqModel.publishTo == VariableUtils.classAndSection)
              sectionListTile(),
            if (reqModel.publishTo == VariableUtils.student) studentListTile(),
            SizeConfig.sH20,
            GetBuilder<AnnouncementViewModel>(
              tag: AnnouncementViewModel().toString(),
              builder: (controller) {
                if (controller.addAnnouncementListApiResponse.status ==
                        Status.LOADING ||
                    controller.addAnnouncementListApiResponse.status ==
                        Status.LOADING) {
                  return getDataLoadingIndicator();
                }
                return CustomBtn(
                  onTap: saveBtn,
                  radius: 10,
                  title: VariableUtils.save,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveBtn() async {
    if (formKey.currentState!.validate()) {
      // if (viewModel.selectedFile == '') {
      //   showToast(msg: VariableUtils.pleaseSelectFile);
      //   return;
      // }
      if (viewModel.selectedFile != '') {
        reqModel.attachment = convertFileToBase64(viewModel.selectedFile);
      }

      final status = await AnnouncementLogic.addAnnouncement(reqModel);
      if (status) {
        // await Future.delayed(Duration(seconds: 4));
        formKey.currentState!.reset();
        _optionViewModel.clearAddAnnounceOption();
        viewModel.clearClassList();
        viewModel.clearSelectedSectionList();
        viewModel.clearClassStudList();
        viewModel.selectedFile = '';
        Get.back();
      }
    }
  }

  /// DROP DOWn

  Widget classListTile() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(VariableUtils.selectClass.toUpperCase(),
              style: FontTextStyle.poppinsW5S12Grey),
          SizeConfig.sH10,
          GetBuilder<DropdownOptionViewModel>(
            tag: DropdownOptionViewModel().toString(),
            builder: (controller) {
              if (controller.getCLassOptionApiResponse.status ==
                  Status.INITIAL) {
                return Container(
                  decoration: DecorationUtils.borderDecorationBox(),
                  height: Get.height * 0.2,
                );
              }

              if (controller.getCLassOptionApiResponse.status ==
                  Status.COMPLETE) {
                GetClassOptionResModel model =
                    controller.getCLassOptionApiResponse.data;

                // List<dynamic> list = model.data!.map((e) => e.name).toList();
                return Container(
                  decoration: DecorationUtils.borderDecorationBox(),
                  height: Get.height * 0.2,
                  child: ListView(
                    children: model.data!
                        .map((e) => GetBuilder<AnnouncementViewModel>(
                              tag: AnnouncementViewModel().toString(),
                              builder: (con) {
                                return Container(
                                  decoration: BoxDecoration(
                                      color:
                                          con.selectedClassList.contains(e.id)
                                              ? ColorUtils.blue
                                              : ColorUtils.transparent,
                                      borderRadius: BorderRadius.circular(4)),
                                  margin: EdgeInsets.only(
                                      top: model.data!.indexOf(e) == 0 ? 0 : 5),
                                  child: ListTile(
                                    onTap: () {
                                      viewModel.setClassList(e.id!);
                                      if (reqModel.publishTo ==
                                          VariableUtils.classAndSection) {
                                        final classIds =
                                            ConstUtils.convertListToString(
                                                con.selectedClassList);
                                        print('CLASS ID : $classIds');
                                        viewModel.clearSelectedSectionList();
                                        if (classIds == '') {
                                          _optionViewModel
                                              .clearMultiClassSection();
                                        } else {
                                          _optionViewModel
                                              .getMultiClassSectionOption(
                                                  classIds);
                                        }
                                      }
                                      if (reqModel.publishTo ==
                                          VariableUtils.student) {
                                        final classIds =
                                            ConstUtils.convertListToString(
                                                con.selectedClassList);
                                        viewModel.clearClassStudList();
                                        if (classIds == '') {
                                          _optionViewModel
                                              .clearMultiClassStud();
                                        } else {
                                          _optionViewModel
                                              .getMultiClassStudOption(
                                                  classIds);
                                        }
                                      }
                                    },
                                    title: Text(
                                      e.name ?? VariableUtils.none,
                                      style:
                                          con.selectedClassList.contains(e.id)
                                              ? FontTextStyle.poppinsW5S16White
                                              : FontTextStyle.poppinsW5S16Black,
                                    ),
                                  ),
                                );
                              },
                            ))
                        .toList(),
                  ),
                );
              }
              return Container(
                decoration: DecorationUtils.borderDecorationBox(),
                height: Get.height * 0.2,
                child: getDataLoadingIndicator(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget sectionListTile() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(VariableUtils.selectSection.toUpperCase(),
              style: FontTextStyle.poppinsW5S12Grey),
          SizeConfig.sH10,
          GetBuilder<DropdownOptionViewModel>(
            tag: DropdownOptionViewModel().toString(),
            builder: (controller) {
              if (controller.getMultipleClassSectionOptionApiResponse.status ==
                  Status.INITIAL) {
                return Container(
                  decoration: DecorationUtils.borderDecorationBox(),
                  height: Get.height * 0.2,
                );
              }
              print(
                  'SECTOI STATUS :=>${controller.getMultipleClassSectionOptionApiResponse.status}');
              if (controller.getMultipleClassSectionOptionApiResponse.status ==
                  Status.COMPLETE) {
                GetMultipleClassSectionOptionResModel model =
                    controller.getMultipleClassSectionOptionApiResponse.data;

                // List<dynamic> list = model.data!.map((e) => e.name).toList();
                return Container(
                  decoration: DecorationUtils.borderDecorationBox(),
                  height: Get.height * 0.2,
                  child: ListView(
                    children: model.data!
                        .map((e) => GetBuilder<AnnouncementViewModel>(
                              tag: AnnouncementViewModel().toString(),
                              builder: (con) {
                                return Container(
                                  decoration: BoxDecoration(
                                      color:
                                          con.selectedSectionList.contains(e.id)
                                              ? ColorUtils.blue
                                              : ColorUtils.transparent,
                                      borderRadius: BorderRadius.circular(4)),
                                  margin: EdgeInsets.only(
                                      top: model.data!.indexOf(e) == 0 ? 0 : 5),
                                  child: ListTile(
                                    onTap: () {
                                      viewModel.setSectionList(e.id!);
                                    },
                                    title: Text(
                                      e.name ?? VariableUtils.none,
                                      style:
                                          con.selectedSectionList.contains(e.id)
                                              ? FontTextStyle.poppinsW5S16White
                                              : FontTextStyle.poppinsW5S16Black,
                                    ),
                                  ),
                                );
                              },
                            ))
                        .toList(),
                  ),
                );
              }
              return Container(
                decoration: DecorationUtils.borderDecorationBox(),
                height: Get.height * 0.2,
                child: getDataLoadingIndicator(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget studentListTile() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(VariableUtils.selectStud, style: FontTextStyle.poppinsW5S12Grey),
          SizeConfig.sH10,
          GetBuilder<DropdownOptionViewModel>(
            tag: DropdownOptionViewModel().toString(),
            builder: (controller) {
              if (controller.getMultipleClassStudentOptionApiResponse.status ==
                  Status.INITIAL) {
                return Container(
                  decoration: DecorationUtils.borderDecorationBox(),
                  height: Get.height * 0.2,
                );
              }
              if (controller.getMultipleClassStudentOptionApiResponse.status ==
                  Status.COMPLETE) {
                GetMultipleClassStudOptionResModel model =
                    controller.getMultipleClassStudentOptionApiResponse.data;

                // List<dynamic> list = model.data!.map((e) => e.name).toList();
                return Container(
                  decoration: DecorationUtils.borderDecorationBox(),
                  height: Get.height * 0.2,
                  child: ListView(
                    children: model.data!
                        .map((e) => GetBuilder<AnnouncementViewModel>(
                              tag: AnnouncementViewModel().toString(),
                              builder: (con) {
                                return Container(
                                  decoration: BoxDecoration(
                                      color: con.selectedClassStudList
                                              .contains(e.id)
                                          ? ColorUtils.blue
                                          : ColorUtils.transparent,
                                      borderRadius: BorderRadius.circular(4)),
                                  margin: EdgeInsets.only(
                                      top: model.data!.indexOf(e) == 0 ? 0 : 5),
                                  child: ListTile(
                                    onTap: () {
                                      viewModel.setClassStudList(e.id!);
                                    },
                                    title: Text(
                                      e.name ?? VariableUtils.none,
                                      style: con.selectedClassStudList
                                              .contains(e.id)
                                          ? FontTextStyle.poppinsW5S16White
                                          : FontTextStyle.poppinsW5S16Black,
                                    ),
                                  ),
                                );
                              },
                            ))
                        .toList(),
                  ),
                );
              }
              return Container(
                decoration: DecorationUtils.borderDecorationBox(),
                height: Get.height * 0.2,
                child: getDataLoadingIndicator(),
              );
            },
          ),
        ],
      ),
    );
  }
}

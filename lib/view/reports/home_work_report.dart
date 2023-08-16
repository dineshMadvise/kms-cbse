// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonMethods/toast_msg.dart';
import 'package:msp_educare_demo/common/commonWidgets/add_or_forword_circle_box.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_btn.dart';
import 'package:msp_educare_demo/common/commonWidgets/date_box.dart';
import 'package:msp_educare_demo/common/commonWidgets/loading_dropdown.dart';
import 'package:msp_educare_demo/common/commonWidgets/octo_image_network.dart';
import 'package:msp_educare_demo/dialog/homework_dialog.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/homework_report_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_class_option_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_homework_list_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_multiple_class_section_option_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/dateformat_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/validation_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/dropdown_options_viewmodel.dart';
import 'package:msp_educare_demo/viewModel/report_viewmodel.dart';
import '../../common/commonWidgets/custom_datetime_textfield.dart';

class HomeWorkReport extends StatefulWidget {
  const HomeWorkReport({Key? key}) : super(key: key);

  @override
  State<HomeWorkReport> createState() => _HomeWorkReportState();
}

class _HomeWorkReportState extends State<HomeWorkReport> {
  final formKey = GlobalKey<FormState>();

  final DropdownOptionViewModel _optionViewModel =
      Get.find(tag: DropdownOptionViewModel().toString());
  final ReportViewModel reportViewModel =
      Get.find<ReportViewModel>(tag: ReportViewModel().toString());
  HomeworkReportReqModel reqModel = HomeworkReportReqModel();

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    _optionViewModel.getClassOption();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _optionViewModel.clearApplyPaymentOption();
      reportViewModel.clearExpansionPanelList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: VariableUtils.homeWorkReport,
      ),
      body: buildBody(),
    );
  }

  Container buildBody() {
    return Container(
      height: Get.height,
      width: Get.width,
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      decoration: DecorationUtils.commonDecorationBox(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: formData(),
    );
  }

  /// ====================  FORM DATA  ==================== ///

  SingleChildScrollView formData() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 5),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            classDropDown(),
            SizeConfig.sH20,
            sectionDropDown(),
            SizeConfig.sH20,
            CustomDateTimeTextField(
              titleText: VariableUtils.date,
              firstDate: DateTime(2000),
              onChangeDateTime: (value) {
                reqModel.date = DateFormatUtils.ddMMYYYY2Format(value);
                print('DATE :$value');
              },
            ),
            SizeConfig.sH20,
            GetBuilder<ReportViewModel>(
              tag: ReportViewModel().toString(),
              builder: (controller) {
                if (controller.homeworkReportsAttendanceApiResponse.status ==
                    Status.LOADING) {
                  return getDataLoadingIndicator();
                }
                return CustomBtn(
                  onTap: () {
                    logs('REQ==>${reqModel.toJson()}');
                    if (reqModel.toJson().values.toList().indexWhere(
                            (element) => element == null || element == "") >
                        -1) {
                      showToast(msg: VariableUtils.allFieldsAreRequired);
                      return;
                    }
                    reportViewModel.homeworkReportsAttendance(reqModel);
                  },
                  radius: 10,
                  title: VariableUtils.search,
                );
              },
            ),
            GetBuilder<ReportViewModel>(
              tag: ReportViewModel().toString(),
              builder: (controller) {
                if (controller.homeworkReportsAttendanceApiResponse.status ==
                        Status.INITIAL ||
                    controller.homeworkReportsAttendanceApiResponse.status ==
                        Status.LOADING) {
                  return const SizedBox();
                }
                if (controller.homeworkReportsAttendanceApiResponse.status ==
                    Status.ERROR) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: getDataErrorMsg(),
                  );
                }
                GetHomeworkListResModel model =
                    controller.homeworkReportsAttendanceApiResponse.data;
                if (model.status != VariableUtils.ok) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: getFieldIsEmptyMsg(),
                  );
                }

                print('LENGTH:${model.dATA!.length}');
                return model.dATA!.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: getNotApplicableMsg(msg: model.msg),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ListView.builder(
                          itemCount: model.dATA!.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final data = model.dATA![index];

                            return Container(
                              decoration: DecorationUtils.commonDecorationBox(),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 0),
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      srNoBox(
                                        text:
                                            ConstUtils.getUserData().usertype ==
                                                    ConstUtils.kGetRoleIndex(
                                                        VariableUtils.parent)
                                                ? data.hDate!.substring(0, 2)
                                                : data.submissionList!.isEmpty
                                                    ? "0"
                                                    : "1",
                                      ),
                                      SizeConfig.sW10,
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        data.title ??
                                                            VariableUtils.none,
                                                        style: FontTextStyle
                                                            .poppinsW6S18Black,
                                                      ),
                                                      SizeConfig.sH7,
                                                      Text(
                                                        '${data.className ?? VariableUtils.none}\t\t${data.subjectName ?? VariableUtils.none}\t\t${data.teacherName ?? VariableUtils.none}',
                                                        style: FontTextStyle
                                                            .poppinsW5S12Grey,
                                                      ),
                                                      // SizeConfig.sH5,
                                                      // Text(
                                                      //   data.teacherName ?? VariableUtils.none,
                                                      //   style: FontTextStyle
                                                      //       .poppinsW5S12Grey,
                                                      // )
                                                    ],
                                                  ),
                                                ),
                                                trailingCircleBox(
                                                    index: index,
                                                    data: data,
                                                    homeWorkViewModel:
                                                        controller,
                                                    addIcon:
                                                        data.submissionList ==
                                                                null
                                                            ? false
                                                            : data.submissionList!
                                                                    .isEmpty
                                                                ? false
                                                                : true),
                                              ],
                                            ),
                                            SizeConfig.sH10,
                                            DateBox(
                                              text:
                                                  "${data.hDate ?? VariableUtils.none} - ${data.completeDate ?? VariableUtils.none}",
                                            ),
                                            SizeConfig.sH5,
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (controller.expansionPanelList
                                      .contains(index))
                                    expansionPanelBox(data),
                                ],
                              ),
                            );
                          },
                        ),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// ====================  CLASS DROPDOWN  ==================== ///
  Widget classDropDown() {
    return GetBuilder<DropdownOptionViewModel>(
      tag: DropdownOptionViewModel().toString(),
      builder: (controller) {
        if (controller.getCLassOptionApiResponse.status == Status.COMPLETE) {
          GetClassOptionResModel model =
              controller.getCLassOptionApiResponse.data;

          List<String?> data = model.data!.map((e) => e.name).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(VariableUtils.selectClass.toUpperCase(),
                  style: FontTextStyle.poppinsW5S12Grey),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<String>(
                isExpanded: true,
                items: data
                    .map((e) => DropdownMenuItem(
                          child: Text('$e'),
                          value: e,
                        ))
                    .toList(),
                // value: controller.selectedSubject == ""
                //     ? null
                //     : controller.selectedSubject,
                icon: const Icon(
                  ConstUtils.kDownArrowIcon,
                  color: ColorUtils.grey,
                ),
                validator: ValidationMethod.validateIsRequired,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: FontTextStyle.poppinsW5S16Black,
                onChanged: (String? value) {
                  reqModel.classId = model.data!
                      .firstWhere((element) => element.name == value)
                      .id;
                  _optionViewModel
                      .getMultiClassSectionOption(reqModel.classId ?? "");
                },
                hint: Text(
                  VariableUtils.select,
                  style: FontTextStyle.poppinsW5S12Grey,
                ),
                decoration: DecorationUtils.inputDecoration(),
              ),
            ],
          );
        }
        return const LoadingDropDown(
          title: VariableUtils.selectClass,
        );
      },
    );
  }

  /// ====================  SECTION DROPDOWN  ==================== ///
  Widget sectionDropDown() {
    return GetBuilder<DropdownOptionViewModel>(
      tag: DropdownOptionViewModel().toString(),
      builder: (controller) {
        if (controller.getMultipleClassSectionOptionApiResponse.status ==
            Status.COMPLETE) {
          GetMultipleClassSectionOptionResModel model =
              controller.getMultipleClassSectionOptionApiResponse.data;

          List<String?> data = model.data!.map((e) => e.name).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(VariableUtils.selectSection.toUpperCase(),
                  style: FontTextStyle.poppinsW5S12Grey),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<String>(
                isExpanded: true,
                items: data
                    .map((e) => DropdownMenuItem(
                          child: Text('$e'),
                          value: e,
                        ))
                    .toList(),
                // value: controller.selectedSubject == ""
                //     ? null
                //     : controller.selectedSubject,
                icon: const Icon(
                  ConstUtils.kDownArrowIcon,
                  color: ColorUtils.grey,
                ),
                validator: ValidationMethod.validateIsRequired,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: FontTextStyle.poppinsW5S16Black,
                onChanged: (String? value) {
                  reqModel.sectionId = model.data!
                      .firstWhere((element) => element.name == value)
                      .id;
                },
                hint: Text(
                  VariableUtils.select,
                  style: FontTextStyle.poppinsW5S12Grey,
                ),
                decoration: DecorationUtils.inputDecoration(),
              ),
            ],
          );
        }
        return const LoadingDropDown(
          title: VariableUtils.selectSection,
        );
      },
    );
  }

  GestureDetector trailingCircleBox(
      {bool addIcon = false,
      int? index,
      required HomeWorkData data,
      ReportViewModel? homeWorkViewModel,
      SubmissionList? submissionData}) {
    return GestureDetector(
        onTap: () {
          if (!addIcon) {
            showHomeworkDialog(data, index!,
                submissionData: submissionData, isReport: true);
          } else {
            reportViewModel.setExpansionPanelList(index!);
          }
        },
        child: AddOrForwordCircleBox(
            icon: addIcon
                ? homeWorkViewModel!.expansionPanelList.contains(index)
                    ? ConstUtils.kMinusIcon
                    : ConstUtils.kAddIcon
                : ConstUtils.kForwordArrowIcon));
  }

  Widget expansionPanelBox(HomeWorkData data) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: data.submissionList!
          .map((e) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Divider(),
                  ),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      srNoBox(
                          color: ColorUtils.lightGreen,
                          isText: false,
                          text: e.studentPic),
                      SizeConfig.sW10,
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            e.studentName ?? VariableUtils.none,
                            style: FontTextStyle.poppinsW6S18Black,
                          ),
                          SizeConfig.sH5,
                          Text(
                            '${e.className ?? VariableUtils.none}',
                            style: FontTextStyle.poppinsW5S12Grey,
                          ),
                          SizeConfig.sH5,
                          DateBox(
                            textStyle: FontTextStyle.poppinsW6S13Grey,
                            text: e.createdOn ?? VariableUtils.none,
                          ),
                        ],
                      ),
                      const Spacer(),
                      trailingCircleBox(
                          data: data,
                          index: data.submissionList!.indexOf(e),
                          submissionData: e)
                    ],
                  )
                ],
              ))
          .toList(),
    );
  }

  Container srNoBox({Color? color, String? text, bool isText = true}) {
    return Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(
          color: color ?? ColorUtils.lightRed,
          borderRadius: BorderRadius.circular(5)),
      child: Center(
        child: isText
            ? Text(
                text ?? '',
                style: FontTextStyle.poppinsW5S20White,
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipOval(
                  child: OctoImageNetwork(
                    url: text,
                    radius: 25,
                    width: 50,
                    height: 50,
                  ),
                ),
              ),
      ),
    );
  }
}

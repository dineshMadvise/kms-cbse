import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_btn.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_datetime_textfield.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_dropdown.dart';
import 'package:msp_educare_demo/logic/attendance_logic.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/get_stud_att_list_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/save_attendance_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_section_option_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_stud_att_list_res_modeldart.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_teacher_class_option_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/dateformat_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/attendance_viewmodel.dart';
import 'package:msp_educare_demo/viewModel/dropdown_options_viewmodel.dart';

class AddAttendance extends StatefulWidget {
  @override
  State<AddAttendance> createState() => _AddAttendanceState();
}

class _AddAttendanceState extends State<AddAttendance> {
  final formKey = GlobalKey<FormState>();
  SaveAttendanceReqModel reqModel = SaveAttendanceReqModel();
  AttendanceViewModel viewModel =
      Get.find(tag: AttendanceViewModel().toString());

  final DropdownOptionViewModel _optionViewModel =
      Get.find(tag: DropdownOptionViewModel().toString());
  DateTime now = DateTime.now();
  UserData userData = ConstUtils.getUserData();

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    // _optionViewModel.getClassOption();
    viewModel.clearSelectedStudent();
    _optionViewModel.getTeacherClassOption(userData.userid!);
    reqModel.aDate = DateFormatUtils.yyyyMMDDFormat(now);
    viewModel.resetSaveAttendance();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: VariableUtils.addAttendance,
      ),
      body: buildBody(),
    );
  }

  Container buildBody() {
    return Container(
      // height: Get.height,
      width: Get.width,
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      decoration: DecorationUtils.commonDecorationBox(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: userData.usertype == ConstUtils.kGetRoleIndex(VariableUtils.admin)
          ? getNotApplicableMsg()
          : formData(),
    );
  }

  SingleChildScrollView formData() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            classDropdown(),
            SizeConfig.sH20,
            sectionDropdown(),
            SizeConfig.sH20,
            CustomDateTimeTextField(
              titleText: VariableUtils.date,
              initialValue: now,
              firstDate: DateTime(now.year),
              onChangeDateTime: (value) {
                reqModel.aDate = DateFormatUtils.yyyyMMDDFormat(value);
                getStudList();
                print('DATE :$value');
              },
            ),
            SizeConfig.sH20,
            GetBuilder<AttendanceViewModel>(
              tag: AttendanceViewModel().toString(),
              builder: (controller) {
                if (controller.getStudAttendanceListApiResponse.status ==
                    Status.INITIAL) {
                  return const SizedBox();
                }
                if (controller.getStudAttendanceListApiResponse.status ==
                    Status.LOADING) {
                  return getDataLoadingIndicator();
                }
                if (controller.getStudAttendanceListApiResponse.status ==
                    Status.ERROR) {
                  return getDataErrorMsg();
                }
                GetStudAttListResModel model =
                    controller.getStudAttendanceListApiResponse.data;
                if (model.status != VariableUtils.ok) {
                  return getFieldIsEmptyMsg();
                }
                print('LENGTH:${model.data!.length}');
                if (model.data!.isEmpty) {
                  return emptyMsg();
                }
                viewModel.selectedStudent = model.data!;
                print('LENGTH:${controller.selectedStudent.length}');
                return  Column(
                  children: [
                    Container(
                      color: ColorUtils.black2,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 15),
                      child: Row(
                        children: List.generate(
                            ConstUtils.kStudAttendanceTableRowList
                                .length, (index) {
                          return Expanded(
                            flex: 2,
                            child: Text(
                              ConstUtils
                                  .kStudAttendanceTableRowList[
                              index],
                              style: FontTextStyle.poppinsW6S14White,
                              textAlign: TextAlign.center,
                            ),
                          );
                        }),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: ColorUtils.lightGrey)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: model.data!
                            .map((e) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (model.data!.indexOf(e) == 0)
                              SizeConfig.sH5,
                            Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Text(
                                      e.name ??
                                          VariableUtils.none,
                                      textAlign:
                                      TextAlign.center,
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding:
                                      const EdgeInsets
                                          .only(right: 5),
                                      child: CustomDropDown(
                                        listData:
                                        _optionViewModel
                                            .attendanceStatusList,
                                        onChangeString:
                                            (val) {
                                          e.attendance = val;
                                          viewModel
                                              .setStudentAttendance(
                                              e);
                                        },
                                        titleText: "",
                                        value: e.attendance,
                                      ),
                                    )),
                              ],
                            ),
                            if(e.leaveInfo!=null&&e.leaveInfo!="")
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                              child: Text(e.leaveInfo??VariableUtils.none),
                            ),
                            model.data!.indexOf(e) <
                                model.data!.length - 1
                                ? const Divider()
                                : SizeConfig.sH5,
                          ],
                        ))
                            .toList(),
                      ),
                    ),
                  ],
                );
              },
            ),
            SizeConfig.sH20,
            GetBuilder<AttendanceViewModel>(
              tag: AttendanceViewModel().toString(),
              builder: (controller) {
                if (controller.saveAttendanceApiResponse.status ==
                        Status.LOADING ||
                    controller.saveAttendanceApiResponse.status ==
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
      final status = await AttendanceLogic.saveAttendance(reqModel);
      // if (status) {
      //   // await Future.delayed(const Duration(seconds: 4));
      //   // formKey.currentState!.reset();
      //   Get.back();
      // }
    }
  }

  void getStudList() {
    GetStudAttListReqModel model = GetStudAttListReqModel();
    model.classId = reqModel.classId;
    model.sectionId = reqModel.sectionId;
    model.aDate = reqModel.aDate;
    viewModel.getStudAttendanceList(model);
  }

  GetBuilder<DropdownOptionViewModel> classDropdown() {
    return GetBuilder<DropdownOptionViewModel>(
      tag: DropdownOptionViewModel().toString(),
      builder: (controller) {
        if (controller.getTeacherClassOptionApiResponse.status ==
            Status.COMPLETE) {
          GetTeacherClassOptionResModel model =
              controller.getTeacherClassOptionApiResponse.data;
          List<String?> list = model.data!.map((e) => e.name).toList();
          return CustomDropDown(
            titleText: VariableUtils.selectClass,
            listData: ConstUtils.convertNullSafetyListToSimpleList(list),
            value: null,
            onChangeString: (value) {
              reqModel.classId =
                  model.data!.firstWhere((element) => element.name == value).id;
              _optionViewModel.getSectionOption(reqModel.classId!);
              if (reqModel.sectionId != null) {
                getStudList();
              }
              print('SELECTED CALUE =>$value');
            },
          );
        }
        return loadingDropdown(VariableUtils.selectClass);
      },
    );
  }

  GetBuilder<DropdownOptionViewModel> sectionDropdown() {
    return GetBuilder<DropdownOptionViewModel>(
      tag: DropdownOptionViewModel().toString(),
      builder: (controller) {
        if (controller.getSectionOptionApiResponse.status == Status.COMPLETE) {
          GetSectionOptionResModel model =
              controller.getSectionOptionApiResponse.data;
          List<String?> list = model.data!.map((e) => e.name).toList();
          return CustomDropDown(
            titleText: VariableUtils.selectSection,
            listData: ConstUtils.convertNullSafetyListToSimpleList(list),
            value: null,
            onChangeString: (value) {
              reqModel.sectionId =
                  model.data!.firstWhere((element) => element.name == value).id;
              getStudList();
              print('SELECTED CALUE =>$value');
            },
          );
        }
        return loadingDropdown(VariableUtils.selectSection);
      },
    );
  }

  CustomDropDown loadingDropdown(String title) {
    return CustomDropDown(
      titleText: title,
      listData: [],
      value: null,
      onChangeString: (value) {},
    );
  }
}

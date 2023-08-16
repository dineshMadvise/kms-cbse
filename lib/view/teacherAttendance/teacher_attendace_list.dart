// ignore_for_file: use_key_in_widget_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_btn.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_datetime_textfield.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_dropdown.dart';
import 'package:msp_educare_demo/logic/teacher_attendance_logic.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_teacher_attendance_list_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/dropdown_options_viewmodel.dart';
import 'package:msp_educare_demo/viewModel/teacher_viewmodel.dart';

class TeacherAttendanceList extends StatefulWidget {
  @override
  _TeacherAttendanceListState createState() => _TeacherAttendanceListState();
}

class _TeacherAttendanceListState extends State<TeacherAttendanceList> {
  final TeacherAttendanceViewModel _viewModel =
      Get.find(tag: TeacherAttendanceViewModel().toString());
  final dropDownViewModel = Get.find<DropdownOptionViewModel>(
      tag: DropdownOptionViewModel().toString());
  DateTime now = DateTime.now();

  @override
  void initState() {
    init();
    _viewModel.selectedDate = now;
    super.initState();
  }

  void init() {
    _viewModel.clearSelectedTeacher();
    _viewModel.getTeacherAttendanceList(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
          title: VariableUtils.teacherAttListing, centerTitle: true),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Container(
      height: Get.height,
      width: Get.width,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      decoration: DecorationUtils.commonDecorationBox(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomDateTimeTextField(
              titleText: VariableUtils.date,
              initialValue: now,
              firstDate: DateTime(2000),
              onChangeDateTime: (value) {
                print('DATE :$value');
                _viewModel.getTeacherAttendanceList(value);
                _viewModel.selectedDate = value;
              },
            ),
            SizeConfig.sH20,
            SizedBox(
              width: Get.width,
              child: GetBuilder<TeacherAttendanceViewModel>(
                tag: TeacherAttendanceViewModel().toString(),
                builder: (controller) {
                  if (controller.getTeacherAttendanceListApiResponse.status ==
                          Status.LOADING ||
                      controller.getTeacherAttendanceListApiResponse.status ==
                          Status.INITIAL) {
                    return getDataLoadingIndicator();
                  }
                  if (controller.getTeacherAttendanceListApiResponse.status ==
                      Status.ERROR) {
                    return getDataErrorMsg();
                  }
                  GetTeacherAttendanceListResModel model =
                      controller.getTeacherAttendanceListApiResponse.data;
                  if (model.status != VariableUtils.ok) {
                    return getFieldIsEmptyMsg();
                  }
                  print('LENGTH:${model.data!.length}');
                  if (model.data!.isEmpty) {
                    return getNotApplicableMsg(msg: model.msg);
                  }
                  _viewModel.selectedTeacher = model.data!;
                  print('LENGTH:${controller.selectedTeacher.length}');
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        children: [
                          Container(
                            color: ColorUtils.black2,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 15),
                            child: Row(
                              children: List.generate(
                                  ConstUtils.kTeacherAttendanceTableRowList
                                      .length, (index) {
                                return Expanded(
                                  flex: 2,
                                  child: Text(
                                    ConstUtils
                                            .kTeacherAttendanceTableRowList[
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
                                                          dropDownViewModel
                                                              .attendanceStatusList,
                                                      onChangeString:
                                                          (val) {
                                                        e.attendance = val;
                                                        _viewModel
                                                            .setTeacherAttendance(
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
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      controller.saveTeacherAttendanceApiResponse.status ==
                              Status.LOADING
                          ? getDataLoadingIndicator()
                          : CustomBtn(
                              radius: 10,
                              onTap: () {
                                TeacherAttendanceLogic.saveTeacherAttendance();
                              },
                              width: Get.width * 0.8,
                              title: VariableUtils.save)
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

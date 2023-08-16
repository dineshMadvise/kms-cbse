// ignore_for_file: use_key_in_widget_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/common/commonWidgets/small_user_profile_box.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_attendance_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/dateformat_utils.dart';
import 'package:msp_educare_demo/utils/extention_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/attendance_viewmodel.dart';

import '../../common/commonMethods/loading_indicator.dart';
import '../../model/apiModel/responseModel/login_res_model.dart';

class AttendanceList extends StatefulWidget {
  @override
  State<AttendanceList> createState() => _AttendanceListState();
}

class _AttendanceListState extends State<AttendanceList> {
  AttendanceViewModel viewModel =
      Get.find(tag: AttendanceViewModel().toString());
  late UserData userData;
  final now = DateTime.now();

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    print('Initializing... $init()');
    userData = ConstUtils.getUserData();
    viewModel.getAttendanceList(now);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      viewModel.selectedMonth = now;
      viewModel.isGetAttendanceLoading = false;
      viewModel.setSelectedAttendanceInfo(null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: VariableUtils.attendance,
        centerTitle: true,
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        if (userData.usertype == ConstUtils.kGetRoleIndex(VariableUtils.parent))
          SmallUserProfileBox(),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 20),
        //   child: CustomDateTimeTextField(
        //     titleText: VariableUtils.date,
        //     isTitleVisible: false,
        //     initialValue: DateTime.now(),
        //     firstDate: DateTime(1997),
        //     onChangeDateTime: (value) {
        //       viewModel.getAttendanceList(value);
        //       viewModel.selectedMonth = value;
        //       viewModel.isGetAttendanceLoading = false;
        //       viewModel.setSelectedAttendanceInfo(null);
        //     },
        //   ),
        // ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: SizedBox(
            height: Get.height,
            width: Get.width,
            // margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
            // decoration: DecorationUtils.commonDecorationBox(),
            // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: GetBuilder<AttendanceViewModel>(
              tag: AttendanceViewModel().toString(),
              builder: (controller) {
                if (controller.getAttendanceListApiResponse.status ==
                        Status.LOADING ||
                    controller.getAttendanceListApiResponse.status ==
                        Status.INITIAL) {
                  return getDataLoadingIndicator();
                }
                if (controller.getAttendanceListApiResponse.status ==
                    Status.ERROR) {
                  return getDataErrorMsg();
                }
                GetAttendanceResModel model =
                    controller.getAttendanceListApiResponse.data;
                if (model.status != VariableUtils.ok) {
                  return getFieldIsEmptyMsg();
                }

                if (model.dATA?.isEmpty == true) {
                  return emptyMsg();
                }

                return successResultWidget(model.dATA!, controller);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget successResultWidget(List<DATA> data, AttendanceViewModel con) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              VariableUtils.totalNumberOfWorkingDays,
              style: FontTextStyle.poppinsW5S14DarkGrey,
            ),
          ),
          SizeConfig.sH7,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  ConstUtils.kWatchIcon,
                  color: ColorUtils.blue,
                  size: 20,
                ),
                SizeConfig.sW5,
                Text(
                  "${data.first.workingDays ?? VariableUtils.none}",
                  style: FontTextStyle.poppinsW6S16Black,
                ),
              ],
            ),
          ),
          SizeConfig.sH20,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              children: data.first.legends!
                  .map((e) => Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            color: e.colorCode!.toColor(),
                          ),
                          SizeConfig.sW5,
                          Text(
                            e.name ?? VariableUtils.none,
                            style: FontTextStyle.poppinsW5S14Grey,
                          )
                        ],
                      ))
                  .toList(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    viewModel.backwardDate();
                  },
                  icon: const Icon(Icons.arrow_back_ios_outlined)),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: '${DateFormat('MMMM').format(con.selectedMonth)} ',
                    style: FontTextStyle.poppinsW7S22Black),
                TextSpan(
                    text: '${con.selectedMonth.year}',
                    style: FontTextStyle.poppinsW6S14Black),
              ])),
              IconButton(
                  onPressed: () {
                    viewModel.forwardDate();
                  },
                  icon: const Icon(Icons.arrow_forward_ios_outlined)),
            ],
          ),
          SizeConfig.sH20,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: ConstUtils.kShortDaysList
                  .map((e) => Expanded(
                          child: Text(
                        e,
                        textAlign: TextAlign.center,
                        style: FontTextStyle.poppinsW6S14Black,
                      )))
                  .toList(),
            ),
          ),
          SizeConfig.sH10,
          con.isGetAttendanceLoading
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: getDataLoadingIndicator(),
                )
              : (data.first.attendanceInfo?.length ?? 0) == 0
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GridView.builder(
                          shrinkWrap: true,
                          itemCount:
                              data.first.attendanceInfo!.length + con.extraDays,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 7),
                          itemBuilder: (_, index) {
                            if (index < con.extraDays) {
                              return const SizedBox();
                            }
                            final attendanceInfo = data
                                .first.attendanceInfo![index - con.extraDays];
                            return InkWell(
                              onTap: () {
                                viewModel
                                    .setSelectedAttendanceInfo(attendanceInfo);
                              },
                              child: Container(
                                height: 50,
                                decoration:
                                    con.selectedAttendanceInfo?.runningDate ==
                                            attendanceInfo.runningDate
                                        ? BoxDecoration(
                                            border: Border.all(
                                                color: ColorUtils.blue,
                                                width: 2),
                                            color: (attendanceInfo.colorCode ??
                                                    '#ffffff')
                                                .toColor())
                                        : BoxDecoration(
                                            color: (attendanceInfo.colorCode ??
                                                    '#ffffff')
                                                .toColor()),
                                child: Center(
                                    child: Text(
                                  '${(index + 1) - con.extraDays}',
                                  // style:
                                  //     con.selectedAttendanceInfo?.runningDate ==
                                  //             attendanceInfo.runningDate
                                  //         ? FontTextStyle.poppinsW5S16White
                                  //         : FontTextStyle.poppinsW5S14Black,
                                )),
                              ),
                            );
                          }),
                    ),
          if (con.selectedAttendanceInfo != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    con.selectedAttendanceInfo?.description ??
                        VariableUtils.none,
                    style: FontTextStyle.poppinsW6S18Black,
                  ),
                  // SizeConfig.sH5,
                  // Text(
                  //   con.selectedAttendanceInfo?.description ?? VariableUtils.none,
                  //   style: FontTextStyle.poppinsW5S12DarkGrey,
                  // ),
                  SizeConfig.sH5,
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: 'Date : ', style: FontTextStyle.poppinsW5S14Grey),
                    TextSpan(
                        text: DateFormatUtils.ddMMMYYYYFormat(DateTime.parse(
                            con.selectedAttendanceInfo!.runningDate!)),
                        style: FontTextStyle.poppinsW5S14Black)
                  ])),
                ],
              ),
            )
        ],
      ),
    );
  }
}

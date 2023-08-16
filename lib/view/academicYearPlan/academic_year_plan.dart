// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_academic_year_plan_list.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/dateformat_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/academic_year_plan_viewmodel.dart';

class AcademicYearPlan extends StatefulWidget {
  const AcademicYearPlan({Key? key}) : super(key: key);

  @override
  State<AcademicYearPlan> createState() => _AcademicYearPlanState();
}

class _AcademicYearPlanState extends State<AcademicYearPlan> {
  final viewModel = Get.find<AcademicYearPlanVideModel>(
      tag: AcademicYearPlanVideModel().toString());

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    viewModel.getAcademicYearPlanList();
  }

  @override
  Widget build(BuildContext context) {
    print('DATE ;${DateTime.now()}');
    return Scaffold(
        appBar: customAppbar(
          title: VariableUtils.academicYearPlan,
        ),
        body: GetBuilder<AcademicYearPlanVideModel>(
          tag: AcademicYearPlanVideModel().toString(),
          builder: (controller) {
            if (controller.getAcademicYearPlanListApiResponse.status ==
                    Status.LOADING ||
                controller.getAcademicYearPlanListApiResponse.status ==
                    Status.INITIAL) {
              return getDataLoadingIndicator();
            }
            if (controller.getAcademicYearPlanListApiResponse.status ==
                Status.ERROR) {
              return getDataErrorMsg();
            }
            GetAcademicYearPlanListResModel model =
                controller.getAcademicYearPlanListApiResponse.data;
            if (model.status != VariableUtils.ok) {
              return getFieldIsEmptyMsg();
            }
            print('LENGTH:${model.data!.length}');
            return model.data!.isEmpty
                ? getNotApplicableMsg(msg: model.msg)
                : successResultWidget(controller, model.data!);
          },
        ));
  }

  Widget successResultWidget(AcademicYearPlanVideModel con, List<Data> data) {
    final list = data
        .where((e) =>
            (DateTime.parse(e.startDate!).year == con.selectedMonth.year &&
                DateTime.parse(e.startDate!).month ==
                    con.selectedMonth.month) ||
            (DateTime.parse(e.endDate!).year == con.selectedMonth.year &&
                DateTime.parse(e.endDate!).month == con.selectedMonth.month))
        .toList();
    print('DATA :=>${list.map((e) => e.title).toList()}');
    List<CalenderData> dateList = [];
    list.forEach((element) {
      for (int index = 1; index <= con.totalDays; index++) {
        final date =
            DateTime(con.selectedMonth.year, con.selectedMonth.month, index);
        final startDate = DateTime.parse(element.startDate!);
        final endDate = DateTime.parse(element.endDate!);
        final model = CalenderData(
            color: int.parse('0xff' + element.color!.replaceAll("#", "")),
            title: element.title,
            descriptions: element.descriptions,
            endDate: DateTime.parse(element.endDate!),
            startDate: DateTime.parse(element.startDate!),
            matchDate: date);
        if (date.isAtSameMomentAs(startDate) ||
            date.isAtSameMomentAs(endDate)) {
          dateList.add(model);
        } else if (date.isAfter(startDate) && date.isBefore(endDate)) {
          dateList.add(model);
        }
      }
    });

    print('DATE LIST :+>${dateList}');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SizeConfig.sH10,
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GridView.builder(
              shrinkWrap: true,
              itemCount: con.totalDays + con.extraDays,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
              itemBuilder: (_, index) {
                if (index < con.extraDays) {
                  return const SizedBox();
                }
                final matchIndex = dateList.indexWhere((e) =>
                    DateTime(con.selectedMonth.year, con.selectedMonth.month,
                        (index + 1) - con.extraDays) ==
                    e.matchDate);
                int colorCode = 0;
                if (matchIndex > -1) {
                  colorCode = dateList[matchIndex].color!;
                }
                return InkWell(
                  onTap: () {
                    if (matchIndex > -1) {
                      print('SELCTED EVENT :=>${dateList[matchIndex].title}');
                      viewModel.setCalenderDate(dateList[matchIndex]);
                      print('SELECTED DATE :+>${con.selectedCalenderDate}');
                    }
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: matchIndex > -1
                                ? dateList[matchIndex].matchDate ==
                                        con.selectedCalenderDate?.matchDate
                                    ? ColorUtils.blue
                                    : ColorUtils.transparent
                                : ColorUtils.transparent,
                            width: 3),
                        color: matchIndex > -1
                            ? Color(colorCode)
                            : ColorUtils.transparent),
                    child: Center(
                        child: Text(
                      '${(index + 1) - con.extraDays}',
                      style: TextStyle(
                          color: matchIndex > -1
                              ? dateList[matchIndex].matchDate ==
                                      con.selectedCalenderDate?.matchDate
                                  ? ColorUtils.white
                                  : colorCode == 0xff000000
                                      ? ColorUtils.white
                                      : ColorUtils.black
                              : ColorUtils.black,
                          fontSize: 14),
                    )),
                  ),
                );
              }),
        ),

        if (con.selectedCalenderDate != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  con.selectedCalenderDate?.title ?? VariableUtils.none,
                  style: FontTextStyle.poppinsW6S18Black,
                ),
                SizeConfig.sH5,
                Text(
                  con.selectedCalenderDate?.descriptions ?? VariableUtils.none,
                  style: FontTextStyle.poppinsW5S12DarkGrey,
                ),
                SizeConfig.sH5,
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: 'Date : ', style: FontTextStyle.poppinsW5S14Grey),
                  TextSpan(
                      text: DateFormatUtils.ddMMMYYYYFormat(
                          con.selectedCalenderDate!.matchDate!),
                      style: FontTextStyle.poppinsW5S14Black)
                ])),
                // SizeConfig.sH5,
                // RichText(
                //     text: TextSpan(children: [
                //   TextSpan(
                //       text: 'Start Date : ',
                //       style: FontTextStyle.poppinsW5S12Grey),
                //   TextSpan(
                //       text: DateFormatUtils.ddMMMYYYYFormat(
                //           con.selectedCalenderDate!.endDate!),
                //       style: FontTextStyle.poppinsW5S12Black)
                // ])),
              ],
            ),
          )
      ],
    );
  }
}

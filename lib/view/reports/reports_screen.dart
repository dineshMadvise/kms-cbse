// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:flutter/material.dart';
import '../../common/commonMethods/custom_appbar.dart';
import '../../model/apiModel/requestModel/dashboard_model.dart';
import '../../utils/assets/images_utils.dart';
import '../../utils/color_utils.dart';
import '../../utils/const_utils.dart';
import '../../utils/decoration_utils.dart';
import '../../utils/font_style_utils.dart';
import '../../utils/route_utils.dart';
import '../../utils/variable_utils.dart';

class ReportsScreen extends StatelessWidget {
  ReportsScreen({Key? key}) : super(key: key);

  List<String> reportsItem = [
    VariableUtils.staffAttendance,
    VariableUtils.studentAttendance,
    VariableUtils.homeWork,
    VariableUtils.examScore,
    VariableUtils.payrollReport,
    VariableUtils.financialReport,
    // VariableUtils.expenses,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: VariableUtils.reports,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                  crossAxisSpacing: 20,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 20,
                  children: reportsItem
                      .map((e) => Material(
                            color: ColorUtils.transparent,
                            child: Ink(
                              decoration: DecorationUtils.commonDecorationBox(),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  if (e == VariableUtils.staffAttendance) {
                                    RouteUtils.navigateRoute(
                                      RouteUtils.staffAttendanceReport,
                                    );
                                  } else if (e ==
                                      VariableUtils.studentAttendance) {
                                    RouteUtils.navigateRoute(
                                      RouteUtils.studAttendanceReport,
                                    );
                                  } else if (e == VariableUtils.homeWork) {
                                    RouteUtils.navigateRoute(
                                      RouteUtils.homeWorkReport,
                                    );
                                  } else if (e == VariableUtils.examScore) {
                                    RouteUtils.navigateRoute(
                                      RouteUtils.examScoreReport,
                                    );
                                  } else if (e ==
                                      VariableUtils.financialReport) {
                                    RouteUtils.navigateRoute(
                                      RouteUtils.financialReport,
                                    );
                                  } else if (e == VariableUtils.payrollReport) {
                                    RouteUtils.navigateRoute(
                                      RouteUtils.payrollReport,
                                    );
                                  }
                                  // else if (e ==
                                  //     VariableUtils.expenses) {
                                  //   RouteUtils.navigateRoute(
                                  //       RouteUtils.expensesReport);
                                  // }
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.all(
                                            e == VariableUtils.homeWork ||
                                                    e == VariableUtils.examScore
                                                ? 20
                                                : 10),
                                        child: getImg(e),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          20,
                                          e.trim() == VariableUtils.transport
                                              ? 0
                                              : 15,
                                          20,
                                          15),
                                      child: Text(
                                        e,
                                        style: FontTextStyle.poppinsW6S14Black,
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getImg(String str) {
    return ConstUtils.kDashBoardCatList
        .firstWhere(
          (element) =>
              element.title.replaceAll(" ", "") == str.replaceAll(" ", ""),
          orElse: () => DashBoardModel(title: 'demo', img: SvgWidgets.homeWork),
        )
        .img;
  }
}

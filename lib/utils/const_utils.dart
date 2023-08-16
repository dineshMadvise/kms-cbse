// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls, unnecessary_null_comparison
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/dashboard_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/utils/assets/images_utils.dart';
import 'package:msp_educare_demo/utils/shared_preference_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../model/apiModel/responseModel/stud_list_res_model.dart';
import 'dart:developer' as dev;

void logs(String message) {
  if (kDebugMode) {
    dev.log(message);
  }
}

class ConstUtils {
  /// GOOGLE MAP KEY
  static const String kGoogleKey = 'AIzaSyC9d6tms7Ae_AyUV1nM_6YQzvzp3Q8fePM';
  static const String kImageBasePath =
      'https://demo.mspeducare.com/public/uploads/';
  static String alarmNotificationTitle = "";
  static String alarmNotificationBody = "";
  static bool isSecondTimeAlarmPlay = true;
  static int kGpsInterval = 1;

  static const double kCameraZoom = 12;
  static const double kCameraTilt = 0;
  static const double kCameraBearing = 30;

  static String appVersion = "";
  static String buildNumber = "";

  static getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
  }

  static String convertLink(String link) {
    return link.replaceAll("\\", "");
  }

  /// GET USER DATA
  static UserData getUserData() {
    String userData = PreferenceManagerUtils.getUserData();
    print('DATA: =>$userData');
    if (userData != '') {
      if (jsonDecode(userData)?.first == null) {
        return UserData();
      }
      UserData data = UserData.fromJson(jsonDecode(userData).first);
      return data;
    }
    return UserData();
  }

  /// GET STUDENT DATA
  static StudentData getStudentData() {
    String userData = PreferenceManagerUtils.getStudData();
    print('DATA: =>$userData');
    if (userData != '') {
      StudentData data = StudentData.fromJson(jsonDecode(userData));
      return data;
    }
    return StudentData();
  }

  static String formatDouble(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
  }

  static const kOnlineClassInfoStatusOption = <String>[
    VariableUtils.active,
    VariableUtils.inActive
  ];

  // static int kRoleTypeIndex(String role){
  //   if(role ==VariableUtils.admin){
  //     return 0;
  //   }else if(role==VariableUtils.teacher){
  //     return 1;
  //   }else{
  //     return 2;
  //   }
  // }

  /// TEXT FIELD LENGTH VALIDATION
  static const kPasswordLength = 6;
  static const kPhoneNumberLength = 6;

  /// DATETIME

  static final kTotalDayInMonth =
      DateTime(DateTime.now().day, DateTime.now().month + 1, 0).day;

  static String formatDuration(int second) {
    final ms = second * 1000;

    int seconds = ms ~/ 1000;
    final int hours = seconds ~/ 3600;
    seconds = seconds % 3600;
    final minutes = seconds ~/ 60;
    seconds = seconds % 60;

    final hoursString = hours >= 10
        ? '$hours'
        : hours == 0
            ? '00'
            : '0$hours';

    final minutesString = minutes >= 10
        ? '$minutes'
        : minutes == 0
            ? '00'
            : '0$minutes';

    final secondsString = seconds >= 10
        ? '$seconds'
        : seconds == 0
            ? '00'
            : '0$seconds';

    final formattedTime =
        '${hoursString == '00' ? '' : '$hoursString:'}$minutesString:$secondsString';

    return formattedTime;
  }

  ///ICONS
  static const kAddIcon = Icons.add;
  static const kMinusIcon = Icons.remove;
  static const kClearIcon = Icons.clear;
  static const kStarIcon = Icons.star;
  static const kCheckIcon = Icons.check;
  static const kWatchIcon = Icons.watch_later_outlined;
  static const kForwordArrowIcon = Icons.keyboard_arrow_right;
  static const kBackwordArrowIcon = Icons.keyboard_arrow_left;
  static const kDownArrowIcon = Icons.keyboard_arrow_down_rounded;
  static const kBackArrowIcon = Icons.arrow_back_rounded;
  static const kCalenderIcon = Icons.calendar_today;
  static const kDownloadIcon = Icons.file_download;
  static const kLocationIcon = Icons.location_on_outlined;
  static const kCallIcon = Icons.call;

  /// DATETIME

  // static final kTotalDayInMonth =
  //     DateTime(DateTime.now().day, DateTime.now().month + 1, 0).day;

  /// CONST LIST
  static const kRoleList = [
    VariableUtils.teacher,
    VariableUtils.parent,
    VariableUtils.admin
  ];

  /// DAYS LIST
  static const kShortDaysList = [
    VariableUtils.sun,
    VariableUtils.mon,
    VariableUtils.tue,
    VariableUtils.wed,
    VariableUtils.thu,
    VariableUtils.fri,
    VariableUtils.sat
  ];

  static int dayIndex(String day) {
    int index = 0;
    switch (day) {
      case VariableUtils.sunday:
        index = 0;
        break;
      case VariableUtils.monday:
        index = 1;
        break;
      case VariableUtils.tuesday:
        index = 2;
        break;
      case VariableUtils.wednesday:
        index = 3;
        break;
      case VariableUtils.thursday:
        index = 4;
        break;
      case VariableUtils.friday:
        index = 5;
        break;
      case VariableUtils.saturday:
        index = 6;
        break;
      default:
        index = 0;
        break;
    }
    return index;
  }

  static final kDashBoardCatList = [
    DashBoardModel(
        title: VariableUtils.addAttendance, img: SvgWidgets.addAttendance),
    DashBoardModel(
        title: VariableUtils.announcement, img: SvgWidgets.announcement),
    DashBoardModel(
        title: VariableUtils.certificate, img: SvgWidgets.certificate),
    DashBoardModel(title: VariableUtils.claim, img: SvgWidgets.claim),
    DashBoardModel(
        title: VariableUtils.classTimetable, img: SvgWidgets.classTime),
    DashBoardModel(title: VariableUtils.complaint, img: SvgWidgets.complaint),
    DashBoardModel(title: VariableUtils.events, img: SvgWidgets.events),
    DashBoardModel(title: VariableUtils.examScore, img: SvgWidgets.examScore),
    DashBoardModel(title: VariableUtils.examTime, img: SvgWidgets.examTime),
    DashBoardModel(title: VariableUtils.expenses, img: SvgWidgets.expenses),
    DashBoardModel(title: VariableUtils.fees, img: SvgWidgets.fees),
    DashBoardModel(title: VariableUtils.homeWork, img: SvgWidgets.homeWork),
    DashBoardModel(
        title: VariableUtils.leaveApprove, img: SvgWidgets.leaveApprove),
    DashBoardModel(title: VariableUtils.transport, img: SvgWidgets.transport),
    DashBoardModel(title: VariableUtils.leaveReq, img: SvgWidgets.leaveRequest),
    DashBoardModel(
        title: VariableUtils.onlineClass, img: SvgWidgets.onlineClass),
    DashBoardModel(title: VariableUtils.paySlip, img: SvgWidgets.paySlip),
    DashBoardModel(title: VariableUtils.reports, img: SvgWidgets.reports),
    DashBoardModel(
        title: VariableUtils.attendance, img: SvgWidgets.student_atte_listing),
    DashBoardModel(
        title: VariableUtils.teacherAttListing,
        img: SvgWidgets.teacher_attendance),
    DashBoardModel(title: VariableUtils.enquiry, img: SvgWidgets.enquiry),
    DashBoardModel(title: VariableUtils.gallery, img: SvgWidgets.gallery),
    DashBoardModel(
        title: VariableUtils.progressReport, img: SvgWidgets.progressReport),
    DashBoardModel(
        title: VariableUtils.academicYearPlan,
        img: SvgWidgets.academicYearPlan),
    DashBoardModel(
        title: VariableUtils.applyPayment, img: SvgWidgets.applyPayment),
    DashBoardModel(
        title: VariableUtils.addExamScore, img: SvgWidgets.addExamScore),
    DashBoardModel(title: VariableUtils.lessonPlan, img: SvgWidgets.lessonPlan),
    DashBoardModel(
        title: VariableUtils.dailyReport, img: SvgWidgets.dailyReport),
    DashBoardModel(
        title: VariableUtils.financialReport, img: SvgWidgets.financialReport),
    DashBoardModel(
        title: VariableUtils.payrollReport, img: SvgWidgets.payrollReport),
    DashBoardModel(
        title: VariableUtils.staffAttendance,
        img: SvgWidgets.student_atte_listing),
    DashBoardModel(
        title: VariableUtils.studentAttendance,
        img: SvgWidgets.student_atte_listing),
    DashBoardModel(title: VariableUtils.sms, img: SvgWidgets.sms),
    DashBoardModel(title: VariableUtils.voiceCall, img: SvgWidgets.voiceCall),
    DashBoardModel(title: VariableUtils.feedback, img: SvgWidgets.feedback),
  ];

  static const kClassTimeTableDialogTitleListWithoutParent = [
    VariableUtils.time,
    VariableUtils.subject,
    VariableUtils.dialogClass
  ];

  static const kClassTimeTableDialogTitleListWithParent = [
    VariableUtils.time,
    VariableUtils.subject,
    VariableUtils.teacher
  ];

  static const financialReportTableList = [
    VariableUtils.month,
    VariableUtils.income,
    VariableUtils.expense,
    VariableUtils.salary,
  ];
  static const payrollReportTableList = [
    VariableUtils.srNo,
    VariableUtils.staffName,
    // VariableUtils.month,
    VariableUtils.leave,
    VariableUtils.salary,
    VariableUtils.receipt,
  ];

  static const kExamTimeTableDialogTitleList = [
    VariableUtils.date,
    VariableUtils.subject,
    VariableUtils.syllabus
  ];

  static const kExamScoreDialogTitleList = [
    VariableUtils.subject,
    VariableUtils.scoreAndGrade
  ];

  static const kPublicDropDownList = [
    VariableUtils.all,
    VariableUtils.teacher,
    VariableUtils.classStr,
    VariableUtils.classAndSection,
    VariableUtils.student,
  ];

  static const kAnnouncementDialogTableRowList = [
    VariableUtils.sNo,
    VariableUtils.sent,
    VariableUtils.readOn,
    VariableUtils.remark
  ];
  static const kTeacherAttendanceTableRowList = [
    VariableUtils.teacherName,
    VariableUtils.attendance
  ];
  static const kStudAttendanceTableRowList = [
    VariableUtils.studentName,
    VariableUtils.attendance
  ];
  static const kAddExamScoreTableRowList = [
    VariableUtils.studentName,
    VariableUtils.mark
  ];

  static const kPaySLipTableRowList = [
    VariableUtils.sNo,
    VariableUtils.month,
    VariableUtils.basicSalary,
    VariableUtils.totalLeave,
    VariableUtils.payAmount,
    VariableUtils.print,
  ];
  static const kCertificateTableRowList = [
    VariableUtils.sNo,
    VariableUtils.certificate,
    VariableUtils.date,
    VariableUtils.copy,
  ];
  static const kProgressReportTableRowList = [
    VariableUtils.sNo,
    VariableUtils.progressReport,
    VariableUtils.date,
    VariableUtils.copy,
  ];

  static const kFeesPaymentTableRowList = [
    VariableUtils.no,
    VariableUtils.receiptHash,
    VariableUtils.details,
    VariableUtils.date,
    VariableUtils.amount,
    VariableUtils.copy,
  ];
  static const kFeesTableRowList = [
    VariableUtils.no,
    VariableUtils.details,
    VariableUtils.amount,
    VariableUtils.paid,
    VariableUtils.action,
  ];

  static String kGetRoleIndex(String role) {
    if (role == VariableUtils.admin) {
      return "0";
    } else if (role == VariableUtils.teacher) {
      return "1";
    } else {
      return "2";
    }
  }

  static String kGetFileName(String path) {
    return path.substring(path.lastIndexOf('/') + 1);
  }

  static List<String> convertNullSafetyListToSimpleList(List<String?> list) {
    // return list.where((element) => element != null).toList() as List<String>;
    return list.whereType<String>().toList();
  }

  static String convertListToString(List list) {
    String str = '';

    list.forEach((element) {
      str = str + ',' + element;
    });
    if (str == '') {
      return str;
    }
    str = str.substring(1);
    return str;
  }

  static double kConvertStringToDouble(String str) {
    if (str == '') {
      return 0.0;
    } else {
      return double.parse(str);
    }
  }

  static bool kCheckFileExtension(String link) {
    if (link.toLowerCase().contains('ppt') ||
        link.toLowerCase().contains('doc') ||
        link.toLowerCase().contains('pprx') ||
        link.toLowerCase().contains('docs') ||
        link.toLowerCase().contains('xls') ||
        link.toLowerCase().contains('csv') ||
        link.toLowerCase().contains('pdf') ||
        link.toLowerCase().contains('txt')) {
      return true;
    }
    return false;
  }

  static String kAmountValue(String amount) {
    if (amount == '' || amount == null) {
      return VariableUtils.none;
    }
    try {
      // suffix = {' ', 'k', 'M', 'B', 'T', 'P', 'E'};
      double value = double.parse(amount);

      if (value < 1000) {
        // less than a million
        return value.toStringAsFixed(2);
      } else if (value >= 1000 && value < 100000) {
        // less than 100 million
        double result = value / 1000;
        return result.toStringAsFixed(2) + "K";
      } else if (value >= 1000000 && value < (1000000 * 10 * 100)) {
        // less than 100 million
        double result = value / 1000000;
        return result.toStringAsFixed(2) + "M";
      } else if (value >= (1000000 * 10 * 100) &&
          value < (1000000 * 10 * 100 * 100)) {
        // less than 100 billion
        double result = value / (1000000 * 10 * 100);
        return result.toStringAsFixed(2) + "B";
      } else if (value >= (1000000 * 10 * 100 * 100) &&
          value < (1000000 * 10 * 100 * 100 * 100)) {
        // less than 100 trillion
        double result = value / (1000000 * 10 * 100 * 100);
        return result.toStringAsFixed(2) + "T";
      } else {
        return value.toStringAsFixed(2);
      }
    } catch (e) {
      print('CONVERT AMOUNT ERROR : $e');
      return VariableUtils.none;
    }
  }
}

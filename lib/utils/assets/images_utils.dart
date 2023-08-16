// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

String basePath = 'assets/images/';
String svgBasePath = 'assets/svg/';

class ImagesWidgets {
  static String eventsStr = "${basePath}events.png";
  static String busPin = "${basePath}BusPin.png";
  static String stopPin = "${basePath}StopPin.png";
  static String schoolPin = "${basePath}SchoolPin.png";
  static Image loginBg = Image.asset(
    "${basePath}loginBg.png",
    width: Get.width,
    fit: BoxFit.fill,
  );

  static Image appLogo = Image.asset(
    "${basePath}appLogo.png",
    scale: 6,
  );

  static Image appLogo1 = Image.asset(
    "${basePath}appLogo1.png",
    scale: 4,
  );
  static Image appLogo2 = Image.asset(
    "${basePath}appLogo2.png",
    scale: 4,
  );

  static Image addAttendance = Image.asset(
    "${basePath}addAttendance.png",
    scale: 4,
  );
  static Image announcement = Image.asset(
    "${basePath}announcement.png",
    scale: 4,
  );
  static Image attendance = Image.asset(
    "${basePath}attendance.png",
    scale: 4,
  );
  static Image claim = Image.asset(
    "${basePath}claim.png",
    scale: 4,
  );
  static Image classTime = Image.asset(
    "${basePath}classTime.png",
    scale: 4,
  );
  static Image classTimeTable = Image.asset(
    "${basePath}classTimeTable.png",
    scale: 4,
  );
  static Image complaint = Image.asset(
    "${basePath}complaint.png",
    scale: 4,
  );
  static Image events = Image.asset(
    "${basePath}events.png",
    scale: 4,
  );

  static Image examScore = Image.asset(
    "${basePath}examScore.png",
    scale: 4,
  );

  static Image homeWork = Image.asset(
    "${basePath}homeWork.png",
    scale: 4,
  );

  static Image leaveApprove = Image.asset(
    "${basePath}leaveApprove.png",
    scale: 4,
  );

  static Image leaveRequest = Image.asset(
    "${basePath}leaveRequest.png",
    scale: 4,
  );

  static Image onlineClass = Image.asset(
    "${basePath}onlineClass.png",
    scale: 4,
  );

  static Image paySlip = Image.asset(
    "${basePath}paySlip.png",
    scale: 4,
  );
  static Image eventPersonIcon = Image.asset(
    "${basePath}student.png",
    scale: 4,
  );
  static AssetImage personIcon = AssetImage(
    "${basePath}student.png",
  );
}

class SvgWidgets {
  static Image academicYearPlan =
      Image.asset("${svgBasePath}academicYearPlan.jpg");
  static Image addExamScore = Image.asset("${svgBasePath}addExamScore.png");
  static Image applyPayment = Image.asset("${svgBasePath}applyPayment.jpg");
  static Image dailyReport = Image.asset("${svgBasePath}dailyReport.jpg");
  static Image lessonPlan = Image.asset("${svgBasePath}lessonPlan.png");
  static Image financialReport =
      Image.asset("${svgBasePath}financialReport.png");
  static Image payrollReport = Image.asset("${svgBasePath}payrollReport.jpg");

  static SvgPicture addAttendance =
      SvgPicture.asset("${svgBasePath}Add_Student_Attendance.svg");
  static SvgPicture announcement =
      SvgPicture.asset("${svgBasePath}Announcement.svg");

  // static SvgPicture attendance =   SvgPicture.asset("${svgBasePath}Add_Student_Attendance.svg");
  static SvgPicture certificate =
      SvgPicture.asset("${svgBasePath}Certificate.svg");
  static SvgPicture claim = SvgPicture.asset("${svgBasePath}Claim.svg");
  static SvgPicture classTime =
      SvgPicture.asset("${svgBasePath}Class_Timetable.svg");
  static SvgPicture complaint = SvgPicture.asset("${svgBasePath}Complaint.svg");
  static SvgPicture events = SvgPicture.asset("${svgBasePath}Events.svg");
  static SvgPicture examScore =
      SvgPicture.asset("${svgBasePath}Exam_Score.svg");
  static SvgPicture examTime =
      SvgPicture.asset("${svgBasePath}Exam_Timetable.svg");
  static SvgPicture expenses = SvgPicture.asset("${svgBasePath}expenses.svg");
  static SvgPicture fees = SvgPicture.asset("${svgBasePath}Fees.svg");
  static SvgPicture homeWork = SvgPicture.asset("${svgBasePath}Homework.svg");
  static SvgPicture leaveApprove =
      SvgPicture.asset("${svgBasePath}Leave_Approve.svg");
  static SvgPicture transport = SvgPicture.asset("${svgBasePath}Transport.svg");
  static SvgPicture leaveRequest =
      SvgPicture.asset("${svgBasePath}Leave_Request.svg");
  static SvgPicture onlineClass =
      SvgPicture.asset("${svgBasePath}Online_Class.svg");
  static SvgPicture paySlip = SvgPicture.asset("${svgBasePath}Payslip.svg");
  static SvgPicture reports = SvgPicture.asset("${svgBasePath}Reports.svg");
  static SvgPicture student_atte_listing =
      SvgPicture.asset("${svgBasePath}Student_Attendance_Listing.svg");
  static SvgPicture teacher_attendance =
      SvgPicture.asset("${svgBasePath}Teacher_Attendance.svg");
  static SvgPicture enquiry = SvgPicture.asset("${svgBasePath}Enquiry.svg");
  static SvgPicture gallery = SvgPicture.asset("${svgBasePath}Gallery.svg");
  static SvgPicture progressReport =
      SvgPicture.asset("${svgBasePath}ProgressReport.svg");
  static Image sms = Image.asset("${svgBasePath}SMS.png");
  static Image voiceCall = Image.asset("${svgBasePath}voiceCall.png");
  static Image feedback = Image.asset("${svgBasePath}feedback.png");
}

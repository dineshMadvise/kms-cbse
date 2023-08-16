import 'package:msp_educare_demo/utils/route_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';

class DashboardLogic {
  static void onTap(
    String title, {
    String? args,
  }) {
    print('title:$title ${VariableUtils.attendance}');
    switch (title.trim()) {
      case VariableUtils.homeWork:
        RouteUtils.navigateRoute(RouteUtils.homeworkList);
        break;
      case VariableUtils.lessonPlan:
        RouteUtils.navigateRoute(RouteUtils.lessonPlan);
        break;
      case VariableUtils.announcement:
        RouteUtils.navigateRoute(RouteUtils.announcementList);
        break;
      case VariableUtils.addAttendance:
        RouteUtils.navigateRoute(RouteUtils.addAttendance);
        break;
      case VariableUtils.attendance:
        RouteUtils.navigateRoute(RouteUtils.attendanceList);
        break;
      case VariableUtils.classTimetable:
        RouteUtils.navigateRoute(RouteUtils.classTimeTable);
        break;
      case VariableUtils.leaveReq:
        RouteUtils.navigateRoute(RouteUtils.leaveRequestList);
        break;
      case VariableUtils.leaveApprove:
        RouteUtils.navigateRoute(RouteUtils.leaveApprovalList);
        break;
      case VariableUtils.complaint:
        RouteUtils.navigateRoute(RouteUtils.complaintList);
        break;
      case VariableUtils.claim:
        RouteUtils.navigateRoute(RouteUtils.claimList);
        break;
      case VariableUtils.sms:
        RouteUtils.navigateRoute(RouteUtils.smsList);
        break;
      case VariableUtils.voiceCall:
        RouteUtils.navigateRoute(RouteUtils.voiceList);
        break;
      case VariableUtils.events:
        RouteUtils.navigateRoute(RouteUtils.eventsList);
        break;
      case VariableUtils.onlineClass:
        RouteUtils.navigateRoute(RouteUtils.onlineClasses);
        break;
      case VariableUtils.examTime:
        RouteUtils.navigateRoute(RouteUtils.examTimetable);
        break;
      case VariableUtils.examScore:
        RouteUtils.navigateRoute(RouteUtils.examScore);
        break;
      case VariableUtils.addExamScore:
        RouteUtils.navigateRoute(RouteUtils.addExamScore);
        break;
      case VariableUtils.paySlip:
        RouteUtils.navigateRoute(RouteUtils.paySlip);
        break;
      case VariableUtils.fees:
        RouteUtils.navigateRoute(RouteUtils.fees);
        break;
      case VariableUtils.expenses:
        RouteUtils.navigateRoute(RouteUtils.expensesReport);
        break;
      case VariableUtils.certificate:
        RouteUtils.navigateRoute(RouteUtils.certificateList);
        break;
      case VariableUtils.addTeacherAttListing:
        RouteUtils.navigateRoute(RouteUtils.teacherAttendanceList);
        break;
      case VariableUtils.transport:
        RouteUtils.navigateRoute(RouteUtils.transportInfo);
        break;
      case VariableUtils.enquiry:
        RouteUtils.navigateRoute(RouteUtils.enquiryScreen);
        break;
      case VariableUtils.progressReport:
        RouteUtils.navigateRoute(RouteUtils.progressReportScreen);
        break;
      case VariableUtils.gallery:
        RouteUtils.navigateRoute(RouteUtils.galleryScreen);
        break;
      case VariableUtils.academicYearPlan:
        RouteUtils.navigateRoute(RouteUtils.academicYearPlan);
        break;
      case VariableUtils.applyPayment:
        RouteUtils.navigateRoute(RouteUtils.applyPaymentList);
        break;
      case VariableUtils.dailyReport:
        RouteUtils.navigateRoute(RouteUtils.dailyReport);
        break;
      case VariableUtils.reports:
        RouteUtils.navigateRoute(RouteUtils.reports);
        break;
      case VariableUtils.feedback:
        RouteUtils.navigateRoute(RouteUtils.feedbackList);
        break;
      // case VariableUtils.studentAttendance:
      //   RouteUtils.navigateRoute(
      //     RouteUtils.reportsAttendance,
      //     args: args,
      //   );
      // break;
    }
  }
}

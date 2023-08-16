import 'package:get/get.dart';
import 'package:msp_educare_demo/bindings/academic_pear_plan_binding.dart';
import 'package:msp_educare_demo/bindings/announcement_binding.dart';
import 'package:msp_educare_demo/bindings/attendance_binding.dart';
import 'package:msp_educare_demo/bindings/call_binding.dart';
import 'package:msp_educare_demo/bindings/certificate_binding.dart';
import 'package:msp_educare_demo/bindings/claim_binding.dart';
import 'package:msp_educare_demo/bindings/class_timetable_binding.dart';
import 'package:msp_educare_demo/bindings/complaint_binding.dart';
import 'package:msp_educare_demo/bindings/dashboard_binding.dart';
import 'package:msp_educare_demo/bindings/dropdown_option_binding.dart';
import 'package:msp_educare_demo/bindings/enquiry_binding.dart';
import 'package:msp_educare_demo/bindings/events_binding.dart';
import 'package:msp_educare_demo/bindings/exam_score_binding.dart';
import 'package:msp_educare_demo/bindings/exam_timetable_binding.dart';
import 'package:msp_educare_demo/bindings/expenses_binding.dart';
import 'package:msp_educare_demo/bindings/fees_binding.dart';
import 'package:msp_educare_demo/bindings/gallery_binding.dart';
import 'package:msp_educare_demo/bindings/home_binding.dart';
import 'package:msp_educare_demo/bindings/homework_binding.dart';
import 'package:msp_educare_demo/bindings/leave_binding.dart';
import 'package:msp_educare_demo/bindings/lesson_plan_binding.dart';
import 'package:msp_educare_demo/bindings/login_binding.dart';
import 'package:msp_educare_demo/bindings/new_admission_inquiry_binding.dart';
import 'package:msp_educare_demo/bindings/notification_binding.dart';
import 'package:msp_educare_demo/bindings/online_classes_binding.dart';
import 'package:msp_educare_demo/bindings/pay_slip_binding.dart';
import 'package:msp_educare_demo/bindings/payment_binding.dart';
import 'package:msp_educare_demo/bindings/pop_up_binding.dart';
import 'package:msp_educare_demo/bindings/progress_report_binding.dart';
import 'package:msp_educare_demo/bindings/sms_binding.dart';
import 'package:msp_educare_demo/bindings/stud_list_binding.dart';
import 'package:msp_educare_demo/bindings/teacher_attendance_binding.dart';
import 'package:msp_educare_demo/bindings/transport_info_binding.dart';
import 'package:msp_educare_demo/common/commonWidgets/webview_screen.dart';
import 'package:msp_educare_demo/view/academicYearPlan/academic_year_plan.dart';
import 'package:msp_educare_demo/view/addExamScore/add_exam_score.dart';
import 'package:msp_educare_demo/view/announcement/add_announcement.dart';
import 'package:msp_educare_demo/view/announcement/announcement_list.dart';
import 'package:msp_educare_demo/view/attendance/add_attendance.dart';
import 'package:msp_educare_demo/view/attendance/attendance_list.dart';
import 'package:msp_educare_demo/view/auth/login_here.dart';
import 'package:msp_educare_demo/view/auth/register.dart';
import 'package:msp_educare_demo/view/auth/reset_password.dart';
import 'package:msp_educare_demo/view/auth/send_otp.dart';
import 'package:msp_educare_demo/view/certificate/get_certificate_list.dart';
import 'package:msp_educare_demo/view/claim/add_claim.dart';
import 'package:msp_educare_demo/view/claim/claim_list.dart';
import 'package:msp_educare_demo/view/classTimetable/class_timetable.dart';
import 'package:msp_educare_demo/view/compaint/add_complaint.dart';
import 'package:msp_educare_demo/view/compaint/compaint_list.dart';
import 'package:msp_educare_demo/view/feedback/add_feedback.dart';
import 'package:msp_educare_demo/view/feedback/feedback_list.dart';
import 'package:msp_educare_demo/view/dashboard/chat_tab.dart';
import 'package:msp_educare_demo/view/dashboard/dashboard.dart';
import 'package:msp_educare_demo/view/dashboard/notification_tab.dart';
import 'package:msp_educare_demo/view/detail/staff_detail_screen.dart';
import 'package:msp_educare_demo/view/detail/student_detail_screen.dart';
import 'package:msp_educare_demo/view/driving/driving_screen.dart';
import 'package:msp_educare_demo/view/enquiry/add_enquiry_screen.dart';
import 'package:msp_educare_demo/view/enquiry/enquiry_list_screen.dart';
import 'package:msp_educare_demo/view/events/events_list.dart';
import 'package:msp_educare_demo/view/examScore/exam_score.dart';
import 'package:msp_educare_demo/view/examTimetable/exam_timetable.dart';
import 'package:msp_educare_demo/view/expenses/expenses_screen.dart';
import 'package:msp_educare_demo/view/fees/fees_payment_screen.dart';
import 'package:msp_educare_demo/view/fees/fees_screen.dart';
import 'package:msp_educare_demo/view/gallery/gallery_screen.dart';
import 'package:msp_educare_demo/view/homework/add_homework.dart';
import 'package:msp_educare_demo/view/homework/homework_list.dart';
import 'package:msp_educare_demo/view/homework/update_homework.dart';
import 'package:msp_educare_demo/view/leave/add_leave_request.dart';
import 'package:msp_educare_demo/view/leave/leave_approval_list.dart';
import 'package:msp_educare_demo/view/leave/leave_request_list.dart';
import 'package:msp_educare_demo/view/lesson_plan/add_lesson_plan.dart';
import 'package:msp_educare_demo/view/lesson_plan/edit_lesson_plan.dart';
import 'package:msp_educare_demo/view/lesson_plan/lesson_plan_screen.dart';
import 'package:msp_educare_demo/view/newAdmissionInquiry/new_admission_inquiry.dart';
import 'package:msp_educare_demo/view/onlineClasses/online_classes.dart';
import 'package:msp_educare_demo/view/paySlip/pay_slip.dart';
import 'package:msp_educare_demo/view/payment/apply_payment.dart';
import 'package:msp_educare_demo/view/payment/apply_payment_list.dart';
import 'package:msp_educare_demo/view/reports/add_expenses.dart';
import 'package:msp_educare_demo/view/reports/daily_report.dart';
import 'package:msp_educare_demo/view/reports/exam_score_report.dart';
import 'package:msp_educare_demo/view/reports/expenses.dart';
import 'package:msp_educare_demo/view/reports/financial_report.dart';
import 'package:msp_educare_demo/view/reports/home_work_report.dart';
import 'package:msp_educare_demo/view/reports/payroll_report.dart';
import 'package:msp_educare_demo/view/reports/progress_report_screen.dart';
import 'package:msp_educare_demo/view/reports/reports_screen.dart';
import 'package:msp_educare_demo/view/reports/staff_attendance_report.dart';
import 'package:msp_educare_demo/view/reports/stud_attendance_report.dart';
import 'package:msp_educare_demo/view/sms/add_sms_campaign.dart';
import 'package:msp_educare_demo/view/sms/sms_list.dart';
import 'package:msp_educare_demo/view/teacherAttendance/teacher_attendace_list.dart';
import 'package:msp_educare_demo/view/transportInfo/transport_info_screen.dart';
import 'package:msp_educare_demo/view/voiceCall/add_call_campaign.dart';
import 'package:msp_educare_demo/view/voiceCall/voice_call_list.dart';

import '../view/reports/edit_expenses_screen.dart';

class RouteUtils {
  ///ALL ROUTES NAME
  static const login = '/login';
  static const loginHere = '/loginHere';
  static const newAdmissionInquiry = '/newAdmissionInquiry';
  static const register = '/register';
  static const sendOtp = '/sendOtp';
  static const resetPassword = '/resetPassword';
  static const dashboard = '/dashboard';
  static const homeTab = '/homeTab';
  static const notificationTab = '/notificationTab';
  static const chatTab = '/chatTab';
  static const homeworkList = '/homeworkList';
  static const updateHomeWork = '/updateHomeWork';
  static const addHomework = '/addHomework';
  static const addExpenses = '/addExpenses';
  static const announcementList = '/announcementList';
  static const addAnnouncement = '/addAnnouncement';
  static const attendanceList = '/attendanceList';
  static const addAttendance = '/addAttendance';
  static const classTimeTable = '/classesTimeTable';
  static const leaveRequestList = '/leaveRequestList';
  static const addLeaveRequest = '/addLeaveRequest';
  static const leaveApprovalList = '/leaveApprovalList';
  static const complaintList = '/complaintList';
  static const addComplaint = '/addComplaint';
  static const claimList = '/claimList';
  static const addClaim = '/addClaim';
  static const eventsList = '/eventsList';
  static const onlineClasses = '/onlineClasses';
  static const examTimetable = '/examTimetable';
  static const examScore = '/examScore';
  static const addExamScore = '/addExamScore';
  static const paySlip = '/paySlip';
  static const fees = '/fees';
  static const smsList = '/smsList';
  static const voiceList = '/voiceList';
  static const addSmsCampaign = '/addSmsCampaign';
  static const addCallCampaign = '/addCallCampaign';
  static const addLessonPlan = '/addLessonPlan';
  static const editLessonPlan = '/editLessonPlan';

  static const feedbackList = '/feedbackList';
  static const addFeedback = '/addFeedback';

  // static const expenses = '/expensesList';
  static const feesPaymentScreen = '/feesPaymentScreen';
  static const teacherAttendanceList = '/teacherAttendanceList';
  static const certificateList = '/certificateList';
  static const transportInfo = '/transportInfo';
  static const webViewScreen = '/webViewScreen';
  static const enquiryScreen = '/enquiryScreen';

  static const addEnquiryScreen = '/addEnquiryScreen';
  static const progressReportScreen = '/progressReportScreen';
  static const galleryScreen = '/galleryScreen';
  static const academicYearPlan = '/academicYearPlan';
  static const lessonPlan = '/lessonPlan';
  static const drivingScreen = '/drivingScreen';
  static const studentDetailScreen = '/studentDetailScreen';
  static const staffDetailScreen = '/staffDetailScreen';
  static const applyPayment = '/applyPayment';
  static const applyPaymentList = '/applyPaymentList';
  static const dailyReport = '/dailyReport';
  static const reports = '/reports';
  static const staffAttendanceReport = '/staffAttendanceReport';
  static const studAttendanceReport = '/studAttendanceReport';
  static const homeWorkReport = '/homeWorkReport';
  static const examScoreReport = '/examScoreReport';
  static const financialReport = '/financialReport';
  static const payrollReport = '/payrollReport';
  static const expensesReport = '/expensesReport';
  static const editExpensesReport = '/editExpensesReport';

  /// ---------------  staffAttendance ------------------------------///

  /// ALL ROUTE SET WITH BINDING
  static List<GetPage> routePages = [
    // GetPage(name: login, page: () => Login(), bindings: [
    //   AuthBinding(),
    //   DashBoardBinding(),
    // ]),
    GetPage(name: register, page: () => Register(), bindings: [
      AuthBinding(),
      DashBoardBinding(),
    ]),
    GetPage(
        name: resetPassword,
        page: () => ResetPasswordScreen(),
        bindings: [AuthBinding()]),
    GetPage(
        name: sendOtp, page: () => SendOtpScreen(), bindings: [AuthBinding()]),
    GetPage(name: loginHere, page: () => LoginHere(), bindings: [
      AuthBinding(),
      DashBoardBinding(),
    ]),
    GetPage(
        name: newAdmissionInquiry,
        page: () => NewAdmissionInquiry(),
        bindings: [NewAdmissionEnquiryBinding()]),
    GetPage(name: dashboard, page: () => const DashBoard(), bindings: [
      DashBoardBinding(),
      AuthBinding(),
      HomeBinding(),
      StudentListBinding(),
      NotificationBinding(),
      DropdownOptionBinding(),
      EventsBinding(),
      EnquiryBinding(),
      ProgressReportBinding(),
      GalleryBinding(),
      PopUpBinding(),
    ]),
    GetPage(name: notificationTab, page: () => NotificationTab(), bindings: [
      DashBoardBinding(),
      NotificationBinding(),
    ]),
    GetPage(
        name: chatTab, page: () => ChatTab(), bindings: [DashBoardBinding()]),
    GetPage(
        name: homeworkList,
        page: () => HomeworkList(),
        bindings: [HomeworkBinding()]),
    GetPage(
        name: addHomework,
        page: () => AddHomework(),
        bindings: [HomeworkBinding()]),
    GetPage(
        name: addExpenses,
        page: () => AddExpensesScreen(),
        bindings: [DashBoardBinding(), DropdownOptionBinding()]),

    GetPage(
        name: updateHomeWork,
        page: () => UpdateHomeWork(),
        bindings: [HomeworkBinding()]),
    GetPage(
        name: announcementList,
        page: () => const AnnouncementList(),
        bindings: [AnnouncementBinding()]),
    GetPage(
        name: addAnnouncement,
        page: () => AddAnnouncement(),
        bindings: [AnnouncementBinding()]),
    GetPage(
        name: attendanceList,
        page: () => AttendanceList(),
        bindings: [AttendanceBinding()]),
    GetPage(
        name: addAttendance,
        page: () => AddAttendance(),
        bindings: [AttendanceBinding()]),
    GetPage(
        name: classTimeTable,
        page: () => ClassTimeTable(),
        bindings: [ClassTimeTableBinding()]),
    GetPage(
        name: addCallCampaign,
        page: () => const AddCallCampaign(),
        bindings: [CallBinding(), DropdownOptionBinding()]),
    GetPage(
        name: leaveRequestList,
        page: () => LeaveRequestList(),
        bindings: [LeaveBinding()]),
    GetPage(
        name: addLeaveRequest,
        page: () => AddLeaveRequest(),
        bindings: [LeaveBinding()]),
    GetPage(
        name: leaveApprovalList,
        page: () => LeaveApprovalList(),
        bindings: [LeaveBinding()]),
    GetPage(
        name: complaintList,
        page: () => ComplaintList(),
        bindings: [ComplaintBinding()]),
    GetPage(name: addComplaint, page: () => AddComplaint(), bindings: [
      ComplaintBinding(),
    ]),
    GetPage(
        name: claimList, page: () => ClaimList(), bindings: [ClaimBinding()]),
    GetPage(name: addClaim, page: () => AddClaim(), bindings: [ClaimBinding()]),
    GetPage(
        name: eventsList,
        page: () => const EventsList(),
        bindings: [EventsBinding()]),
    GetPage(
        name: onlineClasses,
        page: () => OnlineClasses(),
        bindings: [OnlineClassesBinding()]),
    GetPage(
        name: webViewScreen,
        page: () => const WebViewScreen(),
        bindings: [OnlineClassesBinding()]),
    GetPage(
        name: examTimetable,
        page: () => ExamTimetable(),
        bindings: [ExamTimetableBinding()]),
    GetPage(
        name: examScore,
        page: () => ExamScore(),
        bindings: [ExamScoreBinding()]),
    GetPage(
        name: addExamScore,
        page: () => AddExamScore(),
        bindings: [ExamScoreBinding()]),
    GetPage(name: paySlip, page: () => PaySlip(), bindings: [PaySlipBinding()]),
    GetPage(name: fees, page: () => FeesScreen(), bindings: [FeesBinding()]),
    GetPage(
        name: feesPaymentScreen,
        page: () => FeesPaymentScreen(),
        bindings: [FeesBinding()]),
    // GetPage(
    //     name: expenses,
    //     page: () => ExpensesList(),
    //     bindings: [ExpensesListBinding()]),
    GetPage(
        name: teacherAttendanceList,
        page: () => TeacherAttendanceList(),
        bindings: [TeacherAttendanceBinding()]),
    GetPage(
        name: certificateList,
        page: () => GetCertificateList(),
        bindings: [CertificateBinding()]),
    GetPage(
        name: transportInfo,
        page: () => TransportInfoScreen(),
        bindings: [TransportInfoBinding()]),
    GetPage(
        name: addEnquiryScreen,
        page: () => AddEnquiryScreen(),
        bindings: [EnquiryBinding()]),
    GetPage(
        name: enquiryScreen,
        page: () => EnquiryListScreen(),
        bindings: [EnquiryBinding()]),
    GetPage(
        name: progressReportScreen,
        page: () => ProgressReportScreen(),
        bindings: [ProgressReportBinding()]),
    GetPage(
        name: galleryScreen,
        page: () => GalleryScreen(),
        bindings: [GalleryBinding()]),
    GetPage(
        name: academicYearPlan,
        page: () => const AcademicYearPlan(),
        bindings: [AcademicYearPlanBinding()]),
    GetPage(
        name: lessonPlan,
        page: () => LessonPlanScreen(),
        bindings: [LessonPlanBinding()]),
    GetPage(name: drivingScreen, page: () => DrivingScreen(), bindings: [
      DashBoardBinding(),
    ]),
    GetPage(
        name: staffDetailScreen,
        page: () => StaffDetailScreen(),
        bindings: [
          DashBoardBinding(),
          AuthBinding(),
          HomeBinding(),
        ]),
    GetPage(
        name: studentDetailScreen,
        page: () => StudentDetailScreen(),
        bindings: [
          DashBoardBinding(),
          AuthBinding(),
          HomeBinding(),
        ]),
    GetPage(name: applyPayment, page: () => const ApplyPayment(), bindings: [
      DashBoardBinding(),
      AuthBinding(),
      HomeBinding(),
      PaymentBinding(),
    ]),
    GetPage(name: applyPaymentList, page: () => ApplyPaymentList(), bindings: [
      DashBoardBinding(),
      AuthBinding(),
      HomeBinding(),
      PaymentBinding(),
    ]),
    GetPage(name: dailyReport, page: () => DailyReport(), bindings: [
      DashBoardBinding(),
    ]),
    GetPage(name: reports, page: () => ReportsScreen(), bindings: [
      DashBoardBinding(),
    ]),
    GetPage(
        name: staffAttendanceReport,
        page: () => StaffAttendanceReports(),
        bindings: [DashBoardBinding(), HomeworkBinding()]),
    GetPage(
        name: studAttendanceReport,
        page: () => StudAttendanceReports(),
        bindings: [DashBoardBinding(), HomeworkBinding()]),
    GetPage(
        name: homeWorkReport,
        page: () => const HomeWorkReport(),
        bindings: [DashBoardBinding(), HomeworkBinding()]),
    GetPage(
        name: examScoreReport,
        page: () => ExamScoreReport(),
        bindings: [DashBoardBinding(), ExamScoreBinding()]),
    GetPage(name: financialReport, page: () => FinancialReport(), bindings: [
      DashBoardBinding(),
    ]),
    GetPage(name: payrollReport, page: () => PayrollReport(), bindings: [
      DashBoardBinding(),
    ]),
    GetPage(name: expensesReport, page: () => ExpensesScreen(), bindings: [
      DashBoardBinding(),
    ]),
    GetPage(
        name: editExpensesReport,
        page: () => const EditExpensesScreen(),
        bindings: [DashBoardBinding(), DropdownOptionBinding()]),

    GetPage(
        name: smsList,
        page: () => SmsCampaignList(),
        bindings: [DashBoardBinding(), SmsBinding()]),
    GetPage(
        name: voiceList,
        page: () => const VoiceCallList(),
        bindings: [DashBoardBinding(), CallBinding()]),
    GetPage(
        name: addSmsCampaign,
        page: () => const AddNewSmsCampaign(),
        bindings: [SmsBinding(), DropdownOptionBinding()]),
    GetPage(name: editLessonPlan, page: () => EditLessonPlan(), bindings: [
      DashBoardBinding(),
      DropdownOptionBinding(),
      LessonPlanBinding()
    ]),
    GetPage(
        name: feedbackList,
        page: () => FeedbackList(),
        bindings: [ComplaintBinding()]),

    GetPage(
        name: addLessonPlan,
        page: () => AddLessonPlane(),
        bindings: [LessonPlanBinding(), DropdownOptionBinding()]),
    GetPage(name: addFeedback, page: () => AddFeedback(), bindings: [
      ComplaintBinding(),
    ]),
  ];

  /// ------------------------------------------------------------------- ///
  ///NAVIGATE ROUTE
  static navigateRoute(
    String route, {
    dynamic args,
  }) {
    switch (route) {
      case login:
        Get.toNamed(
          login,
        );
        break;
      case register:
        Get.toNamed(
          register,
        );
        break;
      case sendOtp:
        Get.toNamed(
          sendOtp,
        );
        break;
      case editExpensesReport:
        Get.toNamed(editExpensesReport, arguments: args);
        break;
      case resetPassword:
        Get.toNamed(
          resetPassword,
        );
        break;

      case editLessonPlan:
        Get.toNamed(editLessonPlan, arguments: args);
        break;
      case addCallCampaign:
        Get.toNamed(
          addCallCampaign,
        );
        break;
      case loginHere:
        Get.offAllNamed(
          loginHere,
        );
        break;
      case newAdmissionInquiry:
        Get.toNamed(
          newAdmissionInquiry,
        );
        break;
      case addLessonPlan:
        Get.toNamed(addLessonPlan);

        break;
      case homeworkList:
        Get.toNamed(
          homeworkList,
        );
        break;
      case addHomework:
        Get.toNamed(
          addHomework,
        );
        break;
      case addExpenses:
        Get.toNamed(
          addExpenses,
        );
        break;
      case updateHomeWork:
        Get.toNamed(updateHomeWork, arguments: args);
        break;
      case announcementList:
        Get.toNamed(
          announcementList,
        );
        break;
      case addAnnouncement:
        Get.toNamed(
          addAnnouncement,
        );
        break;
      case attendanceList:
        Get.toNamed(
          attendanceList,
        );
        break;
      case addAttendance:
        Get.toNamed(
          addAttendance,
        );
        break;
      case staffDetailScreen:
        Get.toNamed(
          staffDetailScreen,
        );
        break;
      case studentDetailScreen:
        Get.toNamed(
          studentDetailScreen,
        );
        break;
      case classTimeTable:
        Get.toNamed(
          classTimeTable,
        );
        break;
      case leaveRequestList:
        Get.toNamed(
          leaveRequestList,
        );
        break;
      case addLeaveRequest:
        Get.toNamed(
          addLeaveRequest,
        );
        break;
      case leaveApprovalList:
        Get.toNamed(
          leaveApprovalList,
        );
        break;
      case complaintList:
        Get.toNamed(
          complaintList,
        );
        break;
      case addComplaint:
        Get.toNamed(
          addComplaint,
        );
        break;
      case claimList:
        Get.toNamed(
          claimList,
        );
        break;
      case dailyReport:
        Get.toNamed(
          dailyReport,
        );
        break;
      case reports:
        Get.toNamed(
          reports,
        );
        break;
      case homeWorkReport:
        Get.toNamed(
          homeWorkReport,
        );
        break;
      case examScoreReport:
        Get.toNamed(
          examScoreReport,
        );
        break;
      case financialReport:
        Get.toNamed(
          financialReport,
        );
        break;
      case payrollReport:
        Get.toNamed(
          payrollReport,
        );
        break;
      case expensesReport:
        Get.toNamed(
          expensesReport,
        );
        break;
      case staffAttendanceReport:
        Get.toNamed(
          staffAttendanceReport,
        );
        break;
      case studAttendanceReport:
        Get.toNamed(
          studAttendanceReport,
        );
        break;
      case addClaim:
        Get.toNamed(
          addClaim,
        );
        break;
      case eventsList:
        Get.toNamed(
          eventsList,
        );
        break;
      case onlineClasses:
        Get.toNamed(
          onlineClasses,
        );
        break;
      case webViewScreen:
        Get.toNamed(webViewScreen, arguments: args);
        break;
      case examTimetable:
        Get.toNamed(
          examTimetable,
        );
        break;
      case paySlip:
        Get.toNamed(
          paySlip,
        );
        break;
      case fees:
        Get.toNamed(
          fees,
        );
        break;
      case feesPaymentScreen:
        Get.toNamed(feesPaymentScreen, arguments: args);
        break;
      case teacherAttendanceList:
        Get.toNamed(
          teacherAttendanceList,
        );
        break;
      // case expenses:
      //   Get.toNamed(
      //     expenses,
      //   );
      //   break;
      case academicYearPlan:
        Get.toNamed(
          academicYearPlan,
        );
        break;
      case lessonPlan:
        Get.toNamed(
          lessonPlan,
        );
        break;
      case examScore:
        Get.toNamed(
          examScore,
        );
        break;
      case addExamScore:
        Get.toNamed(
          addExamScore,
        );
        break;
      case certificateList:
        Get.toNamed(
          certificateList,
        );
        break;
      case transportInfo:
        Get.toNamed(
          transportInfo,
        );
        break;
      case enquiryScreen:
        Get.toNamed(
          enquiryScreen,
        );
        break;
      case galleryScreen:
        Get.toNamed(
          galleryScreen,
        );
        break;
      case progressReportScreen:
        Get.toNamed(
          progressReportScreen,
        );
        break;
      case addEnquiryScreen:
        Get.toNamed(addEnquiryScreen, arguments: args);
        break;
      case drivingScreen:
        Get.toNamed(
          drivingScreen,
        );
        break;
      case applyPayment:
        Get.toNamed(
          applyPayment,
        );
        break;
      case applyPaymentList:
        Get.toNamed(
          applyPaymentList,
        );
        break;
      case dashboard:
        Get.offAndToNamed(
          dashboard,
        );
        break;
      case addSmsCampaign:
        Get.toNamed(
          addSmsCampaign,
        );
        break;
      case voiceList:
        Get.toNamed(
          voiceList,
        );
        break;
      case smsList:
        Get.toNamed(
          smsList,
        );
        break;
      case feedbackList:
        Get.toNamed(
          feedbackList,
        );
        break;
      case addFeedback:
        Get.toNamed(
          addFeedback,
        );
        break;
      default:
        print('Not Route Match');
        break;
    }
  }
}

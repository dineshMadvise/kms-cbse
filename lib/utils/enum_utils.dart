/// API CALLING METHOD
// ignore_for_file: constant_identifier_names

enum APIType { aPost, aGet, aDelete, aPut }

/// API HEADER TYPE
enum APIHeaderType {
  fileUploadWithToken,
  fileUploadWithoutToken,
  jsonBodyWithToken,
  onlyToken
}

enum ValidationType { Password, Email, PNumber }

enum BottomNavigationRoute { Home, Notification, Event, Logout }

// enum RoleType { Admin, Teacher, Parent }

enum DashBoardHomeRoute { HomeTab, StudentList }

enum ExamScoreType { Grade, Marks }

enum Editable{
  Yes,
  No
}

enum LessonPlanStatus{
  Pending,
  Processing,
  Completed
}


enum LoginType{
  Admin,
  Teacher,
  Parent
}

enum ReportType{
  staffAttendanceReport,
  studentAttendanceReport,
}

// enum UserStatus { Open, Close, Logout }

// enum GPSStatus { OFF, ON }

// enum LeaveStatus { Rejected, Approved, Pending }


enum Availability { loading, available, unavailable }
/// DATA : [{"sno":1,"month":"March 2022","total_basic_pay":"12000.00","total_leave":"16","tot_get_salary_amount":"5806.45","payslip_print":"https://mspeducare.com/demoschool/payroll/printaction?pi_id=176"},{"sno":2,"month":"February 2022","total_basic_pay":"12000.00","total_leave":"0","tot_get_salary_amount":"12000.00","payslip_print":"https://mspeducare.com/demoschool/payroll/printaction?pi_id=161"},{"sno":3,"month":"August 2021","total_basic_pay":"10000.00","total_leave":"12","tot_get_salary_amount":"6129.03","payslip_print":"https://mspeducare.com/demoschool/payroll/printaction?pi_id=146"},{"sno":4,"month":"November 2021","total_basic_pay":"10000.00","total_leave":"26","tot_get_salary_amount":"10000.00","payslip_print":"https://mspeducare.com/demoschool/payroll/printaction?pi_id=131"},{"sno":5,"month":"December 2021","total_basic_pay":"12000.00","total_leave":"2","tot_get_salary_amount":"12000.00","payslip_print":"https://mspeducare.com/demoschool/payroll/printaction?pi_id=116"},{"sno":6,"month":"October 2021","total_basic_pay":"12000.00","total_leave":"2","tot_get_salary_amount":"12000.00","payslip_print":"https://mspeducare.com/demoschool/payroll/printaction?pi_id=101"},{"sno":7,"month":"September 2021","total_basic_pay":"10000.00","total_leave":"4","tot_get_salary_amount":"8666.67","payslip_print":"https://mspeducare.com/demoschool/payroll/printaction?pi_id=84"},{"sno":8,"month":"April 2021","total_basic_pay":"10000.00","total_leave":"2","tot_get_salary_amount":"10333.33","payslip_print":"https://mspeducare.com/demoschool/payroll/printaction?pi_id=48"},{"sno":9,"month":"March 2021","total_basic_pay":"10000.00","total_leave":"2","tot_get_salary_amount":"10000.00","payslip_print":"https://mspeducare.com/demoschool/payroll/printaction?pi_id=41"},{"sno":10,"month":"February 2021","total_basic_pay":"10000.00","total_leave":"2","tot_get_salary_amount":"10000.00","payslip_print":"https://mspeducare.com/demoschool/payroll/printaction?pi_id=34"},{"sno":11,"month":"January 2021","total_basic_pay":"10000.00","total_leave":"20","tot_get_salary_amount":"11516.13","payslip_print":"https://mspeducare.com/demoschool/payroll/printaction?pi_id=27"},{"sno":12,"month":"July 2021","total_basic_pay":"10000.00","total_leave":"7","tot_get_salary_amount":"9977.42","payslip_print":"https://mspeducare.com/demoschool/payroll/printaction?pi_id=21"},{"sno":13,"month":"May 2021","total_basic_pay":"10000.00","total_leave":"1","tot_get_salary_amount":"9677.42","payslip_print":"https://mspeducare.com/demoschool/payroll/printaction?pi_id=19"},{"sno":14,"month":"June 2021","total_basic_pay":"10000.00","total_leave":"2","tot_get_salary_amount":"10300.00","payslip_print":"https://mspeducare.com/demoschool/payroll/printaction?pi_id=18"}]
/// status : "OK"

class GetPayslipListResModel {
  GetPayslipListResModel({this.data, this.status, this.msg});

  GetPayslipListResModel.fromJson(dynamic json) {
    if (json['DATA'] != null) {
      if (json['DATA'] is List<dynamic>) {
        if ((json['DATA'] as List<dynamic>).isEmpty) {
          msg = 'No record found';
        } else {
          json['DATA'].forEach((v) {
            data?.add(Data.fromJson(v));
          });
        }
      } else {
        msg = json['DATA'];
      }
    }
    status = json['status'];
  }

  List<Data>? data = [];
  String? status;
  String? msg;
}

/// sno : 1
/// month : "March 2022"
/// total_basic_pay : "12000.00"
/// total_leave : "16"
/// tot_get_salary_amount : "5806.45"
/// payslip_print : "https://mspeducare.com/demoschool/payroll/printaction?pi_id=176"

class Data {
  Data({
    int? sno,
    String? month,
    String? totalBasicPay,
    String? totalLeave,
    String? totGetSalaryAmount,
    String? payslipPrint,
  }) {
    _sno = sno;
    _month = month;
    _totalBasicPay = totalBasicPay;
    _totalLeave = totalLeave;
    _totGetSalaryAmount = totGetSalaryAmount;
    _payslipPrint = payslipPrint;
  }

  Data.fromJson(dynamic json) {
    _sno = json['sno'];
    _month = json['month'];
    _totalBasicPay = json['total_basic_pay'];
    _totalLeave = json['total_leave'];
    _totGetSalaryAmount = json['tot_get_salary_amount'];
    _payslipPrint = json['payslip_print'];
  }

  int? _sno;
  String? _month;
  String? _totalBasicPay;
  String? _totalLeave;
  String? _totGetSalaryAmount;
  String? _payslipPrint;

  int? get sno => _sno;

  String? get month => _month;

  String? get totalBasicPay => _totalBasicPay;

  String? get totalLeave => _totalLeave;

  String? get totGetSalaryAmount => _totGetSalaryAmount;

  String? get payslipPrint => _payslipPrint;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sno'] = _sno;
    map['month'] = _month;
    map['total_basic_pay'] = _totalBasicPay;
    map['total_leave'] = _totalLeave;
    map['tot_get_salary_amount'] = _totGetSalaryAmount;
    map['payslip_print'] = _payslipPrint;
    return map;
  }
}

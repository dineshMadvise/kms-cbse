// ignore_for_file: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonWidgets/date_box.dart';
import 'package:msp_educare_demo/dialog/expenses_view_dailog.dart';
import 'package:msp_educare_demo/dialog/fees_pay_dialog.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/expenses_report_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/dateformat_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/viewModel/report_viewmodel.dart';
import 'package:msp_educare_demo/utils/route_utils.dart';
import '../../common/commonWidgets/add_or_forword_circle_box.dart';
import '../../utils/variable_utils.dart';

class ExpensesScreen extends StatelessWidget {
  ExpensesScreen({Key? key}) : super(key: key);

  final ReportViewModel reportViewModel =
      Get.find<ReportViewModel>(tag: ReportViewModel().toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
          title: VariableUtils.expenses,
          centerTitle: true,
          actionVisible: true,
          onActionTap: () {
            RouteUtils.navigateRoute(RouteUtils.addExpenses);
          }),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      decoration: DecorationUtils.commonDecorationBox(),
      padding:const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: GetBuilder<ReportViewModel>(
        tag: ReportViewModel().toString(),
        initState: (state) {
          // WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) {
          reportViewModel.getExpensesReport();
          // });
        },
        builder: (controller) {
          if (controller.expensesReportApiResponse.status == Status.LOADING ||
              controller.expensesReportApiResponse.status == Status.INITIAL) {
            return getDataLoadingIndicator();
          }
          if (controller.expensesReportApiResponse.status == Status.ERROR) {
            return getDataErrorMsg();
          }
          GetExpensesReportResModel model =
              controller.expensesReportApiResponse.data!;
          if (model.status != VariableUtils.ok) {
            return getFieldIsEmptyMsg();
          }
          // Add your UI components here based on the model data
          return ListView.separated(
            itemCount: model.data!.length,
            itemBuilder: (context, index) {
              final data = model.data![index];
              return InkWell(
                onTap: () {
                  // showExpensesDialog(data);
                  // showExpensesDialog(data);
                  showExpensesDialog(data);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DateBox(
                            text: data.expenseType ?? VariableUtils.none,
                            textStyle: FontTextStyle.poppinsW6S13Grey,
                          ),
                          SizeConfig.sH10,
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: richText(
                                      key: VariableUtils.Payee,
                                      value: data.payeeName ??
                                          VariableUtils.none)),
                              Expanded(
                                flex: 1,
                                child: richText(
                                  key: VariableUtils.Amounts,
                                  value: data.amount ?? VariableUtils.none,
                                ),
                              )
                            ],
                          ),
                          SizeConfig.sH10,
                          richText(
                            key: VariableUtils.paymentDate,
                            value: data.paymentDate == "" ||
                                    data.paymentDate == null
                                ? VariableUtils.none
                                : DateFormatUtils.ddMMMYYYYFormat(
                                    DateTime.parse(data.paymentDate!)),
                          ),
                          SizeConfig.sH10,
                          richText(
                            key: VariableUtils.status,
                            value: data.paymentStatus ?? VariableUtils.none,
                          ),
                          SizeConfig.sH10,
                          richText(
                            key: VariableUtils.description,
                            value: data.description ?? VariableUtils.none,
                          ),
                        ],
                      ),
                    ),
                    SizeConfig.sW10,
                    InkWell(
                      onTap: () {
                        // showExpensesDialog(data);
                        showExpensesDialog(data);
                      },
                      child: const AddOrForwordCircleBox(
                        icon: ConstUtils.kForwordArrowIcon,
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Divider(),
              );
            },
          );
        },
      ),
    );
  }
}

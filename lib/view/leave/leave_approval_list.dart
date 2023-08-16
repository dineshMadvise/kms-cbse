// ignore_for_file: use_key_in_widget_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/common/commonWidgets/add_or_forword_circle_box.dart';
import 'package:msp_educare_demo/common/commonWidgets/date_box.dart';
import 'package:msp_educare_demo/dialog/leave_aproval_dialog.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_leave_approval_list_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/leave_viewmodel.dart';
import '../../common/commonMethods/loading_indicator.dart';

class LeaveApprovalList extends StatefulWidget {
  @override
  State<LeaveApprovalList> createState() => _LeaveApprovalListState();
}

class _LeaveApprovalListState extends State<LeaveApprovalList> {
  LeaveViewModel viewModel = Get.find(tag: LeaveViewModel().toString());

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    viewModel.getLeaveApprovalList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: VariableUtils.leaveApproval,
      ),
      body: buildBody(),
    );
  }

  Container buildBody() {
    return Container(
        height: Get.height,
        width: Get.width,
        margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        decoration: DecorationUtils.commonDecorationBox(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: GetBuilder<LeaveViewModel>(
          tag: LeaveViewModel().toString(),
          builder: (controller) {
            if (controller.getLeaveApprovalListApiResponse.status ==
                    Status.LOADING ||
                controller.getLeaveApprovalListApiResponse.status ==
                    Status.INITIAL) {
              return getDataLoadingIndicator();
            }
            if (controller.getLeaveApprovalListApiResponse.status ==
                Status.ERROR) {
              return getDataErrorMsg();
            }
            GetLeaveApprovalListResModel model =
                controller.getLeaveApprovalListApiResponse.data;
            if (model.status != VariableUtils.ok) {
              return getFieldIsEmptyMsg();
            }
            print('LENGTH:${model.data!.length}');
            return model.data!.isEmpty
                ? getNotApplicableMsg(msg: model.msg)
                : ListView.separated(
                    itemCount: model.data!.length,
                    itemBuilder: (context, index) {
                      final data = model.data![index];
                      return InkWell(
                        onTap: () {
                          showLeaveApprovalDialog(data);
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
                                    text: data.leaveDate ?? VariableUtils.none,
                                    textStyle: FontTextStyle.poppinsW6S13Grey,
                                  ),
                                  SizeConfig.sH10,
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Text(
                                            data.leaveName ??
                                                VariableUtils.none,
                                            style: FontTextStyle
                                                .poppinsW7S12DarkGrey,
                                          )),
                                      Expanded(
                                        flex: 1,
                                        child: richText(
                                            key: VariableUtils.status,
                                            value: data.status ??
                                                VariableUtils.none),
                                      )
                                    ],
                                  ),
                                  SizeConfig.sH10,
                                  richText(
                                      key: VariableUtils.reqOn,
                                      value:
                                          data.createdOn ?? VariableUtils.none),
                                  SizeConfig.sH10,
                                  richText(
                                      key: VariableUtils.name,
                                      value: data.name ?? VariableUtils.none),
                                ],
                              ),
                            ),
                            SizeConfig.sW10,
                            InkWell(
                              onTap: () {
                                showLeaveApprovalDialog(data);
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
        ));
  }

  Text richText({required String key, required String value}) {
    return Text.rich(TextSpan(children: [
      TextSpan(text: key, style: FontTextStyle.poppinsW5S12Grey),
      TextSpan(
        text: value,
        style: FontTextStyle.poppinsW7S12DarkGrey,
      )
    ]));
  }
}

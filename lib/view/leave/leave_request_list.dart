// ignore_for_file: use_key_in_widget_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonWidgets/add_or_forword_circle_box.dart';
import 'package:msp_educare_demo/common/commonWidgets/date_box.dart';
import 'package:msp_educare_demo/dialog/leave_request_dialog.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_leave_req_list_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/route_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/leave_viewmodel.dart';
import '../../common/commonWidgets/small_user_profile_box.dart';

class LeaveRequestList extends StatefulWidget {
  @override
  State<LeaveRequestList> createState() => _LeaveRequestListState();
}

class _LeaveRequestListState extends State<LeaveRequestList> {
  LeaveViewModel viewModel = Get.find(tag: LeaveViewModel().toString());
  late UserData userData;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    userData = ConstUtils.getUserData();
    viewModel.getLeaveReqList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
          title: VariableUtils.leaveReq,
          actionVisible: true,
          onActionTap: () {
            RouteUtils.navigateRoute(RouteUtils.addLeaveRequest);
          }),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        if (userData.usertype == ConstUtils.kGetRoleIndex(VariableUtils.parent))
          SmallUserProfileBox(),
        Expanded(
          child: Container(
              height: Get.height,
              width: Get.width,
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              decoration: DecorationUtils.commonDecorationBox(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: GetBuilder<LeaveViewModel>(
                tag: LeaveViewModel().toString(),
                builder: (controller) {
                  if (controller.getLeaveReqListApiResponse.status ==
                          Status.LOADING ||
                      controller.getLeaveReqListApiResponse.status ==
                          Status.INITIAL) {
                    return getDataLoadingIndicator();
                  }
                  if (controller.getLeaveReqListApiResponse.status ==
                      Status.ERROR) {
                    return getDataErrorMsg();
                  }
                  GetLeaveReqListResModel model =
                      controller.getLeaveReqListApiResponse.data;
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
                                showLeaveRequestDialog(data);
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        DateBox(
                                          text: data.leaveDate ??
                                              VariableUtils.none,
                                          textStyle:
                                              FontTextStyle.poppinsW6S13Grey,
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
                                            // if (data.status !=
                                            //     VariableUtils.pending)
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
                                            value: data.requestOn ??
                                                VariableUtils.none),
                                        SizeConfig.sH10,
                                        richText(
                                            key: VariableUtils.approvedBy,
                                            value: data.approvedby ??
                                                VariableUtils.none),
                                      ],
                                    ),
                                  ),
                                  SizeConfig.sW10,
                                  InkWell(
                                    onTap: () {
                                      showLeaveRequestDialog(data);
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
              )),
        ),
      ],
    );
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

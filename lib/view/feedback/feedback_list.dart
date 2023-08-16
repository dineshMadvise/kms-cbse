import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonWidgets/add_or_forword_circle_box.dart';
import 'package:msp_educare_demo/common/commonWidgets/date_box.dart';
import 'package:msp_educare_demo/common/commonWidgets/small_user_profile_box.dart';
import 'package:msp_educare_demo/dialog/complaint_list_dialog.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_compaint_list_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/route_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/complaint_viewmodel.dart';
import 'package:msp_educare_demo/viewModel/dropdown_options_viewmodel.dart';

class FeedbackList extends StatefulWidget {
  @override
  State<FeedbackList> createState() => _FeedbackListState();
}

class _FeedbackListState extends State<FeedbackList> {
  final ComplaintViewModel _viewModel =
      Get.find(tag: ComplaintViewModel().toString());
  late UserData userData;
  final DropdownOptionViewModel _optionViewModel =
      Get.find(tag: DropdownOptionViewModel().toString());

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    userData = ConstUtils.getUserData();
    _viewModel.getComplaintList(isFeedback: true);
    _optionViewModel.getDepartmentOption();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
          title: VariableUtils.feedback,
          centerTitle: true,
          actionVisible: true,
          onActionTap: () {
            RouteUtils.navigateRoute(RouteUtils.addFeedback);
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
              child: GetBuilder<ComplaintViewModel>(
                tag: ComplaintViewModel().toString(),
                builder: (controller) {
                  if (controller.getComplaintListApiResponse.status ==
                          Status.LOADING ||
                      controller.getComplaintListApiResponse.status ==
                          Status.INITIAL) {
                    return getDataLoadingIndicator();
                  }
                  if (controller.getComplaintListApiResponse.status ==
                      Status.ERROR) {
                    return getDataErrorMsg();
                  }
                  GetComplaintListResModel model =
                      controller.getComplaintListApiResponse.data;
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
                                showComplaintListDialog(data, isFeedback: true);
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
                                          text: data.complaintDate ??
                                              VariableUtils.none,
                                          textStyle:
                                              FontTextStyle.poppinsW6S13Grey,
                                        ),
                                        SizeConfig.sH10,
                                        richText(
                                            key: VariableUtils.department +
                                                ' : ',
                                            value: data.departmentName ??
                                                VariableUtils.none),
                                        SizeConfig.sH10,
                                        richText(
                                            key: VariableUtils.suggestion,
                                            value: data.suggestion ??
                                                VariableUtils.none),
                                        SizeConfig.sH10,
                                        richText(
                                            key: VariableUtils.feedback + ' : ',
                                            value: data.feedback ??
                                                VariableUtils.none),
                                        if (data.name != null)
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: richText(
                                                key: VariableUtils.name + ' : ',
                                                value: data.name ??
                                                    VariableUtils.none),
                                          ),
                                        if (data.mobileNumber != null)
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: richText(
                                                key: VariableUtils.mobileNo +
                                                    ' : ',
                                                value: data.mobileNumber ??
                                                    VariableUtils.none),
                                          ),
                                        if (data.userType != null)
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: richText(
                                                key: VariableUtils.type + ' : ',
                                                value: data.userType ??
                                                    VariableUtils.none),
                                          ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      showComplaintListDialog(data,
                                          isFeedback: true);
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

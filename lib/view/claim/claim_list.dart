// ignore_for_file: use_key_in_widget_constructors, prefer_final_fields, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonWidgets/add_or_forword_circle_box.dart';
import 'package:msp_educare_demo/common/commonWidgets/date_box.dart';
import 'package:msp_educare_demo/dialog/claim_list_dialog.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_claim_list_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/route_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/claim_viewmodel.dart';

class ClaimList extends StatefulWidget {
  @override
  State<ClaimList> createState() => _ClaimListState();
}

class _ClaimListState extends State<ClaimList> {
  ClaimViewModel _viewModel = Get.find(tag: ClaimViewModel().toString());
  late UserData userData;
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    userData = ConstUtils.getUserData();
    _viewModel.getComplaintList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
          title: VariableUtils.claim,
          centerTitle: userData.usertype ==
                  ConstUtils.kGetRoleIndex(VariableUtils.teacher)
              ? false
              : true,
          actionVisible: userData.usertype ==
                  ConstUtils.kGetRoleIndex(VariableUtils.teacher)
              ? true
              : false,
          onActionTap: () {
            RouteUtils.navigateRoute(RouteUtils.addClaim);
          }),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Container(
        height: Get.height,
        width: Get.width,
        margin:const EdgeInsets.fromLTRB(20, 10, 20, 20),
        decoration: DecorationUtils.commonDecorationBox(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: GetBuilder<ClaimViewModel>(
          tag: ClaimViewModel().toString(),
          builder: (controller) {
            if (controller.getClaimListApiResponse.status == Status.LOADING ||
                controller.getClaimListApiResponse.status == Status.INITIAL) {
              return getDataLoadingIndicator();
            }
            if (controller.getClaimListApiResponse.status == Status.ERROR) {
              return getDataErrorMsg();
            }
            GetClaimListResModel model =
                controller.getClaimListApiResponse.data;
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
                          showClaimDialog(data);
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
                                    text: data.updatedOn ?? VariableUtils.none,
                                    textStyle: FontTextStyle.poppinsW6S13Grey,
                                  ),
                                  SizeConfig.sH10,
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (data.refno != null &&
                                          data.refno != "")
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                              data.refno ?? VariableUtils.none,
                                              style: FontTextStyle
                                                  .poppinsW7S12DarkGrey,
                                            )),
                                      Expanded(
                                        flex: 1,
                                        child: richText(
                                            key: VariableUtils.status,
                                            value: data.paymentStatus ??
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
                                  Text(
                                    data.payeeName ?? VariableUtils.none,
                                    style: FontTextStyle.poppinsW7S12DarkGrey,
                                  )
                                  // richText(key: VariableUtils.approvedByOn, value: 'admin'),
                                ],
                              ),
                            ),
                            SizeConfig.sW10,
                            InkWell(
                              onTap: () {
                                showClaimDialog(data);
                              },
                              child:const AddOrForwordCircleBox(
                                icon: ConstUtils.kForwordArrowIcon,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return  const Padding(
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

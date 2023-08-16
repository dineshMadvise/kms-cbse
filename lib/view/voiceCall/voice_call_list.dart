import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonWidgets/date_box.dart';
import 'package:msp_educare_demo/common/commonWidgets/small_user_profile_box.dart';
import 'package:msp_educare_demo/dialog/fees_pay_dialog.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_cal_list_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/route_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/call_view_model.dart';

class VoiceCallList extends StatefulWidget {
  const VoiceCallList({Key? key}) : super(key: key);

  @override
  State<VoiceCallList> createState() => _VoiceCallListState();
}

class _VoiceCallListState extends State<VoiceCallList> {
final CallViewModel _viewModel= Get.find(tag: CallViewModel().toString());
late UserData userData;

@override
  void initState() {
init();
    super.initState();
  }

  void init(){
    userData = ConstUtils.getUserData();

    _viewModel.getCallList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
          title: VariableUtils.voiceCampaginList,
          centerTitle:true,
          actionVisible:true,
          onActionTap: () {
            RouteUtils.navigateRoute(RouteUtils.addCallCampaign);
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
              child: GetBuilder<CallViewModel>(
                tag: CallViewModel().toString(),
                builder: (controller) {
                  if (controller.getCallListApiResponse.status ==
                      Status.LOADING ||
                      controller.getCallListApiResponse.status ==
                          Status.INITIAL) {
                    return getDataLoadingIndicator();
                  }
                  if (controller.getCallListApiResponse.status == Status.ERROR) {
                    return getDataErrorMsg();
                  }
                  GetCalListResModel model =
                      controller.getCallListApiResponse.data;
                  if (model.status != VariableUtils.ok) {
                    return getFieldIsEmptyMsg();
                  }
                  print('LENGTH:${model.data!.length}');
                  return model.data!.isEmpty
                      ? getNotApplicableMsg(msg: model.data.toString())
                      : ListView.separated(
                    itemCount: model.data!.length,
                    itemBuilder: (context, index) {
                      final data = model.data![index];
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                DateBox(
                                  text: data.createdOn ??
                                      VariableUtils.none,
                                  textStyle:
                                  FontTextStyle.poppinsW6S13Grey,
                                ),
                                SizeConfig.sH10,
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(top: 10),
                                    child: richText(
                                        key: VariableUtils.CampaignName + ' : ',
                                        value: data.campaignName ??
                                            VariableUtils.none),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(top: 10),
                                        child: richText(
                                            key: VariableUtils.totalSend +
                                                ' : ',
                                            value: data.totalSent ??
                                                VariableUtils.none),
                                      ),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(top: 10),
                                        child: richText(
                                            key: VariableUtils.totalFailed +
                                                ' : ',
                                            value: data.totalFailed ??
                                                VariableUtils.none),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     showComplaintListDialog(data);
                          //   },
                          //   child: AddOrForwordCircleBox(
                          //     icon: ConstUtils.kForwordArrowIcon,
                          //   ),
                          // ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Padding(
                        padding:  EdgeInsets.symmetric(vertical: 5),
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
}

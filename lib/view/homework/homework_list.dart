import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonWidgets/add_or_forword_circle_box.dart';
import 'package:msp_educare_demo/common/commonWidgets/date_box.dart';
import 'package:msp_educare_demo/common/commonWidgets/octo_image_network.dart';
import 'package:msp_educare_demo/dialog/homework_dialog.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_homework_list_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/route_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/homework_viewmodel.dart';

import '../../common/commonWidgets/small_user_profile_box.dart';

class HomeworkList extends StatefulWidget {
  @override
  State<HomeworkList> createState() => _HomeworkListState();
}

class _HomeworkListState extends State<HomeworkList> {
  HomeWorkViewModel viewModel = Get.find(tag: HomeWorkViewModel().toString());
  late UserData userData;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    viewModel.clearExpansionPanelList();
    viewModel.getHomeworkList();
    userData = ConstUtils.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
          title: VariableUtils.homeWork,
          centerTitle: userData.usertype ==
                  ConstUtils.kGetRoleIndex(VariableUtils.parent)
              ? true
              : false,
          actionVisible: userData.usertype ==
                  ConstUtils.kGetRoleIndex(VariableUtils.parent)
              ? false
              : true,
          onActionTap: () {
            RouteUtils.navigateRoute(RouteUtils.addHomework);
          }),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        if (userData.usertype == ConstUtils.kGetRoleIndex(VariableUtils.parent))
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: SmallUserProfileBox(),
          ),
        Expanded(
          child: GetBuilder<HomeWorkViewModel>(
            tag: HomeWorkViewModel().toString(),
            builder: (controller) {
              if (controller.getHomeworkListApiResponse.status ==
                      Status.LOADING ||
                  controller.getHomeworkListApiResponse.status ==
                      Status.INITIAL) {
                return getDataLoadingIndicator();
              }
              if (controller.getHomeworkListApiResponse.status ==
                  Status.ERROR) {
                return getDataErrorMsg();
              }
              GetHomeworkListResModel model =
                  controller.getHomeworkListApiResponse.data;
              if (model.status != VariableUtils.ok) {
                return getFieldIsEmptyMsg();
              }
              print('LENGTH:${model.dATA!.length}');
              return model.dATA!.isEmpty
                  ? getNotApplicableMsg(msg: model.msg)
                  : ListView.builder(
                      itemCount: model.dATA!.length,
                      itemBuilder: (context, index) {
                        final data = model.dATA![index];

                        return Container(
                          decoration: DecorationUtils.commonDecorationBox(),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  srNoBox(
                                    text: userData.usertype ==
                                            ConstUtils.kGetRoleIndex(
                                                VariableUtils.parent)
                                        ? "${data.hDate!.substring(0, 2)}"
                                        : data.submissionList!.isEmpty
                                            ? "0"
                                            : "1",
                                  ),
                                  SizeConfig.sW10,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    data.title ??
                                                        VariableUtils.none,
                                                    style: FontTextStyle
                                                        .poppinsW6S18Black,
                                                  ),
                                                  SizeConfig.sH7,
                                                  Text(
                                                    '${data.className ?? VariableUtils.none}\t\t${data.subjectName ?? VariableUtils.none}\t\t${data.teacherName ?? VariableUtils.none}',
                                                    style: FontTextStyle
                                                        .poppinsW5S12Grey,
                                                  ),
                                                  // SizeConfig.sH5,
                                                  // Text(
                                                  //   data.teacherName ?? VariableUtils.none,
                                                  //   style: FontTextStyle
                                                  //       .poppinsW5S12Grey,
                                                  // )
                                                ],
                                              ),
                                            ),
                                            trailingCircleBox(
                                                index: index,
                                                data: data,
                                                homeWorkViewModel: controller,
                                                addIcon:
                                                    data.submissionList == null
                                                        ? false
                                                        : data.submissionList!
                                                                .isEmpty
                                                            ? false
                                                            : true),
                                          ],
                                        ),
                                        SizeConfig.sH10,
                                        DateBox(
                                          text:
                                              "${data.hDate ?? VariableUtils.none} - ${data.completeDate ?? VariableUtils.none}",
                                        ),
                                        SizeConfig.sH5,
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              if (controller.expansionPanelList.contains(index))
                                expansionPanelBox(data),
                            ],
                          ),
                        );
                      },
                    );
            },
          ),
        ),
      ],
    );
  }

  GestureDetector trailingCircleBox(
      {bool addIcon = false,
      int? index,
      required HomeWorkData data,
      HomeWorkViewModel? homeWorkViewModel,
      SubmissionList? submissionData}) {
    return GestureDetector(
        onTap: () {
          if (!addIcon) {
            showHomeworkDialog(data, index!, submissionData: submissionData);
          } else {
            viewModel.setExpansionPanelList(index!);
          }
        },
        child: AddOrForwordCircleBox(
            icon: addIcon
                ? homeWorkViewModel!.expansionPanelList.contains(index)
                    ? ConstUtils.kMinusIcon
                    : ConstUtils.kAddIcon
                : ConstUtils.kForwordArrowIcon));
  }

  Widget expansionPanelBox(HomeWorkData data) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: data.submissionList!
          .map((e) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Divider(),
                  ),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      srNoBox(
                          color: ColorUtils.lightGreen,
                          isText: false,
                          text: e.studentPic),
                      SizeConfig.sW10,
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            e.studentName ?? VariableUtils.none,
                            style: FontTextStyle.poppinsW6S18Black,
                          ),
                          SizeConfig.sH5,
                          Text(
                            '${e.className ?? VariableUtils.none}',
                            style: FontTextStyle.poppinsW5S12Grey,
                          ),
                          SizeConfig.sH5,
                          DateBox(
                            textStyle: FontTextStyle.poppinsW6S13Grey,
                            text: e.createdOn ?? VariableUtils.none,
                          ),
                        ],
                      ),
                      Spacer(),
                      trailingCircleBox(
                          data: data,
                          index: data.submissionList!.indexOf(e),
                          submissionData: e)
                    ],
                  )
                ],
              ))
          .toList(),
    );
  }

  Container srNoBox({Color? color, String? text, bool isText = true}) {
    return Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(
          color: color ?? ColorUtils.lightRed,
          borderRadius: BorderRadius.circular(5)),
      child: Center(
        child: isText
            ? Text(
                text ?? '',
                style: FontTextStyle.poppinsW5S20White,
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipOval(
                  child: OctoImageNetwork(
                    url: text,
                    radius: 25,
                    width: 50,
                    height: 50,
                  ),
                ),
              ),
      ),
    );
  }
}

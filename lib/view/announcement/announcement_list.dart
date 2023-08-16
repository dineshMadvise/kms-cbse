// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/common/commonWidgets/add_or_forword_circle_box.dart';
import 'package:msp_educare_demo/common/commonWidgets/date_box.dart';
import 'package:msp_educare_demo/logic/announcement_logic.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_announce_list_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/route_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/announcement_viewmodel.dart';
import '../../common/commonMethods/loading_indicator.dart';
import '../../dialog/announcement_dialog.dart';

class AnnouncementList extends StatefulWidget {
  const AnnouncementList({Key? key}) : super(key: key);

  @override
  State<AnnouncementList> createState() => _AnnouncementListState();
}

class _AnnouncementListState extends State<AnnouncementList> {
  AnnouncementViewModel viewModel =
      Get.find(tag: AnnouncementViewModel().toString());
  late UserData userData;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    viewModel.getAnnouncementList();
    userData = ConstUtils.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    print('LOGIN :${userData.usertype}');
    print(
        'STATUS :${userData.usertype != ConstUtils.kGetRoleIndex(VariableUtils.teacher)}');
    return Scaffold(
      appBar: customAppbar(
          title: VariableUtils.announcement,
          // centerTitle: userData.usertype != RoleType.Teacher.index.toString()
          //     ? true
          //     : false,
          actionVisible: userData.usertype !=
              ConstUtils.kGetRoleIndex(VariableUtils.parent),
          onActionTap: () {
            RouteUtils.navigateRoute(RouteUtils.addAnnouncement);
          }),
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
        child: GetBuilder<AnnouncementViewModel>(
          tag: AnnouncementViewModel().toString(),
          builder: (controller) {
            if (controller.getAnnouncementListApiResponse.status ==
                    Status.LOADING ||
                controller.getAnnouncementListApiResponse.status ==
                    Status.INITIAL) {
              return getDataLoadingIndicator();
            }
            if (controller.getAnnouncementListApiResponse.status ==
                Status.ERROR) {
              return getDataErrorMsg();
            }
            GetAnnounceListResModel model =
                controller.getAnnouncementListApiResponse.data;
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
                          AnnouncementLogic.getAnnounceCount(
                              data.id.toString());
                          showAnnouncementDialog(data);
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DateBox(
                                    text: data.aDate ?? VariableUtils.none,
                                    textStyle: FontTextStyle.poppinsW6S13Grey,
                                  ),
                                  SizeConfig.sH10,
                                  Text(data.title ?? VariableUtils.none),
                                  if (userData.usertype !=
                                      ConstUtils.kGetRoleIndex(
                                          VariableUtils.parent))
                                    SizeConfig.sH10,
                                  if (userData.usertype !=
                                      ConstUtils.kGetRoleIndex(
                                          VariableUtils.parent))
                                    Wrap(
                                      spacing: 10,
                                      runSpacing: 10,
                                      children: [
                                        richText(
                                            key: VariableUtils.sent,
                                            value: data.sentCount ??
                                                VariableUtils.none),
                                        richText(
                                            key: VariableUtils.read,
                                            value: data.readCount ??
                                                VariableUtils.none),
                                        richText(
                                            key: VariableUtils.remark,
                                            value:
                                                data.remarkCount?.toString() ??
                                                    VariableUtils.none),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                AnnouncementLogic.getAnnounceCount(
                                    data.id.toString());
                                showAnnouncementDialog(data);
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
      TextSpan(text: key + ' : ', style: FontTextStyle.poppinsW5S12Grey),
      TextSpan(
        text: value,
        style: FontTextStyle.poppinsW7S12DarkGrey,
      )
    ]));
  }
}

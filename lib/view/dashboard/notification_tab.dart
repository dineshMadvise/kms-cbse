import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonWidgets/add_or_forword_circle_box.dart';
import 'package:msp_educare_demo/dialog/notification_list_dialog.dart';
import 'package:msp_educare_demo/logic/notification_logic.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_notification_list_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/dashboard_viewmodel.dart';
import 'package:msp_educare_demo/viewModel/notification_viewmodel.dart';

class NotificationTab extends StatefulWidget {
  @override
  State<NotificationTab> createState() => _NotificationTabState();
}

class _NotificationTabState extends State<NotificationTab> {
  DashBoardViewModel _viewModel =
      Get.find(tag: DashBoardViewModel().toString());

  NotificationViewModel _notificationViewModel =
      Get.find(tag: NotificationViewModel().toString());

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    _notificationViewModel.getNotificationList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
          title: VariableUtils.notification,
          actionVisible: false,
          centerTitle: true,
          leadingTap: () {
            _viewModel.selectedBottomNaviIndex = 0;
          }),
      body: buildBody(),
    );
  }

  SizedBox buildBody() {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
          decoration: DecorationUtils.commonDecorationBox(),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: GetBuilder<NotificationViewModel>(
            tag: NotificationViewModel().toString(),
            builder: (controller) {
              if (controller.getNotificationListApiResponse.status ==
                      Status.LOADING ||
                  controller.getNotificationListApiResponse.status ==
                      Status.INITIAL) {
                return getDataLoadingIndicator();
              }
              if (controller.getNotificationListApiResponse.status ==
                  Status.ERROR) {
                return getDataErrorMsg();
              }
              GetNotificationListResModel model =
                  controller.getNotificationListApiResponse.data;
              if (model.status != VariableUtils.ok) {
                return getFieldIsEmptyMsg();
              }
              print('LENGTH:${model.data!.length}');
              return model.data!.isEmpty
                  ? getNotApplicableMsg()
                  : ListView.separated(
                      itemCount: model.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        final data = model.data![index];
                        return InkWell(
                          onTap: () {
                            showNotificationListDialog(data);
                            NotificationLogic.updateNotificationCount(data.id!);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            border: Border.all(
                                                color: ColorUtils.grey)),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CircleAvatar(
                                              radius: 5,
                                              backgroundColor:
                                                  ColorUtils.lightRed,
                                            ),
                                            SizeConfig.sW10,
                                            Text(
                                              data.aDate ?? VariableUtils.none,
                                              style: data.readFlag == '0'
                                                  ? FontTextStyle
                                                      .poppinsW6S13LightOrange
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeightClass
                                                                  .regular)
                                                  : FontTextStyle
                                                      .poppinsW6S13LightOrange
                                                      .copyWith(
                                                          color: ColorUtils.black,
                                                          fontWeight:
                                                              FontWeightClass
                                                                  .regular),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizeConfig.sH10,
                                      Text(
                                        data.title ?? VariableUtils.none,
                                        style: data.readFlag == '0'
                                            ? FontTextStyle
                                                .poppinsW6S13LightOrange
                                            : FontTextStyle
                                                .poppinsW6S13LightOrange
                                                .copyWith(
                                                    color: ColorUtils.black),
                                      )
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    showNotificationListDialog(data);
                                    NotificationLogic.updateNotificationCount(
                                        data.id!);
                                  },
                                  child: AddOrForwordCircleBox(
                                    icon: ConstUtils.kForwordArrowIcon,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                          height: 7,
                        );
                      },
                    );
            },
          )),
    );
  }
}

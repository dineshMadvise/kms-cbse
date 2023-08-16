// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/common/commonMethods/join_link_method.dart';
import 'package:msp_educare_demo/common/commonWidgets/octo_image_network.dart';
import 'package:msp_educare_demo/dialog/events_dialog.dart';
import 'package:msp_educare_demo/utils/assets/icons_utils.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/events_viewmodel.dart';
import '../../common/commonMethods/loading_indicator.dart';
import '../../model/apiModel/responseModel/get_event_list_res_model.dart';
import '../../model/apis/api_response.dart';
import '../../viewModel/dashboard_viewmodel.dart';

class EventsList extends StatefulWidget {
  const EventsList({Key? key, this.fromDashboard = false}) : super(key: key);
  final bool fromDashboard;

  @override
  State<EventsList> createState() => _EventsListState();
}

class _EventsListState extends State<EventsList> {
  EventsViewModel viewModel = Get.find(tag: EventsViewModel().toString());
  DashBoardViewModel dashBoardViewModel =
      Get.find(tag: DashBoardViewModel().toString());

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    viewModel.getEventList();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (widget.fromDashboard) {
          dashBoardViewModel.selectedBottomNaviIndex = 0;
        } else {
          Get.back();
        }
        return Future.value(false);
      },
      child: Scaffold(
        appBar: customAppbar(
            title: VariableUtils.events,
            centerTitle: true,
            leadingTap: () {
              if (widget.fromDashboard) {
                dashBoardViewModel.selectedBottomNaviIndex = 0;
              } else {
                Get.back();
              }
            }),
        body: buildBody(),
      ),
    );
  }

  Widget buildBody() {
    return SizedBox(
        width: Get.width,
        height: Get.height,
        child: GetBuilder<EventsViewModel>(
          tag: EventsViewModel().toString(),
          builder: (controller) {
            if (controller.getEventListApiResponse.status == Status.LOADING ||
                controller.getEventListApiResponse.status == Status.INITIAL) {
              return getDataLoadingIndicator();
            }
            if (controller.getEventListApiResponse.status == Status.ERROR) {
              return getDataErrorMsg();
            }
            GetEventListResModel model =
                controller.getEventListApiResponse.data;
            if (model.status != VariableUtils.ok) {
              return getFieldIsEmptyMsg();
            }
            print('LENGTH:${model.data!.length}');
            return model.data!.isEmpty
                ? getNotApplicableMsg(msg: model.msg)
                : ListView.builder(
                    physics:const  BouncingScrollPhysics(),
                    itemCount: model.data!.length,
                    itemBuilder: (context, index) {
                      final data = model.data![index];
                      return InkWell(
                        onTap: () {
                          showEventsDialog(data);
                        },
                        child: Container(
                          margin:const EdgeInsets.fromLTRB(20, 10, 20, 20),
                          decoration: DecorationUtils.commonDecorationBox(),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (data.img != null && data.img != '')
                                Padding(
                                  padding:const EdgeInsets.only(bottom: 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: OctoImageNetwork(
                                      url: data.img,
                                      height: Get.height * 0.17,
                                      width: Get.width,
                                      circleShape: false,
                                      fit: true,
                                    ),
                                  ),
                                ),
                              // Container(
                              //   height: Get.height * 0.17,
                              //   width: Get.width,
                              //   margin: EdgeInsets.only(bottom: 10),
                              //   decoration: BoxDecoration(
                              //       color: ColorUtils.lightGrey2,
                              //       borderRadius: BorderRadius.circular(5)),
                              //   child: Center(child: Text('Banner')),
                              // ),
                              Text(
                                data.title ?? VariableUtils.none,
                                style: FontTextStyle.poppinsW6S16DarkGrey,
                              ),
                              SizeConfig.sH10,
                              buildRow(
                                  icon: IconsWidgets.calendar,
                                  title:
                                      data.eventDayDate ?? VariableUtils.none),
                              SizeConfig.sH10,
                              buildRow(
                                  icon: IconsWidgets.clock,
                                  title:
                                      '${data.startTime ?? VariableUtils.none} - ${data.endTime ?? VariableUtils.none}'),
                              SizeConfig.sH10,
                              InkWell(
                                onTap: () {
                                  if (data.venue!.contains('http') ||
                                      data.venue!.contains('https'))
                                    onTap(link: data.venue!);
                                },
                                child: buildRow(
                                    icon: IconsWidgets.locationPin,
                                    title: data.venue ?? VariableUtils.none),
                              ),
                              SizeConfig.sH10,
                              Text(
                                VariableUtils.participants,
                                style: FontTextStyle.poppinsW6S16DarkGrey,
                              ),
                              SizeConfig.sH10,
                              Wrap(
                                runSpacing: 10,
                                spacing: 5,
                                children: List.generate(
                                  data.studentList!.length + 1,
                                  (index) => index > 10 ||
                                          data.studentList!.isEmpty ||
                                          index > data.studentList!.length - 1
                                      ? data.moreStudentCnt! > 0
                                          ? CircleAvatar(
                                              radius: 22,
                                              backgroundColor:
                                                  ColorUtils.lightGrey,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(3),
                                                child: Text(
                                                  '+${data.moreStudentCnt}',
                                                  style: FontTextStyle
                                                      .poppinsW5S10Blue,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            )
                                          : const SizedBox()
                                      : ClipOval(
                                          child: OctoImageNetwork(
                                            url: data.studentList![index],
                                            radius: 20,
                                            width: 40,
                                            height: 40,
                                          ),
                                        ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
          },
        ));
  }

  Widget buildRow({required Widget icon, required String title}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        icon,
        SizeConfig.sW5,
        Expanded(
          child: Text(
            title,
            style: FontTextStyle.poppinsW5S14Grey,
          ),
        )
      ],
    );
  }
}

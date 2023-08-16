import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/audio_play_service.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_btn.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_dropdown.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_text_field.dart';
import 'package:msp_educare_demo/common/commonWidgets/loading_dropdown.dart';
import 'package:msp_educare_demo/logic/call_logic.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/add_voice_call_campagin_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/get_stud_att_list_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_class_option_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_multiple_class_section_option_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_multiple_class_stud_option_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_template_id_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/voice_temp_info_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/validation_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/call_view_model.dart';
import 'package:msp_educare_demo/viewModel/dropdown_options_viewmodel.dart';

import 'widgets/voice_audio_player.dart';

class AddCallCampaign extends StatefulWidget {
  const AddCallCampaign({Key? key}) : super(key: key);

  @override
  State<AddCallCampaign> createState() => _AddCallCampaignState();
}

class _AddCallCampaignState extends State<AddCallCampaign> {
  final formKey = GlobalKey<FormState>();
  late UserData userData;
  final DropdownOptionViewModel _optionViewModel =
      Get.find(tag: DropdownOptionViewModel().toString());

  final CallViewModel _viewModel = Get.find(tag: CallViewModel().toString());

  AddVoiceCallCampaginReqModel reqModel = AddVoiceCallCampaginReqModel();

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    userData = ConstUtils.getUserData();
    _optionViewModel.getClassOption();

    _optionViewModel.getTemplateOption(true);
    _viewModel.clearClassList();
    _viewModel.clearSelectedSectionList();
    _viewModel.clearClassStudList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: VariableUtils.addNewCallCampaign),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return GetBuilder<CallViewModel>(
      tag: CallViewModel().toString(),
      builder: (controller) {
        return Container(
          height: Get.height,
          width: Get.width,
          margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          decoration: DecorationUtils.commonDecorationBox(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: formData(),
        );
      },
    );
  }

  SingleChildScrollView formData() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 5),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            templatesId(),
            SizeConfig.sH10,
            CommonTextField(
              titleText: VariableUtils.campaignName,
              regularExpression: RegularExpression.addressValidationPattern,
              hintText: VariableUtils.campaignName,
              // initialValue: reqModel.campaignName,
              isValidate: true,
              onChange: (value) {
                reqModel.campaignName = value;
              },
              // isValidate: true,

              validationMessage: ValidationMsg.isRequired,
            ),
            SizeConfig.sH10,
            if (reqModel.templateId?.isNotEmpty == true)
              Text(VariableUtils.audionFile,
                  style: FontTextStyle.poppinsW6S12Grey),
            if (reqModel.templateId?.isNotEmpty == true) SizeConfig.sH5,
            if (reqModel.templateId?.isNotEmpty == true) VoiceAudioPlayer(),
            if (reqModel.templateId?.isNotEmpty == true) SizeConfig.sH10,
            CustomDropDown(
              titleText: VariableUtils.publishTo,
              listData: ConstUtils.kPublicDropDownList,
              onChangeString: (value) {
                reqModel.publishTo = (value as String).capitalize;
                print('PUBLISH VALUE ${reqModel.publishTo}');
                setState(() {});
                _optionViewModel.clearMultiClassSection();
                _optionViewModel.clearMultiClassStud();
              },
            ),
            if (reqModel.publishTo != VariableUtils.all &&
                reqModel.publishTo != null &&
                reqModel.publishTo != VariableUtils.teacher)
              classListTile(),
            if (reqModel.publishTo == VariableUtils.classAndSection)
              sectionListTile(),
            if (reqModel.publishTo == VariableUtils.student) studentListTile(),
            SizeConfig.sH20,
            GetBuilder<CallViewModel>(
              tag: CallViewModel().toString(),
              builder: (controller) {
                if (controller.addCallListApiResponse.status ==
                    Status.LOADING) {
                  return getDataLoadingIndicator();
                }
                return CustomBtn(
                  onTap: saveBtn,
                  radius: 10,
                  title: VariableUtils.save,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveBtn() async {
    print('ADD Voice DATE ===>${reqModel.toJson()}');
    logs('ADD Voice DATE ===>${reqModel.toJson()}');
    if (formKey.currentState!.validate()) {
      // if (viewModel.selectedFile == '') {
      //   showToast(msg: VariableUtils.pleaseSelectFile);
      //   return;
      // }

      final status = await CallLogic.addCall(reqModel);
      if (true) {
        // await Future.delayed(Duration(seconds: 2));
        formKey.currentState!.reset();
      }
    }
  }

  Widget classListTile() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(VariableUtils.selectClass.toUpperCase(),
              style: FontTextStyle.poppinsW5S12Grey),
          SizeConfig.sH10,
          GetBuilder<DropdownOptionViewModel>(
            tag: DropdownOptionViewModel().toString(),
            builder: (controller) {
              if (controller.getCLassOptionApiResponse.status ==
                  Status.INITIAL) {
                return Container(
                  decoration: DecorationUtils.borderDecorationBox(),
                  height: Get.height * 0.2,
                );
              }

              if (controller.getCLassOptionApiResponse.status ==
                  Status.COMPLETE) {
                GetClassOptionResModel model =
                    controller.getCLassOptionApiResponse.data;

                // List<dynamic> list = model.data!.map((e) => e.name).toList();
                return Container(
                  decoration: DecorationUtils.borderDecorationBox(),
                  height: Get.height * 0.2,
                  child: ListView(
                    children: model.data!
                        .map((e) => GetBuilder<CallViewModel>(
                              tag: CallViewModel().toString(),
                              builder: (con) {
                                return Container(
                                  decoration: BoxDecoration(
                                      color:
                                          con.selectedClassList.contains(e.id)
                                              ? ColorUtils.blue
                                              : ColorUtils.transparent,
                                      borderRadius: BorderRadius.circular(4)),
                                  margin: EdgeInsets.only(
                                      top: model.data!.indexOf(e) == 0 ? 0 : 5),
                                  child: ListTile(
                                    onTap: () {
                                      _viewModel.setClassList(e.id!);
                                      if (reqModel.publishTo ==
                                          VariableUtils.classAndSection) {
                                        final classIds =
                                            ConstUtils.convertListToString(
                                                con.selectedClassList);
                                        print('CLASS ID : $classIds');
                                        _viewModel.clearSelectedSectionList();
                                        if (classIds == '') {
                                          _optionViewModel
                                              .clearMultiClassSection();
                                        } else {
                                          _optionViewModel
                                              .getMultiClassSectionOption(
                                                  classIds);
                                        }
                                      }
                                      if (reqModel.publishTo ==
                                          VariableUtils.student) {
                                        final classIds =
                                            ConstUtils.convertListToString(
                                                con.selectedClassList);
                                        _viewModel.clearClassStudList();
                                        if (classIds == '') {
                                          _optionViewModel
                                              .clearMultiClassStud();
                                        } else {
                                          _optionViewModel
                                              .getMultiClassStudOption(
                                                  classIds);
                                        }
                                      }
                                    },
                                    title: Text(
                                      e.name ?? VariableUtils.none,
                                      style:
                                          con.selectedClassList.contains(e.id)
                                              ? FontTextStyle.poppinsW5S16White
                                              : FontTextStyle.poppinsW5S16Black,
                                    ),
                                  ),
                                );
                              },
                            ))
                        .toList(),
                  ),
                );
              }
              return Container(
                decoration: DecorationUtils.borderDecorationBox(),
                height: Get.height * 0.2,
                child: getDataLoadingIndicator(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget sectionListTile() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(VariableUtils.selectSection.toUpperCase(),
              style: FontTextStyle.poppinsW5S12Grey),
          SizeConfig.sH10,
          GetBuilder<DropdownOptionViewModel>(
            tag: DropdownOptionViewModel().toString(),
            builder: (controller) {
              if (controller.getMultipleClassSectionOptionApiResponse.status ==
                  Status.INITIAL) {
                return Container(
                  decoration: DecorationUtils.borderDecorationBox(),
                  height: Get.height * 0.2,
                );
              }
              print(
                  'SECTOI STATUS :=>${controller.getMultipleClassSectionOptionApiResponse.status}');
              if (controller.getMultipleClassSectionOptionApiResponse.status ==
                  Status.COMPLETE) {
                GetMultipleClassSectionOptionResModel model =
                    controller.getMultipleClassSectionOptionApiResponse.data;

                return Container(
                  decoration: DecorationUtils.borderDecorationBox(),
                  height: Get.height * 0.2,
                  child: ListView(
                    children: model.data!
                        .map((e) => GetBuilder<CallViewModel>(
                              tag: CallViewModel().toString(),
                              builder: (con) {
                                return Container(
                                  decoration: BoxDecoration(
                                      color:
                                          con.selectedSectionList.contains(e.id)
                                              ? ColorUtils.blue
                                              : ColorUtils.transparent,
                                      borderRadius: BorderRadius.circular(4)),
                                  margin: EdgeInsets.only(
                                      top: model.data!.indexOf(e) == 0 ? 0 : 5),
                                  child: ListTile(
                                    onTap: () {
                                      _viewModel.setSectionList(e.id!);
                                    },
                                    title: Text(
                                      e.name ?? VariableUtils.none,
                                      style:
                                          con.selectedSectionList.contains(e.id)
                                              ? FontTextStyle.poppinsW5S16White
                                              : FontTextStyle.poppinsW5S16Black,
                                    ),
                                  ),
                                );
                              },
                            ))
                        .toList(),
                  ),
                );
              }
              return Container(
                decoration: DecorationUtils.borderDecorationBox(),
                height: Get.height * 0.2,
                child: getDataLoadingIndicator(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget studentListTile() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(VariableUtils.selectStud, style: FontTextStyle.poppinsW5S12Grey),
          SizeConfig.sH10,
          GetBuilder<DropdownOptionViewModel>(
            tag: DropdownOptionViewModel().toString(),
            builder: (controller) {
              if (controller.getMultipleClassStudentOptionApiResponse.status ==
                  Status.COMPLETE) {
                GetMultipleClassStudOptionResModel model =
                    controller.getMultipleClassStudentOptionApiResponse.data;

                return Container(
                  decoration: DecorationUtils.borderDecorationBox(),
                  height: Get.height * 0.2,
                  child: ListView(
                    children: model.data!
                        .map((e) => GetBuilder<CallViewModel>(
                              tag: CallViewModel().toString(),
                              builder: (con) {
                                return Container(
                                  decoration: BoxDecoration(
                                      color: con.selectedClassStudList
                                              .contains(e.id)
                                          ? ColorUtils.blue
                                          : ColorUtils.transparent,
                                      borderRadius: BorderRadius.circular(4)),
                                  margin: EdgeInsets.only(
                                      top: model.data!.indexOf(e) == 0 ? 0 : 5),
                                  child: ListTile(
                                    onTap: () {
                                      _viewModel.setClassStudList(e.id!);
                                    },
                                    title: Text(
                                      e.name ?? VariableUtils.none,
                                      style: con.selectedClassStudList
                                              .contains(e.id)
                                          ? FontTextStyle.poppinsW5S16White
                                          : FontTextStyle.poppinsW5S16Black,
                                    ),
                                  ),
                                );
                              },
                            ))
                        .toList(),
                  ),
                );
              }
              return Container(
                decoration: DecorationUtils.borderDecorationBox(),
                height: Get.height * 0.2,
                width: Get.width,
                child: controller
                            .getMultipleClassStudentOptionApiResponse.status ==
                        Status.LOADING
                    ? getDataLoadingIndicator()
                    : SizedBox(),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> getVoiceTempInfo() async {
    await AudioPlayService.stop();

    await _viewModel.voiceTempInfo(reqModel.templateId.toString());
    if (_viewModel.getVoiceTempInfoApiResposne.status == Status.COMPLETE) {
      final VoiceTempInfoResModel result =
          _viewModel.getVoiceTempInfoApiResposne.data;

      if (result.status == VariableUtils.ok) {
        await AudioPlayService.initNetwork(result.data!.first.voiceFile!);
        setState(() {});
      }
    }
  }

  Widget templatesId() {
    return GetBuilder<DropdownOptionViewModel>(
      tag: DropdownOptionViewModel().toString(),
      builder: (controller) {
        if (controller.getTemplateOptionApiResponse.status == Status.COMPLETE) {
          GetTemplateIdResModel model =
              controller.getTemplateOptionApiResponse.data;

          List<String?> data = model.data!.map((e) => e.name).toList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(VariableUtils.callTemplate.toUpperCase(),
                  style: FontTextStyle.poppinsW6S12Grey),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<String>(
                isExpanded: true,
                items: data
                    .map((e) => DropdownMenuItem(
                          child: Text('$e'),
                          value: e,
                        ))
                    .toList(),
                icon: const Icon(
                  ConstUtils.kDownArrowIcon,
                  color: ColorUtils.grey,
                ),
                validator: ValidationMethod.validateIsRequired,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: FontTextStyle.poppinsW5S16Black,
                onChanged: (String? value) {
                  reqModel.templateId = model.data!
                      .firstWhere((element) => element.name == value)
                      .id;
                  getVoiceTempInfo();
                },
                hint: Text(
                  VariableUtils.select,
                  style: FontTextStyle.poppinsW5S12Grey,
                  overflow: TextOverflow.clip,
                ),
                decoration: DecorationUtils.inputDecoration(),
              ),
            ],
          );
        }
        return const LoadingDropDown(
          title: VariableUtils.callTemplate,
        );
      },
    );
  }
}

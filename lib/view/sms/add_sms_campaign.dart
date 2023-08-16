import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_btn.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_dropdown.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_text_field.dart';
import 'package:msp_educare_demo/common/commonWidgets/loading_dropdown.dart';
import 'package:msp_educare_demo/logic/sms_logic.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/add_new_sms_campaign_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_class_option_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_multiple_class_section_option_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_multiple_class_stud_option_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_subject_option_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_temp_info_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_template_id_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/validation_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/dropdown_options_viewmodel.dart';
import 'package:msp_educare_demo/viewModel/sms_viewmodel.dart';

class AddNewSmsCampaign extends StatefulWidget {
  const AddNewSmsCampaign({Key? key}) : super(key: key);

  @override
  State<AddNewSmsCampaign> createState() => _AddNewSmsCampaignState();
}

class _AddNewSmsCampaignState extends State<AddNewSmsCampaign> {
  final formKey = GlobalKey<FormState>();
  late UserData userData;
  final DropdownOptionViewModel _optionViewModel =
      Get.find(tag: DropdownOptionViewModel().toString());
  final SmsViewModel _viewModel = Get.find(tag: SmsViewModel().toString());
  AddNewSmsCampaignReqModel reqModel = AddNewSmsCampaignReqModel();

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    userData = ConstUtils.getUserData();
    _optionViewModel.getClassOption();
    _optionViewModel.getTemplateOption(false);
    _viewModel.clearClassList();
    _viewModel.clearSelectedSectionList();
    _viewModel.clearClassStudList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: VariableUtils.addNewSmsCampaign),
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
      child: formData(),
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
            templatesIdDropDown(),
            SizeConfig.sH10,
            CommonTextField(
              titleText: VariableUtils.campaignName,
              regularExpression: RegularExpression.addressValidationPattern,
              hintText: VariableUtils.campaignName,
              initialValue: reqModel.campaignName,
              isValidate: true,
              onChange: (value) {
                reqModel.campaignName = value;
              },
              // isValidate: true,

              // validationMessage: ValidationMsg.isRequired,
            ),
            SizeConfig.sH10,
            CommonTextField(
              key: ValueKey(reqModel.description),
              titleText: VariableUtils.descriptio,
              regularExpression: RegularExpression.addressValidationPattern,
              hintText: VariableUtils.descriptio,
              initialValue: reqModel.description,
              isValidate: true,

              onChange: (value) {
                reqModel.description = value;
              },
              maxLine: 4,
              // validationMessage: ValidationMsg.isRequired,
            ),
            SizeConfig.sH20,
            CustomDropDown(
              titleText: VariableUtils.publishTo,
              listData: ConstUtils.kPublicDropDownList,
              onChangeString: (value) {
                reqModel.publishTo = (value as String).capitalize;
                print('PUBLISH VALUE ${reqModel.publishTo}');
                setState(() {});
                _optionViewModel.clearMultiClassSection();
                _optionViewModel.clearMultiClassStud();
                // viewModel.clearClassList();
                // viewModel.clearSelectedSectionList();
                // viewModel.clearClassStudList();
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
            GetBuilder<SmsViewModel>(
              tag: SmsViewModel().toString(),
              builder: (controller) {
                if (controller.addSmsListApiResponse.status == Status.LOADING) {
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
    print('ADD SMS DATE ===>${reqModel.toJson()}');
    logs('ADD SMS DATE ===>${reqModel.toJson()}');
    if (formKey.currentState!.validate()) {
      // if (viewModel.selectedFile == '') {
      //   showToast(msg: VariableUtils.pleaseSelectFile);
      //   return;
      // }

      final status = await SmsLogic.addSms(reqModel);
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
                        .map((e) => GetBuilder<SmsViewModel>(
                              tag: SmsViewModel().toString(),
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

                // List<dynamic> list = model.data!.map((e) => e.name).toList();
                return Container(
                  decoration: DecorationUtils.borderDecorationBox(),
                  height: Get.height * 0.2,
                  child: ListView(
                    children: model.data!
                        .map((e) => GetBuilder<SmsViewModel>(
                              tag: SmsViewModel().toString(),
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

                // List<dynamic> list = model.data!.map((e) => e.name).toList();
                return Container(
                  decoration: DecorationUtils.borderDecorationBox(),
                  height: Get.height * 0.2,
                  child: ListView(
                    children: model.data!
                        .map((e) => GetBuilder<SmsViewModel>(
                              tag: SmsViewModel().toString(),
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

  Future<void> getTemplateInfo() async {
    await _viewModel.tempInfoId(reqModel.templateId.toString());
    if (_viewModel.tempIdApiResponse.status == Status.COMPLETE) {
      final GetTempIdResModel result = _viewModel.tempIdApiResponse.data;
      if (result.status == VariableUtils.ok) {
        reqModel.description = result.data!.first.description;
        setState(() {});
      }
    }
  }

  Widget templatesIdDropDown() {
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
              Text(VariableUtils.templateId.toUpperCase(),
                  style: FontTextStyle.poppinsW6S12Grey),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<String>(
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
                  getTemplateInfo();
                },
                hint: Text(
                  VariableUtils.select,
                  style: FontTextStyle.poppinsW5S12Grey,
                ),
                decoration: DecorationUtils.inputDecoration(),
              ),
            ],
          );
        }
        return const LoadingDropDown(
          title: VariableUtils.templateId,
        );
      },
    );
  }
}

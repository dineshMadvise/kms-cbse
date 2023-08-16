import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonMethods/toast_msg.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_btn.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_datetime_textfield.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_dropdown.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_text_field.dart';
import 'package:msp_educare_demo/logic/enquiry_logic.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/save_enquiry_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_class_option_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_enquiry_info_res_modeldart.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_nationality_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/dateformat_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/validation_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/dropdown_options_viewmodel.dart';
import 'package:msp_educare_demo/viewModel/enquiry_viewmodel.dart';

class AddEnquiryScreen extends StatefulWidget {
  @override
  State<AddEnquiryScreen> createState() => _AddEnquiryScreenState();
}

class _AddEnquiryScreenState extends State<AddEnquiryScreen> {
  final formKey = GlobalKey<FormState>();
  bool isUpdate = false;
  SaveEnquiryReqModel reqModel = SaveEnquiryReqModel();

  EnquiryViewModel viewModel = Get.find(tag: EnquiryViewModel().toString());
  DropdownOptionViewModel optionViewModel =
      Get.find(tag: DropdownOptionViewModel().toString());

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    optionViewModel.getNationalityOption();
    optionViewModel.getClassOption();
    reqModel.gender = VariableUtils.male;

    setData();
  }

  void setData() {
    final argu = Get.arguments;
    if (argu == null) {
      return;
    }
    isUpdate = true;
    EnquiryData model = argu as EnquiryData;
    reqModel.studentName = model.studentName;
    reqModel.dob = model.dob;
    reqModel.nationality = model.nationality;
    reqModel.classId = model.classId;
    reqModel.gender = model.gender;
    reqModel.age = model.age;
    reqModel.parentName = model.parentName;
    reqModel.phoneNo = model.phoneNo;
    reqModel.area = model.area;
    reqModel.id = model.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: VariableUtils.addEnquiry,
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Container(
      // height: Get.height,
      width: Get.width,
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      decoration: DecorationUtils.commonDecorationBox(),

      child: formData(),
    );
  }

  Widget formData() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonTextField(
                    titleText: VariableUtils.studentName,
                    regularExpression:
                        RegularExpression.addressValidationPattern,
                    hintText: VariableUtils.studentName,
                    initialValue: reqModel.studentName,
                    onChange: (value) {
                      reqModel.studentName = value;
                    },
                    isValidate: true,
                    validationMessage: ValidationMsg.isRequired,
                  ),
                  // SizeConfig.sH20,

                  CustomDateTimeTextField(
                    titleText: VariableUtils.dob,
                    isValidate: true,
                    lastDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    initialValue: reqModel.dob != null
                        ? DateFormat('dd-MM-yyyy').parse(reqModel.dob!)
                        : null,
                    onChangeDateTime: (value) {
                      print('DATE :$value');
                      reqModel.dob =
                          DateFormatUtils.ddMMYYYYFormatWithUnderStore(value);
                      final now = DateTime.now();
                      reqModel.age = (now.year - value.year).toString();
                      print('AGE :${reqModel.age}');
                      setState(() {});
                    },
                  ),
                  SizeConfig.sH20,
                  nationalityDropdown(),
                  SizeConfig.sH20,
                  classDropdown(),
                  SizeConfig.sH20,
                  Text(VariableUtils.gender.toUpperCase(),
                      style: FontTextStyle.poppinsW6S12Grey),
                  Row(
                    children: [
                      Row(
                        children: [
                          Radio(
                              value: VariableUtils.male,
                              groupValue: reqModel.gender,
                              onChanged: (String? value) {
                                setState(() {
                                  reqModel.gender = value;
                                });
                              }),
                          SizeConfig.sW5,
                          const Text(VariableUtils.male),
                        ],
                      ),
                      SizeConfig.sW20,
                      Row(
                        children: [
                          Radio(
                              value: VariableUtils.feMale,
                              groupValue: reqModel.gender,
                              onChanged: (String? value) {
                                setState(() {
                                  reqModel.gender = value;
                                });
                              }),
                          SizeConfig.sW5,
                          const Text(VariableUtils.feMale),
                        ],
                      ),
                      // Expanded(
                      //   child: RadioListTile(
                      //       title: Text(VariableUtils.male),
                      //       contentPadding: EdgeInsets.zero,
                      //       value: VariableUtils.male,
                      //       groupValue: reqModel.gender,
                      //       onChanged: (String? value) {
                      //         setState(() {
                      //           reqModel.gender = value;
                      //         });
                      //       }),
                      // ),
                      // Expanded(
                      //   child: RadioListTile(
                      //       title: Text(VariableUtils.feMale),
                      //       value: VariableUtils.feMale,
                      //       groupValue: reqModel.gender,
                      //       contentPadding: EdgeInsets.zero,
                      //       onChanged: (String? value) {
                      //         setState(() {
                      //           reqModel.gender = value;
                      //         });
                      //       }),
                      // ),
                    ],
                  ),
                  SizeConfig.sH10,
                  Text(VariableUtils.age.toUpperCase(),
                      style: FontTextStyle.poppinsW6S12Grey),
                  SizeConfig.sH10,
                  Container(
                    decoration: DecorationUtils.borderDecorationBox(
                        radius: 8.0, color: ColorUtils.grey.withOpacity(0.2)),
                    height: 48,
                    width: Get.width,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      reqModel.age ?? '',
                      style: FontTextStyle.poppinsW5S12Grey,
                    ),
                  ),
                  SizeConfig.sH5,

                  // CommonTextField(
                  //   titleText: VariableUtils.age,
                  //   regularExpression: RegularExpression.digitsPattern,
                  //   textInputType: TextInputType.number,
                  //   hintText: VariableUtils.age,
                  //   initialValue: reqModel.age,
                  //   readOnly: true,
                  //   onChange: (value) {
                  //     reqModel.age = value;
                  //   },
                  //   isValidate: true,
                  //   validationMessage: ValidationMsg.isRequired,
                  // ),
                  SizeConfig.sH10,
                  CommonTextField(
                    titleText: VariableUtils.parentName,
                    initialValue: reqModel.parentName,
                    regularExpression:
                        RegularExpression.addressValidationPattern,
                    hintText: VariableUtils.parentName,
                    onChange: (value) {
                      reqModel.parentName = value;
                    },
                    isValidate: true,
                    validationMessage: ValidationMsg.isRequired,
                  ),
                  SizeConfig.sH10,
                  CommonTextField(
                    titleText: VariableUtils.pNumber,
                    regularExpression: RegularExpression.digitsPattern,
                    hintText: VariableUtils.pNumber,
                    initialValue: reqModel.phoneNo,
                    textInputType: TextInputType.number,
                    onChange: (value) {
                      reqModel.phoneNo = value;
                    },
                    isValidate: true,
                    validationMessage: ValidationMsg.isRequired,
                  ),
                  SizeConfig.sH10,
                  CommonTextField(
                    titleText: VariableUtils.area,
                    regularExpression:
                        RegularExpression.addressValidationPattern,
                    hintText: VariableUtils.area,
                    initialValue: reqModel.area,
                    onChange: (value) {
                      reqModel.area = value;
                    },
                    isValidate: true,
                    maxLine: 4,
                    validationMessage: ValidationMsg.isRequired,
                  ),
                  SizeConfig.sH20,
                  isUpdate
                      ? Row(
                          children: [
                            Expanded(
                              child: CustomBtn(
                                onTap: deleteOnTap,
                                radius: 10,
                                title: VariableUtils.delete,
                              ),
                            ),
                            SizeConfig.sW20,
                            Expanded(
                              child: CustomBtn(
                                onTap: updateOnTap,
                                radius: 10,
                                title: VariableUtils.update,
                              ),
                            ),
                          ],
                        )
                      : CustomBtn(
                          onTap: saveBtn,
                          radius: 10,
                          title: VariableUtils.save,
                        ),
                ],
              ),
            ),
          ),
        ),
        GetBuilder<EnquiryViewModel>(
          tag: EnquiryViewModel().toString(),
          builder: (controller) {
            if (controller.saveEnquiryApiResponse.status == Status.LOADING ||
                controller.deleteEnquiryApiResponse.status == Status.LOADING) {
              return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: postDataLoadingIndicator());
            }
            return const SizedBox();
          },
        )
      ],
    );
  }

  /// NATIONALITY DROP DOWN
  GetBuilder<DropdownOptionViewModel> nationalityDropdown() {
    return GetBuilder<DropdownOptionViewModel>(
      tag: DropdownOptionViewModel().toString(),
      builder: (controller) {
        if (controller.getNationalityOptionApiResponse.status ==
            Status.COMPLETE) {
          GetNationalityResModel model =
              controller.getNationalityOptionApiResponse.data;

          List<String?> list = model.data!.map((e) => e.name).toList();
          int index = model.data!
              .indexWhere((element) => element.id == reqModel.nationality);

          String? name;
          if (index > -1) {
            name = model.data![index].name!;
          }
          return CustomDropDown(
            titleText: VariableUtils.nationality,
            listData: ConstUtils.convertNullSafetyListToSimpleList(list),
            value: name,
            onChangeString: (value) {
              reqModel.nationality =
                  model.data!.firstWhere((element) => element.name == value).id;
              print('SELECTED CALUE =>$value');
            },
          );
        }
        return loadingDropdown(
          VariableUtils.nationality,
        );
      },
    );
  }

  /// GET CLASS DROP DOWN
  GetBuilder<DropdownOptionViewModel> classDropdown() {
    return GetBuilder<DropdownOptionViewModel>(
      tag: DropdownOptionViewModel().toString(),
      builder: (controller) {
        if (controller.getCLassOptionApiResponse.status == Status.COMPLETE) {
          GetClassOptionResModel model =
              controller.getCLassOptionApiResponse.data;

          List<String?> list = model.data!.map((e) => e.name).toList();
          int index = model.data!
              .indexWhere((element) => element.id == reqModel.classId);

          String? className;
          if (index > -1) {
            className = model.data![index].name!;
          }
          return CustomDropDown(
            titleText: VariableUtils.admissionForClass,
            listData: ConstUtils.convertNullSafetyListToSimpleList(list),
            value: className,
            onChangeString: (value) {
              reqModel.classId =
                  model.data!.firstWhere((element) => element.name == value).id;
              print('SELECTED CALUE =>$value');
            },
          );
        }
        return loadingDropdown(
          VariableUtils.admissionForClass,
        );
      },
    );
  }

  CustomDropDown loadingDropdown(String title) {
    return CustomDropDown(
      titleText: title,
      listData: [],
      value: null,
      onChangeString: (value) {},
    );
  }

  Future<void> saveBtn() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (reqModel.age == null || reqModel.age == '') {
        showToast(msg: VariableUtils.pleaseSelectAge);
        return;
      }
      final status = await EnquiryLogic.saveEnquiry(reqModel, isUpdate: false);
      // if (status) {
      //   // await Future.delayed(const Duration(seconds: 4));
      //   Get.back();
      // }
    }
  }

  Future<void> deleteOnTap() async {
    final status = await EnquiryLogic.deleteEnquiry(reqModel);
    // if (status) {
    //   // await Future.delayed(const Duration(seconds: 4));
    //   Get.back();
    // }
  }

  Future<void> updateOnTap() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      final status = await EnquiryLogic.saveEnquiry(reqModel, isUpdate: true);
      // if (status) {
      //   // await Future.delayed(const Duration(seconds: 4));
      //   Get.back();
      // }
    }
  }
}

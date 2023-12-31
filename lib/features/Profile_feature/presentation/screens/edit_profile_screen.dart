import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/Validators/validators.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/Helpers/shared_texts.dart';
import '../../../../core/location_feature/presentation/area_pop_up.dart';
import '../../../../core/location_feature/presentation/city_pop_up.dart';
import '../../../../core/location_feature/presentation/logic/pick_location_cubit.dart';
import '../../../../core/presentation/Routes/route_names.dart';
import '../../../../core/presentation/Widgets/common_app_bar_widget.dart';
import '../../../../core/presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../../core/presentation/Widgets/common_cached_image_widget.dart';
import '../../../../core/presentation/Widgets/common_file_image_widget.dart';
import '../../../../core/presentation/Widgets/common_global_button.dart';
import '../../../../core/presentation/Widgets/common_text_form_field_widget.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';
import '../../../../core/presentation/Widgets/custom_snack_bar.dart';
import '../../../../core/presentation/Widgets/take_photo_widget.dart';
import '../../../../core/presentation/screen/main_app_page.dart';
import '../../../Home_feature/presentation/logic/Bottom_Nav_Cubit/bottom_nav_cubit.dart';
import '../logic/Profile_Cubit/profile_cubit.dart';
import '../logic/Profile_Cubit/profile_states.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController userFirstNameController;
  late TextEditingController userLastNameController;
  late TextEditingController userAddressController;
  late TextEditingController userCityController;
  late TextEditingController userAreaController;
  late TextEditingController emailAddressController;

  late TextEditingController phoneNumberController;
  late ProfileCubit _profileCubit;
  final formKey = GlobalKey<FormState>();
  late PickLocationCubit _locationCubit;

  @override
  void initState() {
    super.initState();
    _locationCubit = BlocProvider.of<PickLocationCubit>(context);
    _locationCubit.getCityData(limit: 50);
    _locationCubit.getAreaData(cityID:SharedText.currentUser!.locationModel!.cityModel!.id! ,);
    _locationCubit.clearAllData();
    userFirstNameController = TextEditingController(
        text: SharedText.currentUser!.name!.split(" ").first);
    userLastNameController = TextEditingController(
        text: SharedText.currentUser!.name!.split(" ").last);
    emailAddressController = TextEditingController(text: SharedText.currentUser!.email!);
    phoneNumberController = TextEditingController(text: SharedText.currentUser!.phone!);
    userAddressController = TextEditingController(
        text: SharedText.currentUser!.locationModel!.streetName!);
    userCityController = TextEditingController(
        text: SharedText.currentUser!.locationModel!.cityModel!.name);
    userAreaController = TextEditingController(
        text: SharedText.currentUser!.locationModel!.areaModel!.name);
    _profileCubit = BlocProvider.of<ProfileCubit>(context);
    _profileCubit.setNewCitySelected(SharedText.currentUser!.locationModel!.cityModel!);
    _profileCubit.setSelectedArea(SharedText.currentUser!.locationModel!.areaModel!);
    _profileCubit.deleteImage = false;
    _profileCubit.imageXFile = null;
    _profileCubit.isDataFound = false;
    _profileCubit.controllerList.clear();
    _profileCubit.controllerList.add(userFirstNameController);
    _profileCubit.controllerList.add(userLastNameController);
    _profileCubit.controllerList.add(emailAddressController);
    _profileCubit.controllerList.add(phoneNumberController);
    _profileCubit.controllerList.add(userAddressController);
    _profileCubit.controllerList.add(userCityController);
    _profileCubit.controllerList.add(userAreaController);
    _profileCubit.isDataFount(_profileCubit.controllerList);
  }

  @override
  void dispose() {
    userFirstNameController.dispose();
    userLastNameController.dispose();
    emailAddressController.dispose();
    phoneNumberController.dispose();
    userAddressController.dispose();
    userCityController.dispose();
    userAreaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.lightWhiteColor,
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<ProfileCubit, ProfileCubitStates>(
        listener: (profileCtx, profileState) {
          if (profileState is ProfileUpdateFailedState) {
            showSnackBar(
              context: profileCtx,
              title: profileState.error.errorMassage!,
            );
          } else if (profileState is ProfileUpdateSuccessState) {
            showSnackBar(
                context: profileCtx,
                title: AppLocalizations.of(context)!.lblProfileUpdateSuccess,
                color: AppConstants.lightOffBlueColor);
            Navigator.pushNamedAndRemoveUntil(
              context,
              RouteNames.mainBottomNavPageRoute,
              (route) => false,
            );
            BlocProvider.of<BottomNavCubit>(context).selectItem(0);
          }
        },
        builder: (profileCtx, profileState) {
          return InkWell(
            hoverColor: AppConstants.transparent,
            focusColor: AppConstants.transparent,
            splashColor: AppConstants.transparent,
            highlightColor: AppConstants.transparent,
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: MainAppPage(
              screenContent: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CommonAppBar(
                    withBack: true,
                    appBarBackGroundColor: AppConstants.transparent,
                    showBottomIcon: false,
                    centerTitle: false,
                    titleWidget: CommonTitleText(
                      textKey: AppLocalizations.of(context)!.lblEditProfile,
                      textColor: AppConstants.lightBlackColor,
                      textWeight: FontWeight.w400,
                      textFontSize: AppConstants.normalFontSize,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ListView(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            children: [
                              Form(
                                key: formKey,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: AppConstants.pagePadding),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ///Image
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 20.0),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Stack(children: [
                                                profileCtx
                                                        .read<ProfileCubit>()
                                                        .deleteImage
                                                    ? InkWell(
                                                        onTap: () {
                                                          takePhotoBottomSheet(
                                                              context:
                                                                  profileCtx,
                                                              getPhoto: profileCtx
                                                                  .read<
                                                                      ProfileCubit>()
                                                                  .photoPicked);
                                                        },
                                                        child: Align(
                                                          alignment: Alignment
                                                              .bottomCenter,
                                                          child: Container(
                                                            width:
                                                                getWidgetHeight(
                                                                    90),
                                                            height:
                                                                getWidgetHeight(
                                                                    90),
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: AppConstants
                                                                    .backGroundColor,
                                                                border: Border.all(
                                                                    color: AppConstants
                                                                        .lightWhiteColor,
                                                                    width: 2)),
                                                            child:
                                                                const Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          18.0),
                                                              child: CommonAssetSvgImageWidget(
                                                                  imageString:
                                                                      "camera.svg",
                                                                  height: 32,
                                                                  width: 32,
                                                                  fit: BoxFit
                                                                      .contain,
                                                                  imageColor:
                                                                      AppConstants
                                                                          .mainColor),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : Align(
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        child: Container(
                                                          width:
                                                              getWidgetHeight(
                                                                  98),
                                                          height:
                                                              getWidgetHeight(
                                                                  98),
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            border: Border.all(
                                                                color: AppConstants
                                                                    .lightWhiteColor,
                                                                width: 5),
                                                          ),

                                                          ///user profile image
                                                          child: Stack(
                                                            fit:
                                                                StackFit.expand,
                                                            children: [
                                                              profileCtx
                                                                          .read<
                                                                              ProfileCubit>()
                                                                          .imageXFile !=
                                                                      null
                                                                  ? commonFileImageWidget(
                                                                      imageString: profileCtx
                                                                          .read<
                                                                              ProfileCubit>()
                                                                          .imageXFile!
                                                                          .path,
                                                                      height:
                                                                          (98),
                                                                      width:
                                                                          (98),
                                                                      fit: BoxFit
                                                                          .fill,
                                                                      radius:
                                                                          1000,
                                                                    )
                                                                  : commonCachedImageWidget(
                                                                      SharedText
                                                                          .currentUser!
                                                                          .image!,
                                                                      height:
                                                                          (98),
                                                                      width:
                                                                          (98),
                                                                      radius:
                                                                          1000,
                                                                      isCircular:
                                                                          true,
                                                                      isProfile:
                                                                          true),
                                                              Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .bottomRight,
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      profileCtx
                                                                          .read<
                                                                              ProfileCubit>()
                                                                          .deleteImageFunc(
                                                                              true);
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          getWidgetHeight(
                                                                              24),
                                                                      width:
                                                                          getWidgetWidth(
                                                                              24),
                                                                      decoration: const BoxDecoration(
                                                                          color: AppConstants
                                                                              .mainColor,
                                                                          shape:
                                                                              BoxShape.circle),
                                                                      child:
                                                                          const Padding(
                                                                        padding:
                                                                            EdgeInsets.all(5.0),
                                                                        child: CommonAssetSvgImageWidget(
                                                                            imageString:
                                                                                "bin_icon.svg",
                                                                            height:
                                                                                12,
                                                                            imageColor:
                                                                                AppConstants.lightWhiteColor,
                                                                            width: 12),
                                                                      ),
                                                                    ),
                                                                  )),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                              ]),
                                            ]),
                                      ),
                                      getSpaceHeight(28),

                                      /// User Name
                                      Row(
                                        children: [
                                          ///First name
                                          Expanded(
                                            child: CommonTextFormField(
                                              controller:
                                                  userFirstNameController,
                                              hintKey: AppLocalizations.of(
                                                      profileCtx)!
                                                  .lblFirstName,
                                              keyboardType: TextInputType.text,
                                              labelHintColor:
                                                  AppConstants.mainColor,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return AppLocalizations.of(
                                                          profileCtx)!
                                                      .lblNameIsEmpty;
                                                } else if (nameValidator(
                                                    value)) {
                                                  return AppLocalizations.of(
                                                          profileCtx)!
                                                      .lblNameBadFormat;
                                                } else if (value.length < 2) {
                                                  return AppLocalizations.of(
                                                          profileCtx)!
                                                      .lblNameLength;
                                                } else {
                                                  return null;
                                                }
                                              },
                                              onChanged: (value) {
                                                _profileCubit.isDataFount(
                                                    _profileCubit
                                                        .controllerList);
                                                return null;
                                              },
                                            ),
                                          ),

                                          ///Spacer
                                          getSpaceWidth(
                                              AppConstants.smallPadding),

                                          ///last name
                                          Expanded(
                                            child: CommonTextFormField(
                                              controller:
                                                  userLastNameController,
                                              hintKey: AppLocalizations.of(
                                                      profileCtx)!
                                                  .lblLastName,
                                              keyboardType: TextInputType.text,
                                              labelHintColor:
                                                  AppConstants.mainColor,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return AppLocalizations.of(
                                                          profileCtx)!
                                                      .lblNameIsEmpty;
                                                } else if (nameValidator(
                                                    value)) {
                                                  return AppLocalizations.of(
                                                          profileCtx)!
                                                      .lblNameBadFormat;
                                                } else if (value.length < 2) {
                                                  return AppLocalizations.of(
                                                          profileCtx)!
                                                      .lblNameLength;
                                                } else {
                                                  return null;
                                                }
                                              },
                                              onChanged: (value) {
                                                _profileCubit.isDataFount(
                                                    _profileCubit
                                                        .controllerList);
                                                return null;
                                              },
                                            ),
                                          ),
                                        ],
                                      ),

                                      ///Spacer
                                      getSpaceHeight(AppConstants.smallPadding),

                                      /// Email
                                      CommonTextFormField(
                                        controller: emailAddressController,
                                        hintKey:
                                            AppLocalizations.of(profileCtx)!
                                                .lblEmail,
                                        keyboardType: TextInputType.text,
                                        labelHintColor: AppConstants.mainColor,
                                        validator: (value) {
                                          if (value!.isNotEmpty) {
                                            if (!validateEmail(value)) {
                                              return AppLocalizations.of(
                                                      profileCtx)!
                                                  .lblEmailBadFormat;
                                            } else {
                                              return null;
                                            }
                                          } else {
                                            return null;
                                          }
                                        },
                                        onChanged: (value) {
                                          _profileCubit.isDataFount(
                                              _profileCubit.controllerList);
                                          return null;
                                        },
                                      ),

                                      ///spacer
                                      getSpaceHeight(AppConstants.smallPadding),

                                      /// Phone
                                      CommonTextFormField(
                                        controller: phoneNumberController,
                                        hintKey:
                                            AppLocalizations.of(profileCtx)!
                                                .lblPhone,
                                        keyboardType: TextInputType.phone,
                                        labelHintColor: AppConstants.mainColor,
                                        inputFormatter: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return AppLocalizations.of(
                                                    profileCtx)!
                                                .lblPhoneIsEmpty;
                                          } else if (value.length <
                                              AppConstants.phoneLength) {
                                            return AppLocalizations.of(
                                                    profileCtx)!
                                                .lblPhoneValidate;
                                          } else {
                                            return null;
                                          }
                                        },
                                        onChanged: (value) {
                                          _profileCubit.isDataFount(
                                              _profileCubit.controllerList);
                                          return null;
                                        },
                                      ),

                                      ///spacer
                                      getSpaceHeight(AppConstants.smallPadding),

                                      ///address
                                      CommonTextFormField(
                                        fieldHeight: 64,
                                        minLines: 4,
                                        maxLines: 20,
                                        controller: userAddressController,
                                        hintKey:
                                            AppLocalizations.of(profileCtx)!
                                                .lblAddressDetails,
                                        labelText:
                                            AppLocalizations.of(profileCtx)!
                                                .lblName,
                                        keyboardType: TextInputType.text,
                                        labelHintColor: AppConstants.mainColor,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return AppLocalizations.of(
                                                    profileCtx)!
                                                .lblNameIsEmpty;
                                          } else {
                                            return null;
                                          }
                                        },
                                        onChanged: (value) {
                                          _profileCubit.isDataFount(
                                              _profileCubit.controllerList);
                                          return null;
                                        },
                                      ),

                                      ///spacer
                                      getSpaceHeight(AppConstants.smallPadding),

                                      ///area and city
                                      Row(
                                        children: [
                                          ///City
                                          Expanded(
                                            child: CommonTextFormField(
                                              onTap: () {
                                                showCityPopUp(
                                                    context: profileCtx,
                                                    preSelectedCity: _profileCubit.selectedCity??SharedText.currentUser!.locationModel!.cityModel! ,
                                                    title: AppLocalizations.of(
                                                        profileCtx)!
                                                        .lblCity,
                                                    onApply: (model) {
                                                      userCityController.text = model.name!;
                                                      _profileCubit.setNewCitySelected(model);
                                                      _locationCubit.getAreaData(cityID: model.id!,limit: 50);
                                                      userAreaController.clear();
                                                      _profileCubit.isDataFount(
                                                          _profileCubit
                                                              .controllerList);
                                                    });
                                              },
                                              controller: userCityController,
                                              hintKey:
                                              AppLocalizations.of(profileCtx)!
                                                  .lblCity,
                                              isReadOnly: true,
                                              keyboardType: TextInputType.text,
                                              labelHintColor:
                                                  AppConstants.mainColor,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return AppLocalizations.of(
                                                      profileCtx)!
                                                      .lblNameIsEmpty;
                                                } else {
                                                  return null;
                                                }
                                              },
                                              onChanged: (value) {
                                                _profileCubit.isDataFount(
                                                    _profileCubit
                                                        .controllerList);
                                                return null;
                                              },
                                            ),
                                          ),

                                          ///Spacer
                                          getSpaceWidth(
                                              AppConstants.smallPadding),

                                          ///Area
                                          Expanded(
                                            child: CommonTextFormField(
                                              controller: userAreaController,
                                              onTap: () {
                                                showAreaPopUp(
                                                    context: profileCtx,
                                                    preSelectedCity:_profileCubit.selectedArea,

                                                    title: AppLocalizations.of(
                                                        profileCtx)!
                                                        .lblArea,
                                                    onApply: (model) {
                                                      userAreaController.text =
                                                      model.name!;
                                                      _profileCubit
                                                          .setSelectedArea(model);
                                                      _profileCubit.isDataFount(
                                                          _profileCubit
                                                              .controllerList);

                                                    });
                                              },
                                              hintKey:
                                              AppLocalizations.of(profileCtx)!
                                                  .lblArea,
                                              keyboardType: TextInputType.text,
                                              isReadOnly: true,
                                              labelHintColor:
                                                  AppConstants.mainColor,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return AppLocalizations.of(
                                                      profileCtx)!
                                                      .lblNameIsEmpty;
                                                } else {
                                                  return null;
                                                }
                                              },
                                              onChanged: (value) {
                                                _profileCubit.isDataFount(
                                                    _profileCubit
                                                        .controllerList);
                                                return null;
                                              },
                                            ),
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                              getSpaceHeight(AppConstants.pagePadding * 9),
                              Center(
                                child: CommonGlobalButton(
                                  buttonText:
                                      AppLocalizations.of(context)!.lblSave,
                                  onPressedFunction: () {
                                    if (formKey.currentState!.validate()) {
                                      profileCtx
                                          .read<ProfileCubit>()
                                          .updateUserProfile(
                                              emailAddress: emailAddressController
                                                  .text,
                                              phoneNumber:
                                                  phoneNumberController.text,
                                              userFirstName:
                                                  userFirstNameController.text,
                                              userLastName:
                                                  userLastNameController.text,
                                              userCity: _profileCubit.selectedCity!.id.toString(),
                                              userArea:_profileCubit.selectedArea!.id.toString(),
                                              userAddressDetails:
                                                  userAddressController.text,
                                              locationId: SharedText.currentUser!.locationModel!.id!.toString(),
                                              image: profileCtx
                                                  .read<ProfileCubit>()
                                                  .imageXFile);
                                    }
                                  },
                                  height: 48,
                                  elevation: 0,
                                  showBorder: false,
                                  isEnable: _profileCubit.isDataFound,
                                  isLoading:
                                      profileState is ProfileUpdateLoadingState,
                                  buttonBackgroundColor: AppConstants.mainColor,
                                  buttonTextSize: AppConstants.largeFontSize,
                                  buttonTextFontWeight: FontWeight.w400,
                                  buttonTextColor: AppConstants.lightWhiteColor,
                                ),
                              ),

                              ///Spacer
                              getSpaceHeight(50),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

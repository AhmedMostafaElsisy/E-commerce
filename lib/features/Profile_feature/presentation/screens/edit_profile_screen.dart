import 'package:captien_omda_customer/features/Profile_feature/presentation/screens/profile_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../Presentation/Routes/route_names.dart';
import '../../../../Presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../../Presentation/Widgets/common_cached_image_widget.dart';
import '../../../../Presentation/Widgets/common_file_image_widget.dart';
import '../../../../Presentation/Widgets/common_global_button.dart';
import '../../../../Presentation/Widgets/common_text_form_field_widget.dart';
import '../../../../Presentation/Widgets/custom_snack_bar.dart';
import '../../../../Presentation/Widgets/take_photo_widget.dart';
import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/Validators/validators.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/Helpers/shared_texts.dart';
import '../../../Home_feature/presentation/logic/Bottom_Nav_Cubit/bottom_nav_cubit.dart';
import '../logic/Profile_Cubit/profile_cubit.dart';
import '../logic/Profile_Cubit/profile_states.dart';
import 'common_profile_header_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController userNameController;
  late TextEditingController phoneController;
  late ProfileCubit _profileCubit;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController();
    phoneController = TextEditingController();
    _profileCubit = BlocProvider.of<ProfileCubit>(context);
    _profileCubit.deleteImage = false;
    _profileCubit.imageXFile = null;
    userNameController.text = SharedText.currentUser!.name!;
    phoneController.text = SharedText.currentUser!.phone!;
  }

  @override
  void dispose() {
    userNameController.dispose();
    phoneController.dispose();
    // _profileCubit.deleteImagePicked();
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
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  ///profile background
                  Container(
                    width: getWidgetWidth(550),
                    height: getWidgetHeight(190),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(
                              AppConstants.bottomSheetBorderRadius),
                          bottomLeft: Radius.circular(
                              AppConstants.bottomSheetBorderRadius)),
                    ),
                    child: Stack(children: [

                      ///profile background
                      const ProfileHeaderWidget(),

                      ///back arrow
                      Positioned(
                          top: getWidgetHeight(50),
                          left: getWidgetWidth(16),
                          child: CommonProfileHeaderWidget(
                            imagePath: "back_arrow_icon.svg",
                            imageHeight: 20,
                            imageWidth: 20,
                            imageColor: AppConstants.lightBlackColor,
                            onClick: () {
                              Navigator.pop(context);
                            },
                          )),
                      getSpaceHeight(20),

                      ///Image
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(children: [
                                profileCtx
                                    .read<ProfileCubit>()
                                    .deleteImage
                                    ? InkWell(
                                  onTap: () {
                                    takePhotoBottomSheet(
                                        context: profileCtx,
                                        getPhoto: profileCtx
                                            .read<ProfileCubit>()
                                            .photoPicked);
                                  },
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      width: getWidgetHeight(90),
                                      height: getWidgetHeight(90),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                        AppConstants.backGroundColor,
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(18.0),
                                        child: commonAssetSvgImageWidget(
                                            imageString: "camera.svg",
                                            height: 32,
                                            width: 32,
                                            fit: BoxFit.contain,
                                            imageColor:
                                            AppConstants.mainColor),
                                      ),
                                    ),
                                  ),
                                )
                                    : Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    width: getWidgetHeight(98),
                                    height: getWidgetHeight(98),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: AppConstants
                                              .lightWhiteColor,
                                          width: 5),
                                    ),

                                    ///user profile image
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        profileCtx
                                            .read<ProfileCubit>()
                                            .imageXFile !=
                                            null
                                            ? commonFileImageWidget(
                                          imageString: profileCtx
                                              .read<ProfileCubit>()
                                              .imageXFile!
                                              .path,
                                          height: (98),
                                          width: (98),
                                          fit: BoxFit.fill,
                                          radius: 1000,
                                        )
                                            : commonCachedImageWidget(
                                            context,
                                            SharedText
                                                .currentUser!.image!,
                                            height: (98),
                                            width: (98),
                                            radius: 1000,
                                            isCircular: true,
                                            isProfile: true),
                                        Align(
                                            alignment:
                                            Alignment.bottomRight,
                                            child: InkWell(
                                              onTap: () {
                                                profileCtx
                                                    .read<ProfileCubit>()
                                                    .deleteImageFunc(
                                                    true);
                                              },
                                              child: Container(
                                                height:
                                                getWidgetHeight(24),
                                                width: getWidgetWidth(24),
                                                decoration:
                                                const BoxDecoration(
                                                    color: AppConstants
                                                        .mainColor,
                                                    shape: BoxShape
                                                        .circle),
                                                child: const Padding(
                                                  padding:
                                                  EdgeInsets.all(5.0),
                                                  child: commonAssetSvgImageWidget(
                                                      imageString:
                                                      "bin_icon.svg",
                                                      height: 12,
                                                      imageColor: AppConstants
                                                          .lightWhiteColor,
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
                    ]),
                  ),
                  getSpaceHeight(46),

                  /// name
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CommonTextFormField(
                      labelText: AppLocalizations.of(context)!.lblName,
                      controller: userNameController,
                      radius: AppConstants.smallBorderRadius,
                      hintKey: AppLocalizations.of(context)!.lblEnterName,
                      keyboardType: TextInputType.name,
                      labelHintStyle: AppConstants.mainTextColor,
                      withSuffixIcon: true,
                      suffixIcon: const Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                        child: commonAssetSvgImageWidget(
                            imageString: "person_icon.svg",
                            fit: BoxFit.fill,
                            height: 16,
                            width: 16),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppLocalizations.of(context)!.lblNameIsEmpty;
                        } else if (nameValidator(value)) {
                          return AppLocalizations.of(context)!.lblNameBadFormat;
                        } else if (value.length < 2) {
                          return AppLocalizations.of(context)!.lblNameLength;
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        setState(() {});
                        return null;
                      },
                    ),
                  ),

                  ///Spacer
                  getSpaceHeight(AppConstants.pagePadding),

                  /// phone
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CommonTextFormField(
                      controller: phoneController,
                      radius: AppConstants.smallBorderRadius,
                      labelText: AppLocalizations.of(context)!.lblPhone,
                      hintKey:
                      AppLocalizations.of(context)!.lblEnterPhoneNumber,
                      keyboardType: TextInputType.phone,
                      labelHintStyle: AppConstants.mainTextColor,
                      inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                      withSuffixIcon: true,
                      suffixIcon: const Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 13, horizontal: 15),
                        child: commonAssetSvgImageWidget(
                            imageString: "phone_icon.svg",
                            fit: BoxFit.fill,
                            height: 16,
                            width: 16),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppLocalizations.of(context)!.lblPhoneIsEmpty;
                        } else if (value.length != AppConstants.phoneLength) {
                          return AppLocalizations.of(context)!.lblPhoneValidate;
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        setState(() {});
                        return null;
                      },
                    ),
                  ),

                  getSpaceHeight(120),
                  CommonGlobalButton(
                    buttonText: AppLocalizations.of(context)!.lblSave,
                    onPressedFunction: () {
                      if (formKey.currentState!.validate()) {
                        profileCtx.read<ProfileCubit>().updateUserProfile(
                            name: userNameController.text,
                            phone: phoneController.text ==
                                SharedText.currentUser!.phone! ? null :phoneController.text,
                            image: profileCtx
                                .read<ProfileCubit>()
                                .imageXFile);
                      }
                    },
                    height: 48,
                    elevation: 0,
                    showBorder: false,
                    isEnable: userNameController.text.isNotEmpty &&
                        phoneController.text.isNotEmpty,
                    isLoading: profileState is ProfileUpdateLoadingState,
                    buttonBackgroundColor: AppConstants.mainColor,
                    buttonTextSize: AppConstants.largeFontSize,
                    buttonTextFontWeight: FontWeight.w400,
                    buttonTextColor: AppConstants.lightWhiteColor,
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

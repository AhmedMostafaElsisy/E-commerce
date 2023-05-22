import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/Helpers/shared_texts.dart';
import '../../../../core/presentation/Widgets/common_app_bar_widget.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';
import 'chat_list_screen.dart';

class MassageListScreen extends StatefulWidget {
  const MassageListScreen({Key? key}) : super(key: key);

  @override
  State<MassageListScreen> createState() => _MassageListScreenState();
}

class _MassageListScreenState extends State<MassageListScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.lightWhiteColor,
      appBar: CommonAppBar(
        titleWidget: CommonTitleText(
          textKey: AppLocalizations.of(context)!.lblMassages,
          textColor: AppConstants.lightBlackColor,
          textWeight: FontWeight.w400,
          textFontSize: AppConstants.normalFontSize,
        ),
        withNotification: true,
        showBottomIcon: false,
        withBack: false,
        showLeadingWidget: true,
        // leadingWidget: PopupMenuButton<void Function()>(
        //   padding: EdgeInsets.zero,
        //   offset: const Offset(0, 50),
        //   shape: const RoundedRectangleBorder(
        //     borderRadius: BorderRadius.all(
        //       Radius.circular(10.0),
        //     ),
        //   ),
        //   itemBuilder: (context) {
        //     // return [
        //     //   PopupMenuItem(
        //     //     height: getWidgetHeight(50),
        //     //     padding:
        //     //         EdgeInsets.all(getWidgetHeight(AppConstants.xSmallPadding)),
        //     //     textStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
        //     //           color: AppConstants.mainColor,
        //     //           fontSize: AppConstants.smallFontSize,
        //     //           fontWeight: FontWeight.w700,
        //     //         ),
        //     //     value: () => Navigator.pushNamed(
        //     //         context, RouteNames.chatArchivePageRoute),
        //     //     child: Row(
        //     //       mainAxisAlignment: MainAxisAlignment.center,
        //     //       children: [
        //     //         const CommonAssetSvgImageWidget(
        //     //             imageString: "block_list_icon.svg",
        //     //             imageColor: AppConstants.mainColor,height: 40, width: 40,),
        //     //         getSpaceWidth(8),
        //     //         Text(AppLocalizations.of(context)!.lblArchiveList),
        //     //       ],
        //     //     ),
        //     //   ),
        //     // ];
        //   },
        //   onSelected: (fn) => fn(),
        //   child: const CommonAssetSvgImageWidget(
        //       imageString: "select_dots.svg",
        //       imageColor: AppConstants.mainColor, height: 40, width: 40,),
        // ),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getWidgetWidth(AppConstants.pagePadding)),
          child: Column(children: [
            ///Spacer
            getSpaceHeight(16),
            SizedBox(
              height: SharedText.screenHeight / 0.9,
              child: ChatListScreen(),
            ),
          ]),
        ),
      ),
    );
  }
}

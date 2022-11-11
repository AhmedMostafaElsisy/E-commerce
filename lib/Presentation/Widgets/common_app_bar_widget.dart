import 'package:default_repo_app/Presentation/Widgets/common_asset_svg_image_widget.dart';
import 'package:flutter/material.dart';
import '../../Constants/app_constants.dart';
import '../../Helpers/shared.dart';
import '../Routes/route_names.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool withBack;
  final bool showLeadingWidget;
  final bool withNotification;
  final bool centerTitle;
  final bool showBottomIcon;
  final Widget? customActionWidget;
  final Widget? titleWidget;
  final Widget? leadingWidget;
  final String? sourcePage;
  final double elevation;
  final double? leadingWidth;

  const CommonAppBar(
      {Key? key,
        this.withBack = true,
        this.showLeadingWidget = false,
        this.titleWidget,
        this.withNotification = false,
        this.centerTitle = true,
        this.sourcePage = '',
        this.showBottomIcon = true,
        this.leadingWidget,
        this.elevation = 1,
        this.leadingWidth,
        this.customActionWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.white,
        elevation: elevation,
        centerTitle: centerTitle,
        automaticallyImplyLeading: withBack,
        titleSpacing: 0,
        leadingWidth: leadingWidth,
        leading: showBottomIcon == false
            ? withBack
            ? FittedBox(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 16),
              InkWell(
                onTap: () => Navigator.pop(context),
                child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 22),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                      color: AppConstants.arrowIconColor,
                    )),
              ),
            ],
          ),
        )
            : showLeadingWidget
            ? Row(
          children: [
            getSpaceWidth(16),

            ///User profile image
            ///Todo: add user profile
            leadingWidget ?? const SizedBox()
          ],
        )
            : const SizedBox()
            : const SizedBox(),
        title: titleWidget,
        actions: [
          if (withNotification)
            InkWell(
              onTap: () {
                ///Todo: add navigation for notification page
                Navigator.pushNamed(
                    context, RouteNames.notificationPageRoute);
              },
              child: commonAssetSvgImageWidget(
                imageString: 'notification_icon.svg',
                height: 24,
                width: 24,
              ),
            ),
          customActionWidget ?? const SizedBox(),
          const SizedBox(width: 16),
        ]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  Size get bottomSize => const Size.fromHeight(kToolbarHeight + 14);

  Size get emptyBottomSize => const Size.fromHeight(0);
}

import 'package:flutter/material.dart';
import '../../core/Helpers/shared.dart';
import '../../core/Helpers/shared_texts.dart';
import '../Routes/route_names.dart';
import 'common_asset_svg_image_widget.dart';

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
      this.elevation = 0,
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
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 22),
                              child: RotatedBox(
                                quarterTurns:
                                    SharedText.currentLocale == "ar" ? 2 : 0,
                                child: const commonAssetSvgImageWidget(
                                    imageString: "back_arrow_icon.svg",
                                    height: 40,
                                    width: 40),
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
                Navigator.pushNamed(context, RouteNames.notificationPageRoute);
              },
              child: const Padding(
                padding:
                EdgeInsets.symmetric(horizontal: 16),
                child: commonAssetSvgImageWidget(
                  imageString: 'notification_icon.svg',
                  height: 25,
                  width: 25,
                  fit: BoxFit.cover
                ),
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

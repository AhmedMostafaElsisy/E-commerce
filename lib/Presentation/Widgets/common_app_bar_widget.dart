import 'package:flutter/material.dart';
import '../../Constants/app_constants.dart';
import 'common_asset_image_widget.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool withBack;
  final bool withLogo;
  final bool centerTitle;
  final Widget? titleWidget;
  final String? sourcePage;

  const CommonAppBar({
    Key? key,
    this.withBack = true,
    this.titleWidget = const SizedBox(),
    this.withLogo = true,
    this.centerTitle = true,
    this.sourcePage = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      centerTitle: centerTitle,
      automaticallyImplyLeading: withBack,

      /// arrow icon to back for previous screen
      /// also this widget is rotate in ar
      leading: withBack
          ? FittedBox(
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () =>  Navigator.pop(context),
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
          : const SizedBox(),
      title: titleWidget,
      actions: [
        if (withLogo)
          commonAssetImageWidget(
            imageString: 'logo_without_tx.png',
            height: 30,
            width: 40,
          ),
        const SizedBox(width: 20),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

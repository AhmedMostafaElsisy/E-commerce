import 'package:flutter/material.dart';

class CustomToast {
  static void show(String msg, BuildContext context) {
    Color textColor = Colors.white;
    Color backgroundColor = Colors.blueAccent;
    dismiss();
    CustomToast._createView(msg, context, backgroundColor, textColor);
  }

  static OverlayEntry? _overlayEntry;
  static bool isVisible = false;

  static void _createView(
    String msg,
    BuildContext context,
    Color background,
    Color textColor,
  ) async {
    var overlayState = Overlay.of(context);

    final themeData = Theme.of(context);

    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => _ToastAnimatedWidget(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: Container(
              decoration: BoxDecoration(
                color: background,
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
              child: Text(
                msg,
                softWrap: true,
                style: themeData.textTheme.bodyText1!.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
    isVisible = true;
    overlayState!.insert(_overlayEntry!);
  }

  static dismiss() async {
    if (!isVisible) {
      return;
    }
    isVisible = false;
    _overlayEntry!.remove();
  }
}

class _ToastAnimatedWidget extends StatefulWidget {
  const _ToastAnimatedWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _ToastWidgetState createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastAnimatedWidget>
    with SingleTickerProviderStateMixin {
  bool get _isVisible => true; //update this value later

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 50,
        child: AnimatedOpacity(
          duration: const Duration(seconds: 2),
          opacity: _isVisible ? 1.0 : 0.0,
          child: widget.child,
        ));
  }
}

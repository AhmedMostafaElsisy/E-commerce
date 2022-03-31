import 'package:flutter/material.dart';

class RestartWidget extends StatefulWidget {
  final Widget child;

  const RestartWidget({Key? key, required this.child}) : super(key: key);

  static void restartApp(BuildContext context) {
    var ctx1 = context.findAncestorStateOfType<_RestartWidgetState>();
    if (ctx1 != null) ctx1.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();

      debugPrint('Restarted!');
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}

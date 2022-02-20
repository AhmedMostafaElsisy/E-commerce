import 'package:flutter/material.dart';

import 'demo_localizations.dart';

String? getTranslated(BuildContext context, String key) {
  return DemoLocalization.of(context)!.getTranslatedValue(key);
}
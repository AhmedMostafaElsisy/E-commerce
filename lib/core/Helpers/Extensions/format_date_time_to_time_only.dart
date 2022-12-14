import 'package:intl/intl.dart';

import '../shared_texts.dart';

extension FormatDateTimeToFullFormat on DateTime {
  String formatDateTimeToFullFormat() {
    DateFormat dt = DateFormat('EE dd MMM HH:mm ', SharedText.currentLocale);

    return dt.format(this);
  }

  String formatDateTimeToBeUserFriendly() {
    DateFormat dt = DateFormat('dd/MM/yyyy', SharedText.currentLocale);

    return dt.format(this);
  }

  String formatDateTimeToShowDayName() {
    DateFormat dt = DateFormat('EE dd MMM', SharedText.currentLocale);

    return dt.format(this);
  }
}

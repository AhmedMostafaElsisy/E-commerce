import 'package:intl/intl.dart';

import '../Helpers/shared_texts.dart';

extension FormatDateTimeToFullFormat on DateTime {
  String formatDateTimeToFullFormat() {
    DateFormat dt = DateFormat('dd / MM /yyyy', SharedText.currentLocale);

    return dt.format(this);
  }

  String formatDateTimeToUpdateFormat() {
    DateFormat dt = DateFormat('yyyy-MM-dd');

    return dt.format(this);
  }

  String formatDateTimeToBeUserFriendly() {
    DateFormat dt = DateFormat('dd MMM yy', SharedText.currentLocale);

    return dt.format(this);
  }

  String formatDateTimeToItemDate() {
    DateFormat dt = DateFormat('dd/MM/yyyy', SharedText.currentLocale);

    return dt.format(this);
  }

  String formatDateTimeToShowDayName() {
    DateFormat dt = DateFormat('dd MMM', SharedText.currentLocale);

    return dt.format(this);
  }

  String formatDateTimeToChat() {
    String dateFormat = "";
    DateFormat shortTime = DateFormat('hh:mm a', SharedText.currentLocale);
    DateFormat longTime =
        DateFormat('dd / MM /yyyy ', SharedText.currentLocale);
    if (longTime.format(this) == longTime.format(DateTime.now())) {
      dateFormat = shortTime.format(this);
    } else {
      dateFormat = longTime.format(this);
    }

    return dateFormat;
  }
}

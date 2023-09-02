extension GetStringWithoutSpacings on String {
  String getStringWithoutSpacings() {
    String firstName = split(" ").first;
    if (firstName.length > 12) {
      firstName = firstName.substring(0, 10);
      return firstName[0].toUpperCase() + firstName.substring(1);
    } else {
      return firstName[0].toUpperCase() + firstName.substring(1);
    }
  }

  String hidePhoneNumberData() {
    return "${substring(0, 4)}xxxxxxx${substring(length - 1)}";
  }

  String hideEmail() {
    int emailIndex=indexOf("@");

    return "${substring(0, 2)}xxxxxxx${substring(emailIndex)}";
  }
}

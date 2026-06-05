class CountryCodes {
  CountryCodes._();

  static const defaultDialCode = '+91';

  static int minPhoneLengthFor(String dialCode) {
    return switch (dialCode) {
      '+91' => 10,
      _ => 6,
    };
  }

  static int maxPhoneLengthFor(String dialCode) {
    return switch (dialCode) {
      '+91' => 10,
      '+971' => 9,
      '+61' => 9,
      '+1' => 10,
      '+44' => 10,
      _ => 15,
    };
  }
}

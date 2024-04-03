import 'package:intl/intl.dart';

class NumbersFormats {
  static String formatNumber(double number) {
    final formatterNumber =
        NumberFormat.compactCurrency(decimalDigits: 0, locale: 'en', symbol: '')
            .format(number);
    return formatterNumber;
  }
}

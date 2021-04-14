
import 'package:intl/intl.dart';

extension Currency on double {
  String get toCurrency {
    final formatCurrency = new NumberFormat.simpleCurrency();
    return '${formatCurrency.format(this)}';
  }
}
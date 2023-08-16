// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:intl/intl.dart';

class DateFormatUtils {
  static const ddMMYYYYString = 'dd/M/yyyy';
  static const ddMMYYYYStringWithUnderStore = 'dd-M-yyyy';
  static const ddMMMString = 'dd MMM';
  static const MMMString = 'MMMM';
  static const yyyyMMDDHHMMSSString = 'yyyy-MM-dd hh:mm:ss';
  static const yyyyMMDDKKMMSSString = 'yyyy-MM-dd kk:mm:ss';
  static const yyyyMMDDString = 'yyyy-MM-dd';
  static const ddMMMYYYYString = 'dd MMM yyyy';
  static const ddMMYYYYString2 = 'dd-MM-yyyy';
  static const eeeeString = 'EEEE';

  static String MMMFormat(DateTime date) => DateFormat(MMMString).format(date);
  static String ddMMYYYYFormat(String date) =>
      DateFormat(ddMMYYYYString).parse(date).toString();

  static String ddMMYYYY2Format(DateTime date) =>
      DateFormat(ddMMYYYYString2).format(date).toString();

  static String ddMMMYYYYFormat(DateTime date) =>
      DateFormat(ddMMMYYYYString).format(date).toString();

  static String ddMMMFormat(String date) =>
      DateFormat(ddMMMString).parse(date).toString();

  static String yyyyMMDDHHMMSSFormat(DateTime date) =>
      DateFormat(yyyyMMDDHHMMSSString).format(date).toString();

  static String yyyyMMDDKKMMSSFormat(DateTime date) =>
      DateFormat(yyyyMMDDKKMMSSString).format(date).toString();

  static String yyyyMMDDFormat(DateTime date) =>
      DateFormat(yyyyMMDDString).format(date).toString();

  static String eeeeFormat(DateTime date) =>
      DateFormat(eeeeString).format(date).toString();

  static String ddMMYYYYFormatWithUnderStore(DateTime date) =>
      DateFormat(ddMMYYYYStringWithUnderStore).format(date).toString();
}

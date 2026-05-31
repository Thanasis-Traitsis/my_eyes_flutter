import 'package:intl/intl.dart';
import 'package:my_eyes/core/constants/app_strings.dart';

extension DateFormatting on DateTime {
  String get formattedDate =>
      '${day.toString().padLeft(2, '0')}/'
      '${month.toString().padLeft(2, '0')}/'
      '$year';

  String get formattedMonth => DateFormat('MMMM yyyy').format(this);

  String get formattedDayMonth => DateFormat('d MMM').format(this);

  String toChartLabel() =>
      DateFormat(AppStrings.eyeTestChartDateFormat).format(this);
}

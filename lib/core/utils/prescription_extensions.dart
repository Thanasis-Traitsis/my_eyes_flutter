import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/domain/entities/prescription.dart';

extension PrescriptionFormatting on Prescription {
  String get formattedLeft => _format(leftEye);
  String get formattedRight => _format(rightEye);

  String _format(eye) => '${eye.sphere} ${eye.cylinder} x ${eye.axis}';
}

extension NullablePrescriptionFormatting on Prescription? {
  String get formattedLeftOrEmpty =>
      this?.formattedLeft ?? AppStrings.prescriptionNoData;

  String get formattedRightOrEmpty =>
      this?.formattedRight ?? AppStrings.prescriptionNoData;
}

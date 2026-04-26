import 'package:my_eyes/domain/entities/prescription.dart';

extension PrescriptionFormatting on Prescription {
  String get formattedLeft => _format(leftEye);
  String get formattedRight => _format(rightEye);

  String _format(eye) => '${eye.sphere} ${eye.cylinder} x ${eye.axis}';
}

import 'package:equatable/equatable.dart';
import 'package:my_eyes/domain/enums/lens_type.dart';

class ContactLensSupply extends Equatable {
  const ContactLensSupply({
    required this.lensType,
    required this.quantity,
    this.expirationDate,
    this.activatedAt,
  });

  final LensType lensType;
  final int quantity;
  final DateTime? expirationDate;
  final DateTime? activatedAt;

  bool get isActive => activatedAt != null;

  DateTime? get useByDate =>
      activatedAt?.add(Duration(days: lensType.totalDays));

  int? get daysRemaining {
    final end = useByDate;
    if (end == null) return null;
    return end.difference(DateTime.now()).inDays.clamp(0, lensType.totalDays);
  }

  static const Object _absent = Object();

  ContactLensSupply copyWith({
    LensType? lensType,
    int? quantity,
    Object? expirationDate = _absent,
    Object? activatedAt = _absent,
  }) => ContactLensSupply(
    lensType: lensType ?? this.lensType,
    quantity: quantity ?? this.quantity,
    expirationDate: identical(expirationDate, _absent)
        ? this.expirationDate
        : expirationDate as DateTime?,
    activatedAt: identical(activatedAt, _absent)
        ? this.activatedAt
        : activatedAt as DateTime?,
  );

  @override
  List<Object?> get props => [lensType, quantity, expirationDate, activatedAt];
}

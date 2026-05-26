import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/domain/entities/prescription.dart';
import 'package:my_eyes/presentation/prescription_history/widgets/prescription_history_card.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';

class PrescriptionList extends StatelessWidget {
  const PrescriptionList({
    super.key,
    required this.items,
    required this.isFetchingMore,
    required this.scrollController,
  });

  final List<Prescription> items;
  final bool isFetchingMore;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: CustomText(text: AppStrings.prescriptionHistoryEmpty),
      );
    }
    return Column(
      spacing: AppSpacing.spacingM,
      children: [
        for (final rx in items) PrescriptionHistoryCard(prescription: rx),
        if (isFetchingMore)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: AppSpacing.spacingM),
            child: Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}

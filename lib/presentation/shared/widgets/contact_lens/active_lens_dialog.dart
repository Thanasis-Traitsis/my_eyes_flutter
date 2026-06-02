import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/theme/custom_text_type.dart';
import 'package:my_eyes/core/utils/date_extensions.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/domain/entities/eyewear_item.dart';
import 'package:my_eyes/domain/enums/lens_type.dart';
import 'package:my_eyes/presentation/prescription/widgets/custom_date_picker.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_dialog.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';

class ActivateLensDialog extends StatefulWidget {
  const ActivateLensDialog({
    super.key,
    required this.item,
    this.isUpdate = false,
    this.initialDate,
  });

  final EyewearItem item;
  final bool isUpdate;
  final DateTime? initialDate;

  @override
  State<ActivateLensDialog> createState() => _ActivateLensDialogState();
}

class _ActivateLensDialogState extends State<ActivateLensDialog> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? _today;
  }

  DateTime get _today {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  List<_DateOption> get _options => [
    _DateOption(label: AppStrings.eyewearLensActivateOptionToday, date: _today),
    _DateOption(
      label: AppStrings.eyewearLensActivateOptionYesterday,
      date: _today.subtract(const Duration(days: 1)),
    ),
    _DateOption(
      label: AppStrings.eyewearLensActivateOptionTwoDays,
      date: _today.subtract(const Duration(days: 2)),
    ),
  ];

  Future<void> _pickCustomDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: _today,
      builder: (context, child) => CustomDatePicker(child: child!),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  bool _isPreset(DateTime date) =>
      _options.any((o) => _isSameDay(o.date, date));

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  Widget build(BuildContext context) {
    final supply = widget.item.contactLensSupply!;
    final isUpdate = widget.isUpdate;

    return CustomDialog(
      dialogIcon: Icons.lens_blur,
      dialogTitle: isUpdate
          ? AppStrings.eyewearLensUpdateDialogTitle
          : AppStrings.eyewearLensActivateDialogTitle,
      dialogDescription: isUpdate
          ? AppStrings.eyewearLensUpdateDialogDescription(supply.lensType.label)
          : AppStrings.eyewearLensActivateDialogDescription(
              supply.lensType.label,
            ),
      dialogBody: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.spacingM,
        children: [
          CustomText(
            text: AppStrings.eyewearLensActivateDialogWhenTitle,
            textType: CustomTextType.smallHeading,
          ),
          Column(
            spacing: AppSpacing.spacingS,
            children: [
              for (final option in _options)
                _DateOptionTile(
                  label: option.label,
                  isSelected: _isSameDay(_selectedDate, option.date),
                  onTap: () => setState(() => _selectedDate = option.date),
                ),
              _DateOptionTile(
                label: !_isPreset(_selectedDate)
                    ? _selectedDate.formattedDate
                    : AppStrings.eyewearLensActivateOptionCustom,
                isSelected: !_isPreset(_selectedDate),
                trailing: const Icon(Icons.calendar_today_outlined, size: 16),
                onTap: _pickCustomDate,
              ),
            ],
          ),
        ],
      ),
      primaryBtnText: isUpdate
          ? AppStrings.eyewearLensUpdateDialogConfirm
          : AppStrings.eyewearLensActivateDialogConfirm,
      primaryBtnAction: () => Navigator.of(context).pop(_selectedDate),
      secondaryBtnText: AppStrings.eyewearLensActivateDialogCancel,
      secondaryBtnAction: () => Navigator.of(context).pop(null),
      reversedButtons: true,
    );
  }
}

class _DateOption {
  const _DateOption({required this.label, required this.date});
  final String label;
  final DateTime date;
}

class _DateOptionTile extends StatelessWidget {
  const _DateOptionTile({
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.trailing,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.spacingM,
          vertical: AppSpacing.spacingM,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? context.colors.textPrimary
              : context.colors.surface,
          borderRadius: AppBorders.smallBorderRadius,
          border: Border.all(
            color: isSelected
                ? context.colors.textPrimary
                : context.colors.divider,
            width: AppBorders.smallBorderWidth,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: CustomText(
                text: label,
                textType: CustomTextType.smallBody,
                color: isSelected
                    ? context.colors.white
                    : context.colors.textPrimary,
              ),
            ),
            if (trailing != null)
              IconTheme(
                data: IconThemeData(
                  color: isSelected
                      ? context.colors.white
                      : context.colors.textSecondary,
                ),
                child: trailing!,
              ),
          ],
        ),
      ),
    );
  }
}

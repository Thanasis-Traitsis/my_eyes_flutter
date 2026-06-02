import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/utils/date_extensions.dart';
import 'package:my_eyes/domain/enums/lens_type.dart';
import 'package:my_eyes/presentation/eyewear/controller/add_eyewear_form_controller.dart';
import 'package:my_eyes/presentation/prescription/widgets/custom_date_picker.dart';
import 'package:my_eyes/presentation/profile/widgets/edit_profile/labeled_section.dart';

class ContactLensSection extends StatelessWidget {
  const ContactLensSection({
    super.key,
    required this.formController,
    required this.onChanged,
  });

  final AddEyewearFormController formController;
  final VoidCallback onChanged;

  Future<void> _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: formController.lensExpirationDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
      builder: (context, child) => CustomDatePicker(child: child!),
    );
    if (picked != null) {
      formController.lensExpirationDate = picked;
      onChanged();
    }
  }

  @override
  Widget build(BuildContext context) {
    final expiry = formController.lensExpirationDate;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.spacingL,
      children: [
        LabeledSection(
          title: AppStrings.eyewearLensSupplyFieldType,
          child: DropdownButtonFormField<LensType>(
            initialValue: formController.selectedLensType,
            onChanged: (value) {
              if (value != null) {
                formController.selectedLensType = value;
                onChanged();
              }
            },
            items: LensType.values
                .map((t) => DropdownMenuItem(value: t, child: Text(t.label)))
                .toList(),
          ),
        ),
        LabeledSection(
          title: AppStrings.eyewearLensSupplyFieldQuantity,
          child: TextFormField(
            controller: formController.lensQuantity,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              hintText: AppStrings.eyewearLensSupplyFieldQuantityHint,
              suffixText: AppStrings.eyewearLensSupplyFieldQuantityUnit,
            ),
            onChanged: (_) => onChanged(),
          ),
        ),
        LabeledSection(
          title: AppStrings.eyewearLensSupplyFieldExpiry,
          child: GestureDetector(
            onTap: () => _pickDate(context),
            child: AbsorbPointer(
              child: TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  hintText: AppStrings.eyewearLensSupplyFieldExpiryHint,
                  suffixIcon: const Icon(Icons.calendar_today_outlined),
                ),
                controller: TextEditingController(
                  text: expiry != null ? expiry.formattedDate : '',
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

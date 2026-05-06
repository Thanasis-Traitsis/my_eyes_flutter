import 'package:flutter/material.dart';
import 'package:my_eyes/domain/enums/eyewear_category.dart';

class EyewearCategoryDropdown extends StatelessWidget {
  const EyewearCategoryDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final EyewearCategory value;
  final ValueChanged<EyewearCategory?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<EyewearCategory>(
      initialValue: value,
      onChanged: onChanged,
      items: EyewearCategory.values
          .map(
            (category) =>
                DropdownMenuItem(value: category, child: Text(category.label)),
          )
          .toList(),
    );
  }
}

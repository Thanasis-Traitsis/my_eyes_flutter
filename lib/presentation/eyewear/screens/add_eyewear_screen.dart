import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/router/app_pages.dart';
import 'package:my_eyes/core/router/navigation_service.dart';
import 'package:my_eyes/core/validators/username_validator.dart';
import 'package:my_eyes/presentation/eyewear/controller/add_eyewear_form_controller.dart';
import 'package:my_eyes/presentation/eyewear/cubit/eyewear_cubit.dart';
import 'package:my_eyes/presentation/eyewear/widgets/eyewear_category_dropdown.dart';
import 'package:my_eyes/presentation/eyewear/widgets/eyewear_prescription_section.dart';
import 'package:my_eyes/presentation/eyewear/widgets/eyewear_visual_selector.dart';
import 'package:my_eyes/presentation/profile/widgets/edit_profile/labeled_section.dart';
import 'package:my_eyes/presentation/shared/screens/dismiss_keyboard.dart';
import 'package:my_eyes/presentation/shared/screens/full_screen_with_title.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_container.dart';
import 'package:my_eyes/presentation/shared/widgets/sticky_bottom_button.dart';
import 'package:my_eyes/presentation/shared/widgets/validated_text_field.dart';
import 'package:my_eyes/domain/enums/eyewear_category.dart';

class AddEyewearScreen extends StatefulWidget {
  const AddEyewearScreen({super.key});

  @override
  State<AddEyewearScreen> createState() => _AddEyewearScreenState();
}

class _AddEyewearScreenState extends State<AddEyewearScreen> {
  late final AddEyewearFormController _form;
  bool _hasInput = false;
  int _selectedOptionIndex = 0;

  bool get _canSave => _hasInput && _form.isFormValid;

  @override
  void initState() {
    super.initState();
    _form = AddEyewearFormController();
    for (final c in _form.allControllers) {
      c.addListener(_onFieldChanged);
    }
  }

  void _onFieldChanged() {
    final hasInput = _form.name.text.trim().isNotEmpty;
    if (hasInput != _hasInput) setState(() => _hasInput = hasInput);
  }

  @override
  void dispose() {
    for (final c in _form.allControllers) {
      c.removeListener(_onFieldChanged);
    }
    _form.dispose();
    super.dispose();
  }

  void _save() {
    context.read<EyewearCubit>().addItem(_form.buildItem());
    NavigationService.pop();
  }

  void _onCategoryChanged(EyewearCategory category) {
    setState(() {
      _form.selectedCategory = category;
      _selectedOptionIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: Stack(
        children: [
          FullScreenWithTitle(
            currentPage: AppPages.eyewearNew,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.spacingM,
              children: [
                CustomContainer(
                  containerTitle: AppStrings.eyewearAddSectionDetails,
                  containerChild: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: AppSpacing.spacingL,
                    children: [
                      LabeledSection(
                        title: AppStrings.eyewearFieldName,
                        validator: const UsernameValidator(),
                        child: ValidatedTextField(
                          controller: _form.name,
                          validator: const UsernameValidator(),
                          hintText: AppStrings.eyewearFieldNameHint,
                          onValidationChanged: (isValid) {
                            setState(
                              () => _form.setValidity(_form.name, isValid),
                            );
                          },
                        ),
                      ),
                      LabeledSection(
                        title: AppStrings.eyewearFieldCategory,
                        child: EyewearCategoryDropdown(
                          value: _form.selectedCategory,
                          onChanged: (category) {
                            if (category != null) {
                              _onCategoryChanged(category);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                CustomContainer(
                  containerTitle: _form.selectedCategory.label,
                  containerChild: EyewearVisualSelector(
                    category: _form.selectedCategory,
                    selectedIndex: _selectedOptionIndex,
                    onSelected: (index) =>
                        setState(() => _selectedOptionIndex = index),
                  ),
                ),
                CustomContainer(
                  containerTitle: AppStrings.eyewearAddSectionPrescription,
                  containerChild: EyewearPrescriptionSection(
                    formController: _form,
                    onValidationChanged: (controller, isValid) {
                      setState(() => _form.setValidity(controller, isValid));
                    },
                  ),
                ),
                Opacity(
                  opacity: 0,
                  child: StickyBottomButton(
                    buttonText: AppStrings.eyewearButtonSave,
                    isEnabled: _canSave,
                    onTap: _save,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: MediaQuery.of(context).padding.bottom,
            child: StickyBottomButton(
              buttonText: AppStrings.eyewearButtonSave,
              isEnabled: _canSave,
              onTap: _save,
            ),
          ),
        ],
      ),
    );
  }
}

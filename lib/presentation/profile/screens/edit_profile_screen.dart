import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/router/app_pages.dart';
import 'package:my_eyes/core/router/navigation_service.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/core/validators/email_validator.dart';
import 'package:my_eyes/core/validators/username_validator.dart';
import 'package:my_eyes/presentation/profile/controller/edit_profile_form_controller.dart';
import 'package:my_eyes/presentation/profile/cubit/profile_cubit.dart';
import 'package:my_eyes/presentation/profile/widgets/edit_profile/avatar_section.dart';
import 'package:my_eyes/presentation/profile/widgets/edit_profile/labeled_section.dart';
import 'package:my_eyes/presentation/profile/widgets/edit_profile/prescription_section.dart';
import 'package:my_eyes/presentation/shared/screens/dismiss_keyboard.dart';
import 'package:my_eyes/presentation/shared/screens/full_screen_with_title.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_container.dart';
import 'package:my_eyes/presentation/shared/widgets/validated_text_field.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listenWhen: (_, current) =>
          current is ProfileLoaded && current.saveError != null,
      listener: (context, state) {
        final error = (state as ProfileLoaded).saveError!;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error)));
      },
      builder: (context, state) {
        return switch (state) {
          ProfileInitial() ||
          ProfileLoading() => const Center(child: CircularProgressIndicator()),
          ProfileError(:final message) => Center(child: Text(message)),
          ProfileLoaded() => _EditProfileContent(state: state),
        };
      },
    );
  }
}

class _EditProfileContent extends StatefulWidget {
  const _EditProfileContent({required this.state});

  final ProfileLoaded state;

  @override
  State<_EditProfileContent> createState() => _EditProfileContentState();
}

class _EditProfileContentState extends State<_EditProfileContent> {
  late final EditProfileFormController _form;
  late final Map<TextEditingController, String> _initialValues;
  bool _hasChanges = false;

  bool get _canSave => _hasChanges && _form.isFormValid;

  @override
  void initState() {
    super.initState();
    _form = EditProfileFormController.fromState(
      profile: widget.state.profile,
      prescription: widget.state.latestPrescription,
    );
    _initialValues = {for (final c in _form.allControllers) c: c.text};
    for (final c in _form.allControllers) {
      c.addListener(_onFieldChanged);
    }
  }

  void _onFieldChanged() {
    final changed = _initialValues.entries.any((e) => e.key.text != e.value);
    if (changed != _hasChanges) setState(() => _hasChanges = changed);
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
    context.read<ProfileCubit>().saveProfile(
      username: _form.username.text.trim(),
      email: _form.email.text.trim(),
      updatedPrescription: widget.state.latestPrescription != null
          ? _form.buildUpdatedPrescription(widget.state.latestPrescription!)
          : null,
    );
    NavigationService.pop();
  }

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: Stack(
        children: [
          FullScreenWithTitle(
            currentPage: AppPages.editProfile,
            child: Column(
              crossAxisAlignment: .start,
              spacing: AppSpacing.spacingM,
              children: [
                CustomContainer(
                  containerTitle: AppStrings.profileEditSectionPersonalDetails,
                  containerChild: Column(
                    crossAxisAlignment: .start,
                    spacing: AppSpacing.spacingL,
                    children: [
                      const AvatarSection(),
                      LabeledSection(
                        title: AppStrings.profileLabelNickname,
                        validator: const UsernameValidator(),
                        child: ValidatedTextField(
                          controller: _form.username,
                          validator: const UsernameValidator(),
                          hintText: AppStrings.profileLabelNickname,
                          onValidationChanged: (isValid) {
                            setState(
                              () => _form.setValidity(_form.username, isValid),
                            );
                          },
                        ),
                      ),
                      LabeledSection(
                        title: AppStrings.profileLabelEmail,
                        validator: const EmailValidator(isOptional: true),
                        child: ValidatedTextField(
                          controller: _form.email,
                          validator: const EmailValidator(isOptional: true),
                          hintText: AppStrings.profileLabelEmail,
                          keyboardType: TextInputType.emailAddress,
                          onValidationChanged: (isValid) {
                            setState(
                              () => _form.setValidity(_form.email, isValid),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget.state.latestPrescription != null)
                  CustomContainer(
                    containerTitle:
                        AppStrings.profileEditSectionCurrentPrescription,
                    containerChild: PrescriptionSection(
                      formController: _form,
                      onValidationChanged: (controller, isValid) {
                        setState(() => _form.setValidity(controller, isValid));
                      },
                    ),
                  ),
                Opacity(
                  opacity: 0,
                  child: Container(
                    color: context.colors.background,
                    padding: .symmetric(vertical: AppSpacing.spacingL),
                    child: FilledButton(
                      onPressed: _canSave ? _save : null,
                      child: Text(AppStrings.profileButtonSave.toUpperCase()),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: MediaQuery.of(context).padding.bottom,
            child: Container(
              padding: .symmetric(
                horizontal: AppSpacing.spacingM,
                vertical: AppSpacing.spacingL,
              ),
              decoration: BoxDecoration(
                color: context.colors.background,
                border: Border(
                  top: BorderSide(
                    width: AppBorders.smallBorderWidth,
                    color: context.colors.black.withValues(alpha: 0.4),
                  ),
                ),
              ),
              child: FilledButton(
                onPressed: _canSave ? _save : null,
                child: Text(AppStrings.profileButtonSave.toUpperCase()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/router/app_pages.dart';
import 'package:my_eyes/core/router/navigation_service.dart';
import 'package:my_eyes/core/utils/date_extensions.dart';
import 'package:my_eyes/domain/entities/prescription.dart';
import 'package:my_eyes/presentation/prescription/controller/add_prescription_form_controller.dart';
import 'package:my_eyes/presentation/prescription/widgets/custom_date_picker.dart';
import 'package:my_eyes/presentation/profile/cubit/profile_cubit.dart';
import 'package:my_eyes/presentation/profile/widgets/edit_profile/eye_fields.dart';
import 'package:my_eyes/presentation/profile/widgets/edit_profile/labeled_section.dart';
import 'package:my_eyes/presentation/shared/screens/dismiss_keyboard.dart';
import 'package:my_eyes/presentation/shared/screens/full_screen_with_title.dart';
import 'package:my_eyes/presentation/shared/widgets/app_button.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_container.dart';
import 'package:my_eyes/presentation/shared/widgets/sticky_bottom_button.dart';

class AddPrescriptionScreen extends StatefulWidget {
  const AddPrescriptionScreen({super.key, this.prescription});

  final Prescription? prescription;

  @override
  State<AddPrescriptionScreen> createState() => _AddPrescriptionScreenState();
}

class _AddPrescriptionScreenState extends State<AddPrescriptionScreen> {
  late final AddPrescriptionFormController _form;
  late final TextEditingController _dateController;

  bool get _isEditing => widget.prescription != null;
  bool get _canSave => _form.isPrescriptionValid;

  @override
  void initState() {
    super.initState();
    _form = AddPrescriptionFormController();

    if (widget.prescription case final rx?) {
      _form.sphereRight.text = rx.rightEye.sphere.toString();
      _form.cylinderRight.text = rx.rightEye.cylinder.toString();
      _form.axisRight.text = rx.rightEye.axis.toString();
      _form.sphereLeft.text = rx.leftEye.sphere.toString();
      _form.cylinderLeft.text = rx.leftEye.cylinder.toString();
      _form.axisLeft.text = rx.leftEye.axis.toString();
      _form.doctor.text = rx.doctor ?? '';
      _form.notes.text = rx.notes ?? '';
      _form.issueDate = rx.issueDate;
      for (final c in _form.prescriptionControllers) {
        _form.setValidity(c, true);
      }
    }

    _dateController = TextEditingController(
      text: _form.issueDate.formattedDate,
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    _form.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _form.issueDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      confirmText: AppStrings.prescriptionNewDateConfirmButton.toUpperCase(),
      cancelText: AppStrings.prescriptionNewDateCancelButton.toUpperCase(),
      builder: (context, child) {
        return CustomDatePicker(child: child!);
      },
    );
    if (picked != null) {
      setState(() {
        _form.issueDate = picked;
        _dateController.text = picked.formattedDate;
      });
    }
  }

  void _reuseCurrentPrescription(Prescription rx) {
    _form.sphereRight.text = rx.rightEye.sphere.toString();
    _form.cylinderRight.text = rx.rightEye.cylinder.toString();
    _form.axisRight.text = rx.rightEye.axis.toString();
    _form.sphereLeft.text = rx.leftEye.sphere.toString();
    _form.cylinderLeft.text = rx.leftEye.cylinder.toString();
    _form.axisLeft.text = rx.leftEye.axis.toString();

    for (final c in _form.prescriptionControllers) {
      _form.setValidity(c, true);
    }
    setState(() {});
  }

  void _save() {
    final built = _form.build(existing: widget.prescription);
    if (_isEditing) {
      context.read<ProfileCubit>().editPrescription(built);
    } else {
      context.read<ProfileCubit>().addPrescription(built);
    }
    NavigationService.pop();
  }

  @override
  Widget build(BuildContext context) {
    final profileState = context.watch<ProfileCubit>().state;
    final currentRx = profileState is ProfileLoaded
        ? profileState.latestPrescription
        : null;

    return DismissKeyboard(
      child: Stack(
        children: [
          FullScreenWithTitle(
            currentPage: widget.prescription != null
                ? AppPages.prescriptionEdit
                : AppPages.prescriptionNew,
            child: SingleChildScrollView(
              child: Column(
                spacing: AppSpacing.spacingM,
                children: [
                  CustomContainer(
                    containerTitle:
                        AppStrings.prescriptionNewPrescriptionSection,
                    buttonWidget: AppButton.textButton(
                      icon: Icons.arrow_downward_rounded,
                      iconAlignment: IconAlignment.end,
                      text: currentRx != null
                          ? AppStrings.prescriptionNewReuseButton
                          : "",
                      onPressed: currentRx != null
                          ? () => _reuseCurrentPrescription(currentRx)
                          : null,
                    ),
                    containerChild: Column(
                      spacing: AppSpacing.spacingM,
                      children: [
                        LabeledSection(
                          title: AppStrings.prescriptionNewIssueDate,
                          child: TextField(
                            controller: _dateController,
                            readOnly: true,
                            onTap: _pickDate,
                            decoration: const InputDecoration(
                              suffixIcon: Icon(Icons.calendar_today_outlined),
                            ),
                          ),
                        ),
                        EyeFields(
                          label: AppStrings.prescriptionOdRight,
                          sphereController: _form.sphereRight,
                          cylinderController: _form.cylinderRight,
                          axisController: _form.axisRight,
                          onValidationChanged: (c, isValid) =>
                              setState(() => _form.setValidity(c, isValid)),
                        ),
                        EyeFields(
                          label: AppStrings.prescriptionOsLeft,
                          sphereController: _form.sphereLeft,
                          cylinderController: _form.cylinderLeft,
                          axisController: _form.axisLeft,
                          onValidationChanged: (c, isValid) =>
                              setState(() => _form.setValidity(c, isValid)),
                        ),
                      ],
                    ),
                  ),
                  CustomContainer(
                    containerTitle: AppStrings.prescriptionNewDetailsSection,
                    containerChild: Column(
                      spacing: AppSpacing.spacingM,
                      children: [
                        LabeledSection(
                          title: AppStrings.prescriptionNewDoctor,
                          child: TextField(
                            controller: _form.doctor,
                            decoration: InputDecoration(
                              hintText: AppStrings.prescriptionNewDoctorHint,
                            ),
                          ),
                        ),
                        LabeledSection(
                          title: AppStrings.prescriptionNewNotes,
                          child: TextField(
                            controller: _form.notes,
                            maxLines: 3,
                            decoration: InputDecoration(
                              hintText: AppStrings.prescriptionNewNotesHint,
                              alignLabelWithHint: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Opacity(
                    opacity: 0,
                    child: StickyBottomButton(
                      buttonText: AppStrings.prescriptionNewSave,
                      isEnabled: false,
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: MediaQuery.of(context).padding.bottom,
            child: StickyBottomButton(
              buttonText: AppStrings.prescriptionNewSave,
              isEnabled: _canSave,
              onTap: _save,
            ),
          ),
        ],
      ),
    );
  }
}

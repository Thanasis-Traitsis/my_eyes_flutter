import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/router/app_pages.dart';
import 'package:my_eyes/core/router/navigation_service.dart';
import 'package:my_eyes/core/utils/date_extensions.dart';
import 'package:my_eyes/core/validators/username_validator.dart';
import 'package:my_eyes/domain/entities/calendar_event.dart';
import 'package:my_eyes/domain/enums/calendar_event_type.dart';
import 'package:my_eyes/presentation/calendar/cubit/calendar_event_cubit.dart';
import 'package:my_eyes/presentation/prescription/widgets/custom_date_picker.dart';
import 'package:my_eyes/presentation/profile/widgets/edit_profile/labeled_section.dart';
import 'package:my_eyes/presentation/shared/screens/dismiss_keyboard.dart';
import 'package:my_eyes/presentation/shared/screens/full_screen_with_title.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_container.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_dialog.dart';
import 'package:my_eyes/presentation/shared/widgets/delete_icon_button.dart';
import 'package:my_eyes/presentation/shared/widgets/sticky_bottom_button.dart';
import 'package:my_eyes/presentation/shared/widgets/validated_text_field.dart';

class AddCalendarEventScreen extends StatefulWidget {
  const AddCalendarEventScreen({super.key, this.event});

  final CalendarEvent? event;

  @override
  State<AddCalendarEventScreen> createState() => _AddCalendarEventScreenState();
}

class _AddCalendarEventScreenState extends State<AddCalendarEventScreen> {
  late final TextEditingController _title;
  late final TextEditingController _description;
  late final TextEditingController _dateController;
  late DateTime _selectedDate;
  bool _titleValid = false;

  bool get _isEditing => widget.event != null;
  bool get _canSave => _titleValid;

  @override
  void initState() {
    super.initState();
    final event = widget.event;
    _selectedDate = event?.date ?? DateTime.now();
    _title = TextEditingController(text: event?.title ?? '');
    _description = TextEditingController(text: event?.description ?? '');
    _dateController = TextEditingController(text: _selectedDate.formattedDate);
    _titleValid = (_title.text.trim().length >= 3);
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2035),
      confirmText: AppStrings.prescriptionNewDateConfirmButton.toUpperCase(),
      cancelText: AppStrings.prescriptionNewDateCancelButton.toUpperCase(),
      builder: (context, child) => CustomDatePicker(child: child!),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = picked.formattedDate;
      });
    }
  }

  void _save() {
    final now = DateTime.now();
    final existing = widget.event;
    final event = CalendarEvent(
      id: existing?.id ?? 'event-${now.millisecondsSinceEpoch}',
      date: _selectedDate,
      title: _title.text.trim(),
      type: CalendarEventType.custom,
      description: _description.text.trim().isEmpty
          ? null
          : _description.text.trim(),
    );
    if (_isEditing) {
      context.read<CalendarEventCubit>().updateEvent(event);
    } else {
      context.read<CalendarEventCubit>().addEvent(event);
    }
    NavigationService.pop();
  }

  Future<void> _confirmDelete() async {
    final event = widget.event;
    if (event == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => CustomDialog(
        dialogIcon: Icons.delete,
        dialogTitle: AppStrings.calendarEventDeleteDialogTitle,
        dialogDescription: AppStrings.calendarEventDeleteDialogBody(
          event.title,
        ),
        primaryBtnText: AppStrings.calendarEventDeleteDialogCancel,
        primaryBtnAction: () => Navigator.of(dialogContext).pop(false),
        secondaryBtnText: AppStrings.calendarEventDeleteDialogConfirm,
        secondaryBtnAction: () => Navigator.of(dialogContext).pop(true),
      ),
    );

    if (confirmed == true && mounted) {
      context.read<CalendarEventCubit>().deleteEvent(event.id);
      NavigationService.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: Stack(
        children: [
          FullScreenWithTitle(
            currentPage: _isEditing
                ? AppPages.calendarEventEdit
                : AppPages.calendarEventNew,
            suffixButtons: _isEditing
                ? [
                    deleteIconButton(
                      onPressed: _confirmDelete,
                      context: context,
                    ),
                  ]
                : [],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.spacingM,
              children: [
                CustomContainer(
                  containerTitle: AppStrings.calendarEventAddSectionDetails,
                  containerChild: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: AppSpacing.spacingL,
                    children: [
                      LabeledSection(
                        title: AppStrings.calendarEventFieldTitle,
                        validator: const UsernameValidator(
                          fieldName: AppStrings.calendarEventFieldTitle,
                        ),
                        child: ValidatedTextField(
                          controller: _title,
                          validator: const UsernameValidator(
                            fieldName: AppStrings.calendarEventFieldTitle,
                          ),
                          hintText: AppStrings.calendarEventFieldTitleHint,
                          onValidationChanged: (isValid) {
                            setState(() => _titleValid = isValid);
                          },
                        ),
                      ),
                      LabeledSection(
                        title: AppStrings.calendarEventFieldDate,
                        child: TextField(
                          controller: _dateController,
                          readOnly: true,
                          onTap: _pickDate,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.calendar_today_outlined),
                          ),
                        ),
                      ),
                      LabeledSection(
                        title: AppStrings.calendarEventFieldNotes,
                        child: TextField(
                          controller: _description,
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintText: AppStrings.calendarEventFieldNotesHint,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Opacity(
                  opacity: 0,
                  child: StickyBottomButton(
                    buttonText: AppStrings.calendarEventButtonSave,
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
              buttonText: AppStrings.calendarEventButtonSave,
              isEnabled: _canSave,
              onTap: _save,
            ),
          ),
        ],
      ),
    );
  }
}

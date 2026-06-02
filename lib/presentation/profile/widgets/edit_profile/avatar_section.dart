import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
import 'package:my_eyes/core/constants/app_sizes.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/theme/custom_text_type.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/presentation/profile/cubit/profile_cubit.dart';
import 'package:my_eyes/presentation/profile/widgets/edit_profile/avatar_picker_content.dart';
import 'package:my_eyes/presentation/shared/widgets/app_button.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_bottomsheet.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';

class AvatarSection extends StatelessWidget {
  const AvatarSection({super.key, this.avatarUrl});

  final String? avatarUrl;

  Future<void> _openPicker(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.colors.surface,
      builder: (sheetContext) => _AvatarPickerSheet(
        currentUrl: avatarUrl,
        onSave: (url) {
          context.read<ProfileCubit>().updateAvatar(url);
          Navigator.of(sheetContext).pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppSpacing.spacingM,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ClipRRect(
          borderRadius: AppBorders.mediumBorderRadius,
          child: avatarUrl != null
              ? Image.asset(
                  avatarUrl!,
                  width: AppSizes.profileAvatarSize,
                  height: AppSizes.profileAvatarSize,
                  fit: BoxFit.fitHeight,
                )
              : Container(
                  width: AppSizes.profileAvatarSize,
                  height: AppSizes.profileAvatarSize,
                  color: context.colors.white,
                ),
        ),
        AppButton.outlined(
          iconAlignment: IconAlignment.end,
          icon: Icons.edit,
          text: AppStrings.profileButtonEditImage,
          onPressed: () => _openPicker(context),
        ),
      ],
    );
  }
}

class _AvatarPickerSheet extends StatefulWidget {
  const _AvatarPickerSheet({required this.currentUrl, required this.onSave});

  final String? currentUrl;
  final ValueChanged<String> onSave;

  @override
  State<_AvatarPickerSheet> createState() => _AvatarPickerSheetState();
}

class _AvatarPickerSheetState extends State<_AvatarPickerSheet> {
  late String _selectedUrl;

  @override
  void initState() {
    super.initState();
    _selectedUrl = widget.currentUrl ?? '';
  }

  bool get _hasChanged => _selectedUrl != widget.currentUrl;

  @override
  Widget build(BuildContext context) {
    return CustomBottomsheet(
      bottomsheetTitle: AppStrings.profileAvatarPickerTitle,
      primaryButtonText: AppStrings.profileAvatarPickerSave,
      secondaryButtonText: AppStrings.profileAvatarPickerCancel,
      isPrimaryActive: _hasChanged,
      primaryOnPressed: () => widget.onSave(_selectedUrl),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.spacingM,
        children: [
          CustomText(
            text: AppStrings.profileAvatarPickerDescription,
            textType: CustomTextType.smallBody,
            color: context.colors.textSecondary,
          ),
          AvatarPickerContent(
            selectedUrl: _selectedUrl.isEmpty ? null : _selectedUrl,
            onSelected: (url) => setState(() => _selectedUrl = url),
          ),
        ],
      ),
    );
  }
}

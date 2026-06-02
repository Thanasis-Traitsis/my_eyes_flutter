import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/domain/entities/eyewear_item.dart';
import 'package:my_eyes/presentation/eyewear/cubit/eyewear_cubit.dart';
import 'package:my_eyes/presentation/shared/widgets/contact_lens/active_content.dart';
import 'package:my_eyes/presentation/shared/widgets/contact_lens/active_lens_dialog.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_dialog.dart';

class ActiveLensActions extends StatelessWidget {
  const ActiveLensActions({
    super.key,
    required this.item,
    this.isEditing = false,
  });

  final EyewearItem item;
  final bool isEditing;

  Future<void> _handleUpdate(BuildContext context) async {
    final supply = item.contactLensSupply!;
    final chosenDate = await showDialog<DateTime>(
      context: context,
      builder: (_) => ActivateLensDialog(
        item: item,
        isUpdate: true,
        initialDate: supply.activatedAt,
      ),
    );

    if (chosenDate != null && context.mounted) {
      context.read<EyewearCubit>().updateLensActivation(
        item,
        activatedAt: chosenDate,
      );
    }
  }

  Future<void> _handleRemove(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => CustomDialog(
        dialogIcon: Icons.delete_outline,
        dialogTitle: AppStrings.eyewearLensRemoveDialogTitle,
        dialogDescription: AppStrings.eyewearLensRemoveDialogBody,
        primaryBtnText: AppStrings.eyewearLensRemoveDialogCancel,
        primaryBtnAction: () => Navigator.of(dialogContext).pop(false),
        secondaryBtnText: AppStrings.eyewearLensRemoveDialogConfirm,
        secondaryBtnAction: () => Navigator.of(dialogContext).pop(true),
      ),
    );

    if (confirmed == true && context.mounted) {
      context.read<EyewearCubit>().deactivateLens(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ActiveContent(
      supply: item.contactLensSupply!,
      isEditing: isEditing,
      onUpdate: () => _handleUpdate(context),
      onRemove: () => _handleRemove(context),
    );
  }
}

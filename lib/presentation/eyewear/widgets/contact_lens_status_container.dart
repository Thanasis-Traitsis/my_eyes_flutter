import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/domain/entities/eyewear_item.dart';
import 'package:my_eyes/presentation/eyewear/cubit/eyewear_cubit.dart';
import 'package:my_eyes/presentation/eyewear/widgets/active_lens_actions.dart';
import 'package:my_eyes/presentation/shared/widgets/contact_lens/active_lens_dialog.dart';
import 'package:my_eyes/presentation/shared/widgets/contact_lens/inactive_content.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_container.dart';
import 'package:my_eyes/presentation/shared/widgets/label_tag.dart';

class ContactLensStatusContainer extends StatelessWidget {
  const ContactLensStatusContainer({super.key, required this.item});

  final EyewearItem item;

  Future<void> _confirmActivate(BuildContext context) async {
    final chosenDate = await showDialog<DateTime>(
      context: context,
      builder: (_) => ActivateLensDialog(item: item),
    );

    if (chosenDate != null && context.mounted) {
      context.read<EyewearCubit>().activateLens(item, activatedAt: chosenDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final supply = item.contactLensSupply!;

    return CustomContainer(
      icon: Icons.lens_blur,
      containerTitle: AppStrings.eyewearLensStatusTitle,
      iconBackgroundColor: context.colors.white,
      backgroundColor: context.colors.textPrimary,
      contentColor: context.colors.white,
      buttonWidget: LabelTag(
        label: supply.isActive
            ? AppStrings.eyewearLensStatusActive
            : AppStrings.eyewearLensStatusInactive,
        greenTag: supply.isActive,
        infoTag: !supply.isActive,
      ),
      containerChild: supply.isActive
          ? ActiveLensActions(item: item)
          : InactiveContent(
              supply: supply,
              onActivate: () => _confirmActivate(context),
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/domain/entities/eyewear_item.dart';
import 'package:my_eyes/presentation/eyetest/widgets/test_statistics.dart';
import 'package:my_eyes/presentation/eyewear/cubit/eyewear_cubit.dart';
import 'package:my_eyes/presentation/shared/widgets/app_button.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_container.dart';

class StatisticsSection extends StatefulWidget {
  const StatisticsSection({super.key});

  @override
  State<StatisticsSection> createState() => _StatisticsSectionState();
}

class _StatisticsSectionState extends State<StatisticsSection> {
  static const _allId = '';

  String _selectedId = _allId;

  String? get _eyewearIdFilter => _selectedId == _allId ? null : _selectedId;

  @override
  Widget build(BuildContext context) {
    final eyewearState = context.watch<EyewearCubit>().state;
    final items = eyewearState is EyewearLoaded
        ? eyewearState.items
        : <EyewearItem>[];

    final buttonLabel = _eyewearIdFilter == null
        ? AppStrings.eyeTestStatisticsButtonText
        : items
              .firstWhere(
                (e) => e.id == _eyewearIdFilter,
                orElse: () => items.first,
              )
              .name;

    final dropdownButton = PopupMenuButton<String>(
      onSelected: (id) => setState(() => _selectedId = id),
      itemBuilder: (_) => [
        PopupMenuItem<String>(
          value: _allId,
          child: Text(AppStrings.eyeTestStatisticsButtonText.toUpperCase()),
        ),
        ...items.map(
          (e) => PopupMenuItem<String>(
            value: e.id,
            child: Text(e.name.toUpperCase()),
          ),
        ),
      ],
      child: AbsorbPointer(
        child: AppButton.outlined(
          text: buttonLabel,
          onPressed: () {},
          size: AppButtonSize.regular,
          icon: Icons.keyboard_arrow_down_sharp,
          iconAlignment: IconAlignment.end,
        ),
      ),
    );

    return CustomContainer(
      containerTitle: AppStrings.eyeTestStatisticsHeader,
      buttonWidget: items.isNotEmpty ? dropdownButton : null,
      buttonText: items.isEmpty ? AppStrings.eyeTestStatisticsButtonText : null,
      containerChild: TestStatistics(eyewearIdFilter: _eyewearIdFilter),
    );
  }
}

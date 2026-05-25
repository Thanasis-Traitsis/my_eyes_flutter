import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_eyes/core/constants/app_values.dart';
import 'package:my_eyes/core/router/app_pages.dart';
import 'package:my_eyes/domain/repositories/prescription_repository.dart';
import 'package:my_eyes/injection.dart';
import 'package:my_eyes/presentation/prescription_history/cubit/prescription_history_cubit.dart';
import 'package:my_eyes/presentation/prescription_history/widgets/prescription_list.dart';
import 'package:my_eyes/presentation/shared/screens/full_screen_with_title.dart';

class PrescriptionHistoryScreen extends StatelessWidget {
  const PrescriptionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          PrescriptionHistoryCubit(getIt<PrescriptionRepository>())
            ..loadFirstPage(),
      child: const _PrescriptionHistoryView(),
    );
  }
}

class _PrescriptionHistoryView extends StatefulWidget {
  const _PrescriptionHistoryView();

  @override
  State<_PrescriptionHistoryView> createState() =>
      _PrescriptionHistoryViewState();
}

class _PrescriptionHistoryViewState extends State<_PrescriptionHistoryView> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    final state = context.read<PrescriptionHistoryCubit>().state;
    if (state is! PrescriptionHistoryLoaded ||
        !state.hasMore ||
        state.isFetchingMore) {
      return;
    }
    final itemHeight =
        _scrollController.position.maxScrollExtent /
        (state.items.isNotEmpty ? state.items.length : 1);
    final triggerOffset =
        _scrollController.position.maxScrollExtent -
        (itemHeight * AppValues.kPrescriptionHistoryPrefetchThreshold);

    if (_scrollController.offset >= triggerOffset) {
      context.read<PrescriptionHistoryCubit>().loadNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FullScreenWithTitle(
      currentPage: AppPages.prescriptionHistory,
      child: BlocBuilder<PrescriptionHistoryCubit, PrescriptionHistoryState>(
        builder: (context, state) => switch (state) {
          PrescriptionHistoryInitial() || PrescriptionHistoryLoading() =>
            const Center(child: CircularProgressIndicator()),
          PrescriptionHistoryError(:final message) => Center(
            child: Text(message),
          ),
          PrescriptionHistoryLoaded(:final items, :final isFetchingMore) =>
            PrescriptionList(
              items: items,
              isFetchingMore: isFetchingMore,
              scrollController: _scrollController,
            ),
        },
      ),
    );
  }
}

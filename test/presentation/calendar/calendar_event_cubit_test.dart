import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_eyes/domain/entities/calendar_event.dart';
import 'package:my_eyes/domain/enums/calendar_event_type.dart';
import 'package:my_eyes/domain/repositories/calendar_event_repository.dart';
import 'package:my_eyes/presentation/calendar/cubit/calendar_event_cubit.dart';

class MockCalendarEventRepository extends Mock
    implements CalendarEventRepository {}

class FakeCalendarEvent extends Fake implements CalendarEvent {}

List<CalendarEvent> _makeEvents(int count) => List.generate(
  count,
  (i) => CalendarEvent(
    id: 'e$i',
    date: DateTime(2026, 6, i + 1),
    title: 'Event $i',
    type: CalendarEventType.custom,
  ),
);

CalendarEvent _event({String id = 'e0', String title = 'Eye Exam'}) =>
    CalendarEvent(
      id: id,
      date: DateTime(2026, 7, 1),
      title: title,
      type: CalendarEventType.custom,
    );

void main() {
  late MockCalendarEventRepository repository;

  setUpAll(() => registerFallbackValue(FakeCalendarEvent()));

  setUp(() => repository = MockCalendarEventRepository());

  CalendarEventCubit buildCubit() => CalendarEventCubit(repository);

  group('loadEvents', () {
    blocTest<CalendarEventCubit, CalendarEventState>(
      'emits loading then loaded with events from repository',
      build: () {
        when(
          () => repository.getEvents(),
        ).thenAnswer((_) async => _makeEvents(3));
        return buildCubit();
      },
      act: (cubit) => cubit.loadEvents(),
      expect: () => [
        const CalendarEventLoading(),
        isA<CalendarEventLoaded>().having(
          (s) => s.events.length,
          'events.length',
          3,
        ),
      ],
      verify: (_) => verify(() => repository.getEvents()).called(1),
    );

    blocTest<CalendarEventCubit, CalendarEventState>(
      'emits loaded with empty list when no events exist',
      build: () {
        when(() => repository.getEvents()).thenAnswer((_) async => []);
        return buildCubit();
      },
      act: (cubit) => cubit.loadEvents(),
      expect: () => [
        const CalendarEventLoading(),
        isA<CalendarEventLoaded>().having((s) => s.events, 'events', isEmpty),
      ],
    );

    blocTest<CalendarEventCubit, CalendarEventState>(
      'emits error when repository throws',
      build: () {
        when(
          () => repository.getEvents(),
        ).thenThrow(Exception('storage error'));
        return buildCubit();
      },
      act: (cubit) => cubit.loadEvents(),
      expect: () => [const CalendarEventLoading(), isA<CalendarEventError>()],
    );

    blocTest<CalendarEventCubit, CalendarEventState>(
      'can reload — replaces previous state with fresh data',
      build: () {
        when(
          () => repository.getEvents(),
        ).thenAnswer((_) async => _makeEvents(2));
        return buildCubit();
      },
      act: (cubit) async {
        await cubit.loadEvents();
        await cubit.loadEvents();
      },
      expect: () => [
        const CalendarEventLoading(),
        isA<CalendarEventLoaded>().having((s) => s.events.length, 'length', 2),
        const CalendarEventLoading(),
        isA<CalendarEventLoaded>().having((s) => s.events.length, 'length', 2),
      ],
      verify: (_) => verify(() => repository.getEvents()).called(2),
    );
  });

  group('addEvent', () {
    blocTest<CalendarEventCubit, CalendarEventState>(
      'saves event then reloads — emits loaded with new event',
      build: () {
        when(() => repository.saveEvent(any())).thenAnswer((_) async {});
        when(() => repository.getEvents()).thenAnswer((_) async => [_event()]);
        return buildCubit();
      },
      act: (cubit) => cubit.addEvent(_event()),
      expect: () => [
        const CalendarEventLoading(),
        isA<CalendarEventLoaded>().having(
          (s) => s.events.length,
          'events.length',
          1,
        ),
      ],
      verify: (_) {
        verify(() => repository.saveEvent(any())).called(1);
        verify(() => repository.getEvents()).called(1);
      },
    );

    blocTest<CalendarEventCubit, CalendarEventState>(
      'emits error when saveEvent throws',
      build: () {
        when(
          () => repository.saveEvent(any()),
        ).thenThrow(Exception('write error'));
        return buildCubit();
      },
      act: (cubit) => cubit.addEvent(_event()),
      expect: () => [isA<CalendarEventError>()],
    );
  });

  group('updateEvent', () {
    blocTest<CalendarEventCubit, CalendarEventState>(
      'updates event then reloads — emits loaded with updated list',
      build: () {
        when(() => repository.updateEvent(any())).thenAnswer((_) async {});
        when(
          () => repository.getEvents(),
        ).thenAnswer((_) async => [_event(title: 'Updated')]);
        return buildCubit();
      },
      act: (cubit) => cubit.updateEvent(_event(title: 'Updated')),
      expect: () => [
        const CalendarEventLoading(),
        isA<CalendarEventLoaded>().having(
          (s) => s.events.first.title,
          'title',
          'Updated',
        ),
      ],
      verify: (_) {
        verify(() => repository.updateEvent(any())).called(1);
        verify(() => repository.getEvents()).called(1);
      },
    );

    blocTest<CalendarEventCubit, CalendarEventState>(
      'emits error when updateEvent throws',
      build: () {
        when(
          () => repository.updateEvent(any()),
        ).thenThrow(Exception('write error'));
        return buildCubit();
      },
      act: (cubit) => cubit.updateEvent(_event()),
      expect: () => [isA<CalendarEventError>()],
    );
  });

  group('deleteEvent', () {
    blocTest<CalendarEventCubit, CalendarEventState>(
      'deletes event then reloads — emits loaded with remaining events',
      build: () {
        when(() => repository.deleteEvent(any())).thenAnswer((_) async {});
        when(() => repository.getEvents()).thenAnswer((_) async => []);
        return buildCubit();
      },
      act: (cubit) => cubit.deleteEvent('e0'),
      expect: () => [
        const CalendarEventLoading(),
        isA<CalendarEventLoaded>().having((s) => s.events, 'events', isEmpty),
      ],
      verify: (_) {
        verify(() => repository.deleteEvent('e0')).called(1);
        verify(() => repository.getEvents()).called(1);
      },
    );

    blocTest<CalendarEventCubit, CalendarEventState>(
      'emits error when deleteEvent throws',
      build: () {
        when(
          () => repository.deleteEvent(any()),
        ).thenThrow(Exception('delete error'));
        return buildCubit();
      },
      act: (cubit) => cubit.deleteEvent('e0'),
      expect: () => [isA<CalendarEventError>()],
    );
  });
}

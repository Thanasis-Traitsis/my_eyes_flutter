# Implementation Plan: Eye Health Manager

## Overview

Flutter mobile app following Clean Architecture, TDD (tests written before production code), BLoC/Cubit state management, go_router navigation, Hive local storage, Supabase (auth + remote sync), local notifications, and Google Calendar integration. Every production code task is preceded by its test task. Optional test sub-tasks are marked with `*`.

## Tasks

- [ ] 1. Project setup and architecture scaffolding
  - Initialise Flutter project with package name `com.example.eye_health_manager`
  - Add all dependencies to `pubspec.yaml`: `flutter_bloc`, `go_router`, `hive`, `hive_flutter`, `hive_generator`, `build_runner`, `get_it`, `injectable`, `injectable_generator`, `flutter_local_notifications`, `timezone`, `googleapis`, `google_sign_in`, `supabase_flutter`, `connectivity_plus`, `equatable`, `uuid`
  - Add dev dependencies: `bloc_test`, `mocktail`, `glados`, `fake_async`
  - Create the full directory skeleton under `lib/` and `test/` matching the design document structure (empty placeholder files are fine)
  - Create `lib/core/error/failures.dart` and `lib/core/error/exceptions.dart` with base `Failure` and `AppException` types
  - Create `lib/core/usecases/usecase.dart` with abstract `UseCase<Type, Params>` and `NoParams`
  - Create `lib/core/utils/date_utils.dart` with `daysUntil(DateTime date)` helper
  - _Requirements: 6.1, 6.2_


- [ ] 2. Test helpers: fake repositories, fake services, and PBT generators
  - [ ] 2.1 Create `test/helpers/fakes/` with hand-written fake implementations for all repository and service interfaces: `FakePrescriptionRepository`, `FakeLensRepository`, `FakeEyewearRepository`, `FakeVisionTestRepository`, `FakeProfileRepository`, `FakeAuthRepository`, `FakeNotificationService`, `FakeCalendarService`, `FakeSyncService`, `FakeConnectivityService`
    - Each fake stores data in an in-memory list and mirrors the ordering contract of the real interface
    - `FakeAuthRepository` exposes a `StreamController<UserProfile?>` for `authStateStream`
    - `FakeSyncService` records calls to `syncPendingChanges()` and `pullRemoteData()` for mocktail-style verification
    - `FakeConnectivityService` exposes a `StreamController<bool>` for `connectivityStream`
    - _Requirements: 6.6, 11.1_
  - [ ] 2.2 Create `test/helpers/fakes/` remote data source fakes: `FakePrescriptionRemoteDataSource`, `FakeLensRemoteDataSource`, `FakeEyewearRemoteDataSource`, `FakeVisionTestRemoteDataSource`, `FakeProfileRemoteDataSource`
    - Each stores data in an in-memory map keyed by record id
    - _Requirements: 6.6, 11.4_
  - [ ] 2.3 Create `test/helpers/generators/` with `glados` arbitrary generators: `prescriptionGenerator`, `eyeMeasurementGenerator`, `contactLensGenerator`, `visionTestGenerator`, `userProfileGenerator`
    - Generators must produce only in-range values (sphere −30–+30, cylinder −10–+10, axis 0–180, addition 0–4, PD 40–80, lifespan in {1,7,14,30,90}, score 0–100)
    - `userProfileGenerator` produces `UserProfile` with non-empty `id`, `username`, `email`, and valid `updatedAt`
    - _Requirements: 1.1, 2.1, 8.3, 11.2_

- [ ] 3. Domain entities
  - [ ] 3.1 Write unit tests for `EyeMeasurement` and `Prescription` value equality and field constraints in `test/domain/entities/validation_test.dart`
    - Test that two instances with identical fields are equal (requires `Equatable`)
    - Test that `Prescription` carries an `updatedAt` field
    - _Requirements: 1.1, 1.2, 11.10_
  - [ ] 3.2 Implement `EyeMeasurement` and `Prescription` domain entities in `lib/domain/entities/`
    - Extend `Equatable`; include all fields from the design document including `updatedAt: DateTime`
    - _Requirements: 1.1, 1.2, 11.10_
  - [ ] 3.3 Write unit tests for `ContactLens`, `Eyewear`, `VisionTest`, and `UserProfile` value equality and `updatedAt` presence
    - `UserProfile` must have: `id`, `username`, `email`, `avatarUrl`, `updatedAt`
    - _Requirements: 2.1, 9.1, 8.3, 10.1, 11.10_
  - [ ] 3.4 Implement `ContactLens`, `Eyewear`, `VisionTest`, and `UserProfile` domain entities
    - All entities include `updatedAt: DateTime`; `ContactLens.expiryDate` is a stored field; `Eyewear` holds a full `Prescription` and a list of `visionTestIds`
    - `UserProfile` fields: `id`, `username`, `email`, `avatarUrl`, `updatedAt`
    - _Requirements: 2.1, 2.2, 9.1, 8.3, 11.10_


- [ ] 4. Domain repository interfaces and service interfaces
  - [ ] 4.1 Implement all repository interfaces in `lib/domain/repositories/`: `PrescriptionRepository`, `LensRepository`, `EyewearRepository`, `VisionTestRepository`, `ProfileRepository`
    - Each interface includes a `syncPendingChanges()` method
    - Pure abstract classes; no implementation details
    - _Requirements: 6.2, 11.4_
  - [ ] 4.2 Implement `AuthRepository` interface in `lib/domain/repositories/auth_repository.dart`
    - Methods: `signInWithGoogle()`, `signInWithApple()`, `signOut()`, `getCurrentUser()`
    - Exposes `Stream<UserProfile?> authStateStream`
    - _Requirements: 11.1, 11.2_
  - [ ] 4.3 Implement service interfaces in `lib/domain/services/`: `NotificationService`, `CalendarService`, `AuthService`, `SyncService`, `ConnectivityService`
    - `CalendarService` includes `CalendarAuthState` enum: `signedIn`, `signedOut`, `unauthorized`, `error`
    - `SyncService` includes `syncPendingChanges()` and `pullRemoteData()`
    - `ConnectivityService` includes `isOnline()` and `Stream<bool> connectivityStream`
    - _Requirements: 3.1, 4.1, 11.1, 11.5, 11.9_

- [ ] 5. Domain use cases — Prescription
  - [ ] 5.1 Write unit tests for `GetPrescriptions`, `SavePrescription`, `UpdatePrescription`, `DeletePrescription` use cases in `test/domain/usecases/prescription/`
    - Use `FakePrescriptionRepository`; assert correct delegation and return values
    - _Requirements: 1.3, 1.4, 1.6, 1.7_
  - [ ] 5.2 Implement `GetPrescriptions`, `SavePrescription`, `UpdatePrescription`, `DeletePrescription` use cases in `lib/domain/usecases/prescription/`
    - Each extends `UseCase<T, Params>`; calls only the repository interface
    - _Requirements: 1.3, 1.4, 1.6, 1.7, 6.3_

- [ ] 6. Domain use cases — Lens, Eyewear, VisionTest, Profile
  - [ ] 6.1 Write unit tests for `GetLenses`, `SaveLens`, `DeleteLens` in `test/domain/usecases/lens/`
    - _Requirements: 2.3, 2.4, 2.5_
  - [ ] 6.2 Implement `GetLenses`, `SaveLens`, `DeleteLens` in `lib/domain/usecases/lens/`
    - _Requirements: 2.3, 2.4, 2.5, 6.3_
  - [ ] 6.3 Write unit tests for `GetEyewear`, `SaveEyewear`, `DeleteEyewear` in `test/domain/usecases/eyewear/`
    - _Requirements: 9.1, 9.6, 9.7_
  - [ ] 6.4 Implement `GetEyewear`, `SaveEyewear`, `DeleteEyewear` in `lib/domain/usecases/eyewear/`
    - _Requirements: 9.1, 9.6, 9.7, 6.3_
  - [ ] 6.5 Write unit tests for `GetVisionTests`, `SaveVisionTest` in `test/domain/usecases/vision_test/`
    - _Requirements: 8.3, 8.4_
  - [ ] 6.6 Implement `GetVisionTests`, `SaveVisionTest` in `lib/domain/usecases/vision_test/`
    - _Requirements: 8.3, 8.4, 6.3_
  - [ ] 6.7 Write unit tests for `GetProfile`, `UpdateProfile` in `test/domain/usecases/profile/`
    - _Requirements: 10.1, 10.6_
  - [ ] 6.8 Implement `GetProfile`, `UpdateProfile` in `lib/domain/usecases/profile/`
    - _Requirements: 10.1, 10.6, 6.3_

- [ ] 7. Domain use cases — Auth
  - [ ] 7.1 Write unit tests for `SignInWithGoogle`, `SignInWithApple`, `SignOut`, `GetCurrentUser` in `test/domain/usecases/auth/`
    - Use `FakeAuthRepository`; assert correct delegation and returned `UserProfile`
    - _Requirements: 11.1, 11.2_
  - [ ] 7.2 Implement `SignInWithGoogle`, `SignInWithApple`, `SignOut`, `GetCurrentUser` in `lib/domain/usecases/auth/`
    - Each extends `UseCase<T, Params>`; delegates to `AuthRepository`
    - _Requirements: 11.1, 11.2, 6.3_

- [ ] 8. Checkpoint — domain layer
  - Ensure all domain-layer tests pass with `flutter test test/domain/`
  - Verify no data-layer imports exist in `lib/domain/`
  - Ask the user if questions arise.


- [ ] 9. Data models — Hive models and serialization
  - [ ] 9.1 Write property tests for `PrescriptionModel` round-trip serialization in `test/data/models/prescription_model_test.dart`
    - **Property 1: Prescription serialization round-trip**
    - **Validates: Requirements 1.10**
  - [ ] 9.2 Implement `EyeMeasurementModel` (typeId 1) and `PrescriptionModel` (typeId 0) in `lib/data/models/`
    - Add `@HiveType`, `@HiveField` annotations; include `updatedAt: DateTime` and `pendingSync: bool` fields
    - Implement `toEntity()` and `fromEntity()` factory; run `build_runner` to generate `*.g.dart` TypeAdapters
    - _Requirements: 1.3, 1.10, 11.4_
  - [ ]* 9.3 Write unit tests for `PrescriptionModel.toEntity()` and `fromEntity()` with known fixture values
    - _Requirements: 1.10_
  - [ ] 9.4 Write property tests for `ContactLensModel` round-trip in `test/data/models/contact_lens_model_test.dart`
    - **Property 5: Contact lens serialization round-trip**
    - **Validates: Requirements 2.8**
  - [ ] 9.5 Implement `ContactLensModel` (typeId 2) in `lib/data/models/`
    - Include `updatedAt: DateTime` and `pendingSync: bool` fields
    - _Requirements: 2.3, 2.8, 11.4_
  - [ ]* 9.6 Write unit tests for `ContactLensModel` with known fixture values
    - _Requirements: 2.8_
  - [ ] 9.7 Write property tests for `VisionTestModel` round-trip in `test/data/models/vision_test_model_test.dart`
    - **Property 19: Vision test serialization round-trip**
    - **Validates: Requirements 8.8**
  - [ ] 9.8 Implement `VisionTestModel` (typeId 4), `EyewearModel` (typeId 3), and `UserProfileModel` (typeId 5) in `lib/data/models/`
    - All models include `updatedAt: DateTime` and `pendingSync: bool` fields
    - _Requirements: 8.8, 9.6, 10.1, 11.4_
  - [ ]* 9.9 Write unit tests for `EyewearModel` and `UserProfileModel` with known fixture values
    - _Requirements: 9.6, 10.1_

- [ ] 10. Data layer — local data sources
  - [ ] 10.1 Write unit tests for `PrescriptionLocalDataSource` in `test/data/datasources/prescription_local_datasource_test.dart`
    - Use an in-memory Hive box opened in a temp directory; test CRUD operations and ordering
    - _Requirements: 1.3, 1.4_
  - [ ] 10.2 Implement `PrescriptionLocalDataSource` in `lib/data/datasources/`
    - Wraps a `Box<PrescriptionModel>`; returns entities sorted by `issueDate` descending
    - _Requirements: 1.3, 1.4_
  - [ ] 10.3 Write unit tests for `LensLocalDataSource`
    - Test CRUD and ascending `expiryDate` ordering
    - _Requirements: 2.3, 2.4_
  - [ ] 10.4 Implement `LensLocalDataSource` in `lib/data/datasources/`
    - Returns lenses sorted by `expiryDate` ascending
    - _Requirements: 2.3, 2.4_
  - [ ] 10.5 Write unit tests for `EyewearLocalDataSource`, `VisionTestLocalDataSource`, and `ProfileLocalDataSource`
    - _Requirements: 9.6, 8.3, 10.1_
  - [ ] 10.6 Implement `EyewearLocalDataSource`, `VisionTestLocalDataSource`, and `ProfileLocalDataSource`
    - `VisionTestLocalDataSource` returns tests sorted by `timestamp` descending
    - _Requirements: 9.6, 8.3, 8.4, 10.1_

- [ ] 11. Data layer — remote data sources (Supabase)
  - [ ] 11.1 Write unit tests for `PrescriptionRemoteDataSource` in `test/data/datasources/prescription_remote_datasource_test.dart`
    - Use `FakePrescriptionRemoteDataSource`; test `fetchAll`, `upsert`, and `delete`
    - _Requirements: 11.4, 11.5_
  - [ ] 11.2 Implement `SupabasePrescriptionRemoteDataSource` in `lib/data/datasources/`
    - Wraps `SupabaseClient`; uses `_client.from('prescriptions').upsert(...)` and `.delete()`
    - _Requirements: 11.4, 11.5_
  - [ ] 11.3 Write unit tests for `LensRemoteDataSource`, `EyewearRemoteDataSource`, `VisionTestRemoteDataSource`, and `ProfileRemoteDataSource`
    - _Requirements: 11.4, 11.5_
  - [ ] 11.4 Implement `SupabaseLensRemoteDataSource`, `SupabaseEyewearRemoteDataSource`, `SupabaseVisionTestRemoteDataSource`, and `SupabaseProfileRemoteDataSource`
    - Same pattern as prescription remote datasource
    - _Requirements: 11.4, 11.5_


- [ ] 12. Data layer — repository implementations
  - [ ] 12.1 Write property tests for `PrescriptionRepositoryImpl` ordering and deletion in `test/data/repositories/prescription_repository_impl_test.dart`
    - **Property 3: Prescriptions retrieved in descending issue-date order**
    - **Validates: Requirements 1.4**
    - **Property 4: Deleted prescription is absent from storage**
    - **Validates: Requirements 1.7**
  - [ ] 12.2 Implement `PrescriptionRepositoryImpl` in `lib/data/repositories/`
    - Holds both `PrescriptionLocalDataSource` and `PrescriptionRemoteDataSource`
    - Normal CRUD touches only local; `syncPendingChanges()` pushes records where `pendingSync == true` to Supabase then clears the flag
    - Catches `HiveError` and rethrows as `StorageFailure`
    - _Requirements: 1.3, 1.4, 1.6, 1.7, 11.4, 11.5_
  - [ ]* 12.3 Write unit tests for `PrescriptionRepositoryImpl` CRUD with fixture data
    - _Requirements: 1.3, 1.6, 1.7_
  - [ ] 12.4 Write property tests for `LensRepositoryImpl` ordering and deletion in `test/data/repositories/lens_repository_impl_test.dart`
    - **Property 8: Lenses retrieved in ascending expiry-date order**
    - **Validates: Requirements 2.4**
    - **Property 9: Deleted lens is absent from storage**
    - **Validates: Requirements 2.5**
  - [ ] 12.5 Implement `LensRepositoryImpl` in `lib/data/repositories/`
    - Holds both local and remote datasources; same sync pattern as prescription
    - _Requirements: 2.3, 2.4, 2.5, 11.4, 11.5_
  - [ ]* 12.6 Write unit tests for `LensRepositoryImpl` CRUD
    - _Requirements: 2.3, 2.5_
  - [ ] 12.7 Write unit tests for `EyewearRepositoryImpl`, `VisionTestRepositoryImpl`, and `ProfileRepositoryImpl`
    - _Requirements: 9.6, 9.7, 8.3, 10.1_
  - [ ] 12.8 Implement `EyewearRepositoryImpl`, `VisionTestRepositoryImpl`, and `ProfileRepositoryImpl`
    - Each holds local + remote datasources and implements `syncPendingChanges()`
    - _Requirements: 9.6, 9.7, 8.3, 8.4, 10.1, 11.4, 11.5_

- [ ] 13. Data layer — Auth service and repository
  - [ ] 13.1 Write unit tests for `AuthServiceImpl` in `test/data/services/auth_service_impl_test.dart`
    - Use a fake `GoTrueClient`; test `signInWithGoogle`, `signInWithApple`, `signOut`, `getCurrentUser`, and `authStateStream` emissions
    - _Requirements: 11.1, 11.2_
  - [ ] 13.2 Implement `AuthServiceImpl` in `lib/data/services/`
    - Wraps `GoTrueClient` (supabase_flutter); delegates OAuth to `signInWithOAuth(OAuthProvider.google/apple)`
    - Maps Supabase `User` to `UserProfile`; streams auth state changes via `onAuthStateChange`
    - _Requirements: 11.1, 11.2_
  - [ ] 13.3 Write unit tests for `AuthRepositoryImpl` in `test/data/repositories/auth_repository_impl_test.dart`
    - Use `FakeAuthRepository` pattern; test delegation to `AuthService`
    - _Requirements: 11.1, 11.2_
  - [ ] 13.4 Implement `AuthRepositoryImpl` in `lib/data/repositories/`
    - Delegates all calls to `AuthServiceImpl`
    - _Requirements: 11.1, 11.2_

- [ ] 14. Data layer — Connectivity and Sync services
  - [ ] 14.1 Write unit tests for `ConnectivityServiceImpl` in `test/data/services/connectivity_service_impl_test.dart`
    - Use `fake_async` to simulate connectivity changes; verify `connectivityStream` emits correct values
    - _Requirements: 11.5, 11.9_
  - [ ] 14.2 Implement `ConnectivityServiceImpl` in `lib/data/services/`
    - Wraps `connectivity_plus`; maps `ConnectivityResult` to `bool`; broadcasts via `StreamController`
    - _Requirements: 11.5, 11.9_
  - [ ] 14.3 Write unit tests for `SyncServiceImpl` in `test/data/services/sync_service_impl_test.dart`
    - Use `FakeConnectivityService`, `FakePrescriptionRemoteDataSource`, etc.; use `fake_async` for timer-based sync trigger
    - Use `mocktail` to verify `syncPendingChanges()` is called on each repository when connectivity is restored
    - _Requirements: 11.5, 11.6, 11.7_
  - [ ] 14.4 Write property tests for sync conflict resolution
    - **Property 26: Local data written while offline is present in Supabase after sync**
    - **Validates: Requirements 11.4, 11.5**
    - **Property 27: Conflict resolution selects the record with the later updatedAt**
    - **Validates: Requirements 11.6**
  - [ ] 14.5 Implement `SyncServiceImpl` in `lib/data/services/`
    - Listens to `ConnectivityService.connectivityStream`; on `true` calls `syncPendingChanges()` on all repositories in sequence
    - `pullRemoteData()` fetches all records for the authenticated user from each remote datasource and upserts into Hive
    - Conflict resolution: if remote `updatedAt` > local `updatedAt`, overwrite local; otherwise push local to remote
    - Individual record failures are logged; `pendingSync` flag is not cleared on failure
    - _Requirements: 11.5, 11.6, 11.7, 11.9_

- [ ] 15. Checkpoint — data layer
  - Ensure all data-layer tests pass with `flutter test test/data/`
  - Ask the user if questions arise.


- [ ] 16. Notification service
  - [ ] 16.1 Write unit tests for `NotificationServiceImpl` in `test/data/services/notification_service_impl_test.dart`
    - Use a fake `FlutterLocalNotificationsPlugin` to capture scheduled notifications
    - Use `fake_async` to advance the clock to the scheduled delivery time
    - Test that scheduling is blocked when permission is denied
    - _Requirements: 3.1, 3.2, 3.3, 3.4_
  - [ ] 16.2 Write property tests for notification scheduling time
    - **Property 10: Notification scheduled time is one day before expiry at 09:00**
    - **Validates: Requirements 3.1**
    - **Property 11: Notification permission gate**
    - **Validates: Requirements 3.3, 3.4**
  - [ ] 16.3 Implement `NotificationServiceImpl` in `lib/data/services/`
    - `init()` sets up Android channel and iOS permissions
    - `scheduleExpiryNotification` schedules at `expiryDate - 1 day` at 09:00 local time using `timezone` package; notification id = `lensId.hashCode`; payload = `lensId`
    - `cancelNotification` cancels by id
    - _Requirements: 3.1, 3.2, 3.3, 3.4, 3.6, 3.7_

- [ ] 17. Google Calendar service
  - [ ] 17.1 Write unit tests for `CalendarServiceImpl` in `test/data/services/calendar_service_impl_test.dart`
    - Use a fake `CalendarApi` and `GoogleSignIn`; test sign-in, event creation, deletion, and error propagation
    - Use `mocktail` to verify call counts on `CalendarApi`
    - _Requirements: 4.1, 4.2, 4.3, 4.4_
  - [ ] 17.2 Write property tests for calendar service
    - **Property 12: Calendar event create-then-delete round-trip**
    - **Validates: Requirements 4.1, 4.2**
    - **Property 13: Calendar API error propagates as error state**
    - **Validates: Requirements 4.4**
  - [ ] 17.3 Implement `CalendarServiceImpl` in `lib/data/services/`
    - OAuth scope: `https://www.googleapis.com/auth/calendar.events` only
    - `createEvent` creates an all-day event titled "Replace \${lens.label} lenses" on `lens.expiryDate`; returns `eventId`
    - HTTP 401/403 → emit `CalendarAuthState.unauthorized`; other errors → emit `CalendarAuthState.error` with code
    - _Requirements: 4.1, 4.2, 4.3, 4.4, 4.5_

- [ ] 18. Auth Cubit
  - [ ] 18.1 Write unit tests for `AuthCubit` in `test/presentation/auth/auth_cubit_test.dart`
    - Use `FakeAuthRepository`; test state sequence for `signInWithGoogle`, `signInWithApple`, `signOut`, and `getCurrentUser`
    - Use `bloc_test` `emitsInOrder` assertions
    - Test that `AuthAuthenticated` carries the correct `UserProfile`
    - _Requirements: 11.1, 11.2, 11.8_
  - [ ] 18.2 Write property tests for `AuthCubit`
    - **Property 25: Successful sign-in emits AuthAuthenticated with correct UserProfile**
    - **Validates: Requirements 11.2**
  - [ ] 18.3 Implement `AuthCubit` and `AuthState` in `lib/presentation/auth/cubit/`
    - States: `AuthInitial`, `AuthLoading`, `AuthAuthenticated(UserProfile)`, `AuthUnauthenticated`, `AuthError`
    - On init: call `GetCurrentUser`; emit `AuthAuthenticated` or `AuthUnauthenticated`
    - On sign-out: call `SignOut`, clear all Hive boxes, emit `AuthUnauthenticated`
    - _Requirements: 11.1, 11.2, 11.8_

- [ ] 19. Prescription Cubit
  - [ ] 19.1 Write unit tests for `PrescriptionCubit` in `test/presentation/prescription/prescription_cubit_test.dart`
    - Use `FakePrescriptionRepository`; test state sequence for load, save, update, delete, and validation error
    - Use `bloc_test` `emitsInOrder` assertions
    - _Requirements: 1.8, 1.9_
  - [ ] 19.2 Write property tests for `PrescriptionCubit`
    - **Property 2: Prescription field validation rejects out-of-range values**
    - **Validates: Requirements 1.1, 1.8**
    - **Property 16: Cubit state transitions are deterministic**
    - **Validates: Requirements 6.7**
  - [ ] 19.3 Implement `PrescriptionCubit` and `PrescriptionState` in `lib/presentation/prescription/cubit/`
    - States: `PrescriptionInitial`, `PrescriptionLoading`, `PrescriptionLoaded`, `PrescriptionValidationError`, `PrescriptionError`
    - Validate all `EyeMeasurement` fields before invoking use cases; emit `PrescriptionValidationError` with field name on failure
    - _Requirements: 1.8, 1.9, 6.4_
  - [ ]* 19.4 Write property test for `PrescriptionCubit` error propagation
    - **Property 22: Repository error propagates to cubit error state**
    - **Validates: Requirements 8.6**


- [ ] 20. Lens Cubit
  - [ ] 20.1 Write unit tests for `LensCubit` in `test/presentation/lens/lens_cubit_test.dart`
    - Test state sequence for load, save, delete, and invalid lifespan validation
    - _Requirements: 2.6, 2.7_
  - [ ] 20.2 Write property tests for `LensCubit`
    - **Property 6: Expiry date equals opening date plus lifespan**
    - **Validates: Requirements 2.2**
    - **Property 7: Invalid lens lifespan triggers validation error**
    - **Validates: Requirements 2.6**
  - [ ] 20.3 Implement `LensCubit` and `LensState` in `lib/presentation/lens/cubit/`
    - States: `LensInitial`, `LensLoading`, `LensLoaded`, `LensValidationError`, `LensError`
    - Validate `lifespanDays` ∈ {1, 7, 14, 30, 90} before saving; compute `expiryDate = openingDate + lifespanDays`
    - After successful save, call `NotificationService.scheduleExpiryNotification`
    - After successful delete, call `NotificationService.cancelNotification`
    - _Requirements: 2.2, 2.6, 2.7, 3.1, 3.2_

- [ ] 21. VisionTest Cubit
  - [ ] 21.1 Write unit tests for `VisionTestCubit` in `test/presentation/vision_test/vision_test_cubit_test.dart`
    - Test: initial load, start test (step progression 1→2→3), complete test (persists record), filter change, error state
    - _Requirements: 8.1, 8.2, 8.3, 8.4, 8.5, 8.6, 8.7_
  - [ ] 21.2 Write property tests for `VisionTestCubit`
    - **Property 20: Saved test record contains valid fields**
    - **Validates: Requirements 8.3**
    - **Property 21: Test history filter excludes non-matching records**
    - **Validates: Requirements 8.5**
  - [ ] 21.3 Implement `VisionTestCubit` and `VisionTestState` in `lib/presentation/vision_test/cubit/`
    - States: `VisionTestInitial`, `VisionTestLoading`, `VisionTestLoaded`, `VisionTestInProgress` (with `currentStep` 1–3), `VisionTestError`
    - `VisionTestLoaded` carries `tests` list and active `filter` string
    - Filter logic: "Week" = last 7 days, "Month" = last 30 days, "All" = no filter
    - _Requirements: 8.1, 8.2, 8.3, 8.4, 8.5, 8.6, 8.7_

- [ ] 22. Eyewear Cubit
  - [ ] 22.1 Write unit tests for `EyewearCubit` in `test/presentation/eyewear/eyewear_cubit_test.dart`
    - Test load, save (with validation), delete, and prescription currency check
    - _Requirements: 9.1, 9.6, 9.7, 9.8_
  - [ ] 22.2 Write property tests for `EyewearCubit`
    - **Property 23: Prescription status banner reflects currency**
    - **Validates: Requirements 9.3**
  - [ ] 22.3 Implement `EyewearCubit` and `EyewearState` in `lib/presentation/eyewear/cubit/`
    - States: `EyewearInitial`, `EyewearLoading`, `EyewearLoaded`, `EyewearValidationError`, `EyewearError`
    - Validate required fields (label, prescription) before saving
    - _Requirements: 9.1, 9.6, 9.7, 9.8_

- [ ] 23. Profile Cubit
  - [ ] 23.1 Write unit tests for `ProfileCubit` in `test/presentation/profile/profile_cubit_test.dart`
    - Test load, update username, and greeting string generation
    - _Requirements: 10.1, 10.6_
  - [ ] 23.2 Write property tests for `ProfileCubit`
    - **Property 17: Greeting always reflects current username**
    - **Validates: Requirements 7.1, 10.6**
  - [ ] 23.3 Implement `ProfileCubit` and `ProfileState` in `lib/presentation/profile/cubit/`
    - States: `ProfileInitial`, `ProfileLoading`, `ProfileLoaded`, `ProfileError`
    - _Requirements: 10.1, 10.6_

- [ ] 24. Home Cubit
  - [ ] 24.1 Write unit tests for `HomeCubit` in `test/presentation/home/home_cubit_test.dart`
    - Test that `HomeState` is populated with latest prescription, nearest expiring lens, eyewear list, and upcoming events
    - Test days-remaining calculation
    - _Requirements: 7.1, 7.2, 7.3, 7.4, 7.6, 7.7_
  - [ ] 24.2 Write property tests for `HomeCubit`
    - **Property 18: Lens days-remaining calculation is correct**
    - **Validates: Requirements 7.2**
  - [ ] 24.3 Implement `HomeCubit` and `HomeState` in `lib/presentation/home/cubit/`
    - `HomeState` holds: `profile`, `latestPrescription`, `nearestExpiringLens`, `eyewear`, `upcomingEvents`, `isLoading`, `error`
    - On load: fetch profile, latest prescription, lenses (pick nearest expiry), eyewear, and calendar events
    - _Requirements: 7.1, 7.2, 7.3, 7.4, 7.6, 7.7_

- [ ] 25. Checkpoint — Cubit and service layer
  - Ensure all Cubit and service tests pass with `flutter test test/presentation/ test/data/services/`
  - Ask the user if questions arise.


- [ ] 26. Navigation — go_router setup with auth route guard
  - [ ] 26.1 Write unit tests for router behaviour in `test/presentation/router/app_router_test.dart`
    - Test unknown route redirects to `/home`
    - Test tab index 0–3 maps to correct top-level routes
    - Test that unauthenticated state redirects any protected route to `/sign-in`
    - Test that authenticated state on `/sign-in` redirects to `/home`
    - _Requirements: 5.3, 5.4, 11.3_
  - [ ] 26.2 Write property tests for router
    - **Property 14: Unknown route redirects to home**
    - **Validates: Requirements 5.4**
    - **Property 15: Tab navigation routes to correct screen**
    - **Validates: Requirements 5.2**
    - **Property 24: Unauthenticated user is always redirected to sign-in**
    - **Validates: Requirements 11.3**
  - [ ] 26.3 Implement `AppRouter` / `app_router.dart` in `lib/presentation/router/`
    - Use `StatefulShellRoute.indexedStack` for the 4-tab Bottom Navigation Bar shell
    - Route guard in `redirect`: if `AuthCubit` state is `AuthUnauthenticated` and route is not `/sign-in`, return `/sign-in`; if authenticated and on `/sign-in`, return `/home`
    - Define all named routes: `signIn`, `home`, `quickEyeTest`, `eyewearList`, `eyewearDetail`, `eyewearForm`, `lensList`, `lensDetail`, `lensForm`, `prescriptionList`, `prescriptionDetail`, `prescriptionForm`, `prescriptionEdit`, `profile`, `settings`, `notifications`
    - `errorBuilder` redirects to `HomeScreen`
    - Wire `onDidReceiveNotificationResponse` payload to `router.go('/lenses/\$lensId')`
    - _Requirements: 5.1, 5.2, 5.3, 5.4, 5.5, 5.6, 5.7, 11.3_
  - [ ] 26.4 Implement `ScaffoldWithNavBar` widget that renders the `BottomNavigationBar` with 4 tabs (Home, Quick Eye Test, Eyewear/Lenses, Profile) and highlights the active tab
    - _Requirements: 5.1, 5.2_

- [ ] 27. Presentation — Sign-in screen
  - [ ] 27.1 Implement `SignInScreen` in `lib/presentation/auth/screens/`
    - "Sign in with Google" and "Sign in with Apple" buttons; each calls the corresponding `AuthCubit` method
    - Shows loading indicator on `AuthLoading` state
    - Shows inline error message on `AuthError` state
    - On `AuthAuthenticated`, router guard automatically redirects to `/home`
    - _Requirements: 11.1, 11.2_

- [ ] 28. Presentation — Prescription screens
  - [ ] 28.1 Implement `PrescriptionListScreen` in `lib/presentation/prescription/screens/`
    - Displays list of prescriptions ordered by issue date descending; each item shows label and issue date
    - FAB navigates to `prescriptionForm`
    - _Requirements: 1.4, 1.5_
  - [ ] 28.2 Implement `PrescriptionDetailScreen`
    - Displays all field values for both eyes; edit button navigates to `prescriptionEdit`
    - _Requirements: 1.5_
  - [ ] 28.3 Implement `PrescriptionFormScreen`
    - Form fields for label, issue date, and all `EyeMeasurement` fields for both eyes with range validation feedback
    - On submit: calls `PrescriptionCubit.save` or `update`; shows `SnackBar` on error state
    - Pre-populates fields when opened in edit mode
    - _Requirements: 1.1, 1.2, 1.6, 1.8, 7.5, 7.8_

- [ ] 29. Presentation — Lens screens
  - [ ] 29.1 Implement `LensListScreen` in `lib/presentation/lens/screens/`
    - Displays lenses ordered by expiry date ascending; each item shows label and days remaining
    - FAB navigates to `lensForm`
    - _Requirements: 2.4, 7.9_
  - [ ] 29.2 Implement `LensDetailScreen`
    - Shows lens details; delete button triggers `LensCubit.delete`; toggle for Google Calendar integration calls `CalendarService.createEvent` / `deleteEvent`
    - Shows explanation text before requesting calendar permission (req 4.6)
    - _Requirements: 2.5, 4.1, 4.2, 4.6_
  - [ ] 29.3 Implement lens creation form (inline in `LensDetailScreen` or separate `LensFormScreen`)
    - Fields: label, opening date, lifespan picker (1/7/14/30/90 days)
    - On submit: calls `LensCubit.save`; shows validation error inline
    - _Requirements: 2.1, 2.6_

- [ ] 30. Presentation — Eyewear screens
  - [ ] 30.1 Implement `EyewearListScreen` in `lib/presentation/eyewear/screens/`
    - Lists all eyewear records; FAB navigates to `eyewearForm`
    - _Requirements: 9.1, 9.5_
  - [ ] 30.2 Implement `EyewearDetailScreen`
    - Shows associated prescription with OS/OD toggle; status banner ("Current" / "Update Recommended") based on prescription currency check; test history list ordered by timestamp descending
    - _Requirements: 9.2, 9.3, 9.4_
  - [ ] 30.3 Implement eyewear creation form
    - Fields: label, prescription selector (from existing prescriptions)
    - On submit: calls `EyewearCubit.save`; shows validation error inline
    - _Requirements: 9.6, 9.8_

- [ ] 31. Presentation — Quick Eye Test screen
  - [ ] 31.1 Implement `VisionTestScreen` in `lib/presentation/vision_test/screens/`
    - Shows "Start Test" button and test statistics section
    - Guided 3-step flow: each step shows instructions and a "Next" / "Complete" button; tracks `currentStep` via `VisionTestCubit`
    - After completion, persists result and returns to loaded state showing updated history
    - Test history list with filter control (All / Week / Month)
    - _Requirements: 8.1, 8.2, 8.3, 8.4, 8.5_

- [ ] 32. Presentation — Home screen
  - [ ] 32.1 Implement `HomeScreen` in `lib/presentation/home/screens/`
    - Personalised greeting from `HomeCubit` state (e.g. "Good Morning, Thanasis")
    - Lens alert banner (visible only when a lens record exists) showing days remaining to nearest expiry
    - Current prescription summary card with edit shortcut navigating to `prescriptionEdit`
    - Horizontally scrollable eyewear collection section (visible only when eyewear records exist)
    - Upcoming events section ordered by date ascending
    - "Add New Prescription" and "Add New Lenses" quick action buttons
    - Notification bell icon → `/notifications`; settings icon → `/settings`
    - _Requirements: 7.1, 7.2, 7.3, 7.4, 7.5, 7.6, 7.7, 7.8, 7.9, 7.10, 7.11_

- [ ] 33. Presentation — Profile screen
  - [ ] 33.1 Implement `ProfileScreen` in `lib/presentation/profile/screens/`
    - Username display with inline edit option; on confirm calls `ProfileCubit.updateUsername`
    - Current prescription summary with OS/OD toggle
    - Profile insights widget: circular progress for days to nearest lens expiry, total test count, total eyewear count
    - Calendar Events section with count and navigation arrow → calendar events list
    - Prescription History section with navigation arrow → `prescriptionList`
    - _Requirements: 10.1, 10.2, 10.3, 10.4, 10.5, 10.6_

- [ ] 34. Dependency injection wiring
  - [ ] 34.1 Annotate all repository implementations, service implementations, use cases, and Cubits with `@injectable`, `@lazySingleton`, or `@singleton` as appropriate
    - Repositories and services: `@lazySingleton`; use cases and Cubits: `@injectable` (factory)
    - Include `AuthServiceImpl`, `SyncServiceImpl`, `ConnectivityServiceImpl`, `AuthRepositoryImpl`, and all remote datasources
    - _Requirements: 6.6_
  - [ ] 34.2 Run `build_runner build` to generate `injection.config.dart`
    - Verify `configureDependencies()` registers all bindings without conflicts
    - _Requirements: 6.6_
  - [ ] 34.3 Implement `lib/app.dart` with `MaterialApp.router` wired to `AppRouter`
    - Wrap with `MultiBlocProvider` providing `AuthCubit` at the top level so the route guard can read its state
    - _Requirements: 5.1, 11.3_
  - [ ] 34.4 Implement `lib/main.dart`
    - Initialise Hive and register all TypeAdapters before `runApp`
    - Initialise `Supabase.initialize(url, anonKey)` before `runApp`
    - Call `configureDependencies()`
    - Initialise `NotificationServiceImpl` (sets up channels)
    - Initialise `tz.initializeTimeZones()` for timezone-aware notification scheduling
    - _Requirements: 6.1_

- [ ] 35. Final checkpoint — full test suite and coverage
  - Run `flutter test --coverage` and verify ≥ 80% line coverage on `lib/domain/` and `lib/data/`
  - Fix any failing tests or coverage gaps
  - Ensure all property-based tests run a minimum of 100 iterations
  - Ask the user if questions arise.

## Notes

- Tasks marked with `*` are optional and can be skipped for a faster MVP
- Every production code task is preceded by its corresponding test task (TDD)
- Property tests use the `glados` library and are tagged with `// Feature: eye-health-manager, Property N: <text>`
- All repository and datasource tests use hand-written `Fake*` implementations — no `mockito` code generation
- `mocktail` is used for services where call-count verification is needed (`NotificationService`, `SyncService`, `CalendarService`)
- `fake_async` is used for time-dependent tests (notification scheduling, sync timer)
- Checkpoints validate incremental progress before moving to the next layer
- Coverage is measured with `flutter test --coverage` and reported via `lcov`

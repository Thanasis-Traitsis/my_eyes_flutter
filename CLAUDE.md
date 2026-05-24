# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# Run the app
flutter run

# Run all tests
flutter test

# Run a single test file
flutter test test/presentation/eyewear/eyewear_cubit_test.dart

# Analyze (lint)
flutter analyze

# Regenerate code (Hive adapters + injectable DI config)
dart run build_runner build --delete-conflicting-outputs
```

Code generation must be re-run whenever you add or change a `@HiveType`/`@HiveField` model or any `@injectable`/`@singleton`/`@LazySingleton` annotation. The generated files are `*.g.dart`, `injection.config.dart`, and `hive_registrar.g.dart`.

## Architecture

The app follows Clean Architecture with three layers:

**Domain** (`lib/domain/`) — pure Dart, no Flutter imports. Contains:
- `entities/` — Equatable value objects (e.g. `EyewearItem`, `EyewearTest`, `Prescription`)
- `repositories/` — abstract interfaces only
- `enums/` — shared enums like `EyewearCategory`, `LensType`

**Data** (`lib/data/`) — implements the domain interfaces. Contains:
- `models/` — Hive-annotated models with `.g.dart` adapters; each has `toEntity()` and `fromEntity()` methods mapping to/from domain entities
- `datasources/` — raw Hive box operations (one class per box)
- `repositories/` — `@LazySingleton` implementations of domain repository interfaces, delegating to datasources and mapping models↔entities

**Presentation** (`lib/presentation/`) — Flutter UI. Each feature folder (`eyewear/`, `profile/`, `test_history/`, etc.) contains:
- `cubit/` — `@singleton` Cubits that call domain repositories; states use Equatable
- `screens/` — full-page widgets; split loaded/empty/error views are in the same folder
- `widgets/` — feature-specific reusable widgets

**Core** (`lib/core/`) — cross-cutting concerns: constants, router, theme, network (connectivity), storage setup, validators, and utility extensions.

## Dependency Injection

`get_it` + `injectable` manage DI. Register dependencies with `@singleton`, `@lazySingleton`, or `@injectable`. External dependencies (Hive boxes, SharedPreferences, Connectivity) are registered via the `RegisterModule` in `lib/injection.dart`. After changing registrations, run `build_runner`.

## Storage

Hive CE is the only persistence layer (no remote API). Each domain concept has its own typed box opened at startup in `lib/injection.dart`. Box keys are in `lib/core/constants/app_keys.dart`.

## Navigation

`go_router` with `StatefulShellRoute.indexedStack` for the four bottom-nav tabs (Home, Eye Test, Eyewear, Profile). Full-screen routes (edit screens, test history, new test) are declared as top-level `GoRoute`s with `parentNavigatorKey: AppKeys.rootNavigatorKey`. Screen arguments are passed via `state.extra` with typed casts. New routes must be added to `AppRoutes` (path constants), `AppPages` (builder registry), and `AppRouter` (the GoRouter config).

## Dev Seeder

`DevSeeder.seed()` runs automatically in debug mode on every launch, wiping and re-seeding eyewear and tests while preserving an existing profile/prescription. Useful for rapid UI iteration; disable per-run by commenting out the `kDebugMode` block in `main.dart`.

## Testing

Tests mirror the `lib/` directory structure under `test/`. Cubits are tested with `bloc_test`, repositories/datasources with plain `flutter_test`. Mocks use `mocktail` — define a `Mock` class and a `Fake` fallback value for any type passed to `any()`. Do not use `mockito`.

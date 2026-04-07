# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Flutter HRM (Human Resource Management) application — an IT request and HR management mobile app supporting Android, iOS, web, and desktop. Uses FVM (Flutter Version Management) pinned to Flutter 3.32.5.

## Common Commands

```bash
# First-time setup (sets FVM version, gets deps, runs code gen)
make init

# Code generation (json_serializable, freezed, injectable, copy_with, flutter_gen)
make gen-code
# Or directly:
flutter pub run build_runner build --delete-conflicting-outputs

# Run the app (default/production flavor)
flutter run

# Build APKs by flavor
make build-apk-uat          # UAT: uses main.uat.dart
make build-apk-staging      # Staging: uses main.staging.dart
make build-apk-production   # Production: uses main.dart

# Build iOS IPAs
make build-ipa-uat
make build-ipa-staging
make build-ipa              # Production

# Run analysis
flutter analyze

# Clean and reinitialize
make clean

# Set up git hooks (commit message validation)
make git-hook
```

## Architecture

**Clean Architecture** with three layers:

- **Domain** (`lib/domain/`) — Entities annotated with `@JsonSerializable()`, `@CopyWith()`, `@Equatable()`. No external dependencies.
- **Data** (`lib/data/`) — Repositories, API services (Dio-based), request/response models. Repositories implement domain interfaces.
- **Presentation** (`lib/presentations/`) — Pages, widgets, and BLoCs/Cubits organized by feature.

### State Management: BLoC + Cubit

BLoCs/Cubits (~30+) are registered via `MultiBlocProvider` in `lib/presentations/bloc/main_bloc.dart`, split into `coreBlocs()` (auth, theme, language — always loaded) and `featureBlocs()` (lazy). Auth state uses `HydratedBloc` for persistence across sessions.

Use `BlocErrorHandlerMixin` (`lib/common/mixins/bloc_error_handler_mixin.dart`) for shared error handling in BLoCs — call `extractErrorCode(e)` in catch blocks instead of duplicating `RemoteException` parsing.

BLoCs should NOT handle navigation, toasts, or dialogs. Emit error state and let the UI react via `BlocListener`.

### Dependency Injection: GetIt + Injectable

- Service locator configured in `lib/common/configs/locators.dart`
- Access services via `dI<T>()` global function
- Register with `@LazySingleton`, `@Injectable` annotations
- DI container auto-generated as `locators.config.dart`

### Routing: GoRouter

- Routes defined in `lib/common/routers/pages.dart` (50+ routes)
- Router singleton in `lib/common/routers/router.dart` (`@lazySingleton AppRouters`)

### API Layer

Multi-backend microservice architecture with 7 base URLs configured via environment:
`BASE_AUTH_URL`, `BASE_USER_URL`, `BASE_REQUEST_URL`, `BASE_SYSTEM_URL`, `BASE_NOTIFICATION_URL`, `BASE_SYSTEM_GATEWAY_URL`, `BASE_STORAGE_URL`

Dio clients in `lib/data/source/api/client/` with interceptors for:
- Access token injection (`AccessTokenInterceptor`)
- Auto token refresh on 401 (`RefreshTokenInterceptor`)
- Connectivity checks (`ConnectivityInterceptor`)

Response mapping via `BaseSuccessResponseMapper` supporting `DataResponse<T>`, `DataListResponse<T>`, `DataListRecordPagingResponse<T>`.

### Multi-Flavor Setup

Three entry points: `main.dart` (production), `main.staging.dart`, `main.uat.dart`. Environment configs loaded from `assets/env/` via `flutter_dotenv`.

### Localization

English and Vietnamese via ARB files in `lib/l10n/`. Generated localizations in `lib/l10n/gen/`.

### Shared Packages

`packages/` contains reusable modules: `themes/`, `widgets/`, `common/` (git submodule).

## Code Generation

Generated files (`*.g.dart`, `*.freezed.dart`, `locators.config.dart`, `assets.gen.dart`) must be regenerated after modifying annotated classes. Always run `make gen-code` after changes to:
- `@JsonSerializable()` entities/models
- `@freezed` classes
- `@injectable`/`@lazySingleton` services
- Asset files

## Git Conventions

Commit messages must match pattern: `Fsel-####`, `merge`, `hotfix`, `feature`, `story`, `task`, `bug`, or `update` (enforced by `.githooks/commit-msg`). Run `make git-hook` to activate hooks.

## CI/CD

GitLab CI (`.gitlab-ci.yml`) with stages: test, build_testing, build_beta, build_production. Deploys via Fastlane to AppCenter.

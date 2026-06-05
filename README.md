# Society Management

Flutter mobile app for society management: residents, visitors, maintenance, complaints, banquet hall, directory, and settings.

| Item | Value |
|------|--------|
| **Package** | `society_managment` |
| **Version** | 1.0.0+1 |
| **Dart SDK** | ^3.12.0 |
| **State management** | `flutter_bloc` |
| **UI scaling** | `flutter_screenutil` |
| **Charts** | `fl_chart` |

---

## Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (stable, compatible with Dart 3.12+)
- [Xcode](https://developer.apple.com/xcode/) (macOS, for iOS)
- [Android Studio](https://developer.android.com/studio) + Android SDK (for Android)
- [CocoaPods](https://cocoapods.org/) (for iOS: `sudo gem install cocoapods`)

Verify setup:

```bash
flutter doctor
flutter doctor -v
```

---

## Project setup

Clone the repo and install dependencies:

```bash
cd society_managment
flutter pub get
```

### iOS (first time or after native dependency changes)

```bash
cd ios
pod install
cd ..
```

### Localization (after editing `lib/l10n/app_en.arb`)

```bash
flutter gen-l10n
```

### Native splash (after changing `flutter_native_splash` in `pubspec.yaml`)

```bash
dart run flutter_native_splash:create
```

---

## Run the app

### List devices

```bash
flutter devices
```

### Debug run

```bash
# Default device
flutter run

# Specific device
flutter run -d <device_id>

# Examples
flutter run -d chrome
flutter run -d "iPhone 16"
flutter run -d emulator-5554
```

### Run with release mode (performance testing)

```bash
flutter run --release
```

### Hot reload / restart (while `flutter run` is active)

| Action | Command |
|--------|---------|
| Hot reload | `r` |
| Hot restart | `R` |
| Quit | `q` |

---

## Code quality & tests

```bash
# Analyze whole project
flutter analyze

# Analyze a folder
dart analyze lib/features/maintenance/

# Format code
dart format lib test

# Check format without writing
dart format --set-exit-if-changed lib test

# Run tests
flutter test

# Run a single test file
flutter test test/widget_test.dart
```

---

## Dependencies

```bash
# Install / update packages from pubspec.yaml
flutter pub get

# Upgrade to latest compatible versions
flutter pub upgrade

# Show outdated packages
flutter pub outdated

# Add a package
flutter pub add <package_name>

# Add dev dependency
flutter pub add dev:<package_name>
```

---

## Build (APK / IPA / App Bundle)

### Android

```bash
# Debug APK
flutter build apk --debug

# Release APK
flutter build apk --release

# Release App Bundle (Play Store)
flutter build appbundle --release
```

Output paths:

- APK: `build/app/outputs/flutter-apk/`
- AAB: `build/app/outputs/bundle/release/`

### iOS

```bash
# Release build (no codesign)
flutter build ios --release --no-codesign

# Open Xcode for archive / signing
open ios/Runner.xcworkspace
```

---

## Clean & repair

Use when builds fail or caches are stale:

```bash
flutter clean
flutter pub get

# iOS pods reset
cd ios
rm -rf Pods Podfile.lock
pod install
cd ..

# Full pub cache repair (if packages are corrupted)
flutter pub cache repair
```

---

## Project structure

```
lib/
├── app/                    # App entry (MaterialApp, ScreenUtil)
├── core/                   # Theme, widgets, constants, utils
├── data/                   # API, interceptors
├── features/               # Feature modules (screens + cubits)
│   ├── auth/
│   ├── dashboard/
│   ├── directory/
│   ├── home/
│   ├── maintenance/        # Overview, income, expense, FAB forms
│   ├── menu/               # Complaints, banquet, notices, etc.
│   ├── onboarding/
│   ├── setting/
│   └── visitor/            # main_visitor, guard_visitor, user_visitor
├── l10n/                   # ARB files (app_en.arb)
├── service/                # Routes, API, preferences
└── society_managment.dart  # Barrel exports
```

---

## Main routes

| Route | Screen |
|-------|--------|
| `/` | Splash |
| `/onboarding` | Onboarding |
| `/sign_in` | Sign in |
| `/otp_verification` | OTP |
| `/dashboard` | Dashboard (bottom nav) |
| `/home` | Home |
| `/menu` | Menu |
| `/complaints` | Complaints |
| `/banquet_hall` | Banquet hall |
| `/maintenance` | Maintenance (tabs) |
| `/add_maintenance_reminder` | Add maintenance reminder |
| `/add_income` | Add income |
| `/add_expense` | Add expense |
| `/guard_add_visitor` | Guard add visitor |
| `/user_add_visitor` | User add visitor |
| `/setting` | Settings |
| `/my_profile` | My profile |
| `/edit_profile` | Edit profile |
| `/family_members` | Family members |

Routes are registered in `lib/service/route_service.dart`.

---

## Development notes

- **UI**: Do not change spacing/colors unless requested; reuse `AppColors`, `CommonOverviewCard`, `AppTextField`, etc.
- **State**: Use existing `Cubit` + `BlocProvider` pattern; avoid new state libraries.
- **Strings**: Add keys to `lib/l10n/app_en.arb`, then run `flutter gen-l10n`.
- **Assets**: Place files under `assets/icons/`, `assets/images/`, `assets/fonts/` and declare in `pubspec.yaml` if adding new folders.
- **Cursor rules**: See `.cursor/rules/project-rules.mdc` for AI/editor conventions.

---

## Useful Flutter commands (quick reference)

```bash
flutter doctor
flutter pub get
flutter gen-l10n
flutter run
flutter analyze
flutter test
flutter clean
flutter build apk --release
flutter build appbundle --release
flutter build ios --release
dart run flutter_native_splash:create
```

---

## Troubleshooting

| Issue | Try |
|-------|-----|
| Pod install fails (iOS) | `cd ios && pod repo update && pod install` |
| Gradle / Android build error | `flutter clean && flutter pub get` |
| Missing generated l10n | `flutter gen-l10n` |
| Simulator not listed | Open Simulator app or `xcrun simctl list devices` |
| Permission / signing (iOS) | Configure team in Xcode → Runner → Signing |

---

## Resources

- [Flutter documentation](https://docs.flutter.dev/)
- [Bloc library](https://bloclibrary.dev/)
- [fl_chart](https://github.com/imaNNeoFighT/fl_chart)

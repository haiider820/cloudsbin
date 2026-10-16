import 'package:flutter/foundation.dart';

/// DEMO mode: serves sample data from an in-memory Dio adapter so the app can
/// be explored without a backend. Enabled via `--dart-define=DEMO=true`; debug
/// builds default to it, release builds default to off.
///
///   * See it now:        flutter run
///   * Force demo:        flutter run --dart-define=DEMO=true
///   * Use the real API:  flutter run --dart-define=DEMO=false \
///                          --dart-define=API_BASE_URL=https://host/api/v1
const bool kDemoMode = bool.fromEnvironment('DEMO', defaultValue: kDebugMode);

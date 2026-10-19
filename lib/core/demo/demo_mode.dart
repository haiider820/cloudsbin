/// DEMO mode: serves sample data from an in-memory Dio adapter so the app can
/// be explored without a backend. Enabled via `--dart-define=DEMO=true`.
/// Defaults to OFF: the app talks to the live backend ([apiBaseUrl]).
///
///   * Use the live API (default): flutter run
///   * Force demo:                 flutter run --dart-define=DEMO=true
///   * Override the API host:      flutter run --dart-define=API_BASE_URL=https://host/api/v1
const bool kDemoMode = bool.fromEnvironment('DEMO', defaultValue: false);

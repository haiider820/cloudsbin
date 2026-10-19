/// Phase 12 — push notification stub.
///
/// The v1 `/push/register`, `/push/unregister` (and the `/admin/push/*`
/// twins) are broken server-side: they return HTTP 200 with a PHP fatal
/// because the bootstrap require depth is wrong (see COVERAGE.md §6.35).
///
/// Nothing in the app may call those endpoints until the backend is fixed.
/// When they are fixed, register the FCM/APNs token here after sign-in and
/// unregister it on logout, then delete this file.
abstract final class PushStub {
  const PushStub._();

  /// Push is intentionally not wired: the v1 endpoints are broken.
  static bool get isAvailable => false;
}

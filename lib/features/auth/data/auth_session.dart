import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/storage/secure_storage.dart';

enum SessionStatus { unknown, unauthenticated, authenticated }

class SessionState {
  const SessionState({required this.status, this.email});

  final SessionStatus status;
  final String? email;

  bool get isAuthenticated => status == SessionStatus.authenticated;

  static const SessionState unknown = SessionState(status: SessionStatus.unknown);
  static const SessionState unauthenticated =
      SessionState(status: SessionStatus.unauthenticated);
}

/// Tracks the user audience auth state for the router redirect and the
/// `onSessionExpired` callback wired into [ApiClient].
class SessionNotifier extends Notifier<SessionState> {
  @override
  SessionState build() => SessionState.unknown;

  /// Reads persisted tokens to decide the initial route.
  Future<void> bootstrap() async {
    final token = await ref.read(secureStorageProvider).readAccessToken(TokenKeys.user);
    state = (token != null && token.isNotEmpty)
        ? const SessionState(status: SessionStatus.authenticated)
        : SessionState.unauthenticated;
  }

  void markAuthenticated({String? email}) {
    state = SessionState(status: SessionStatus.authenticated, email: email);
  }

  /// Clears tokens and marks the session dead. Used by logout and by the
  /// interceptor's unrecoverable-401 path.
  Future<void> logoutLocal() async {
    await ref.read(secureStorageProvider).clearTokens(TokenKeys.user);
    state = SessionState.unauthenticated;
  }
}

final sessionProvider =
    NotifierProvider<SessionNotifier, SessionState>(SessionNotifier.new);

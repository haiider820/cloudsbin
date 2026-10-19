import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_error.dart';
import '../../../shared/enums/app_enums.dart';
import '../data/models/power_action.dart';
import '../data/models/power_response.dart';
import '../data/server_repository.dart';

/// Lifecycle of one power-action attempt for one server.
enum PowerActionPhase { idle, loading, success, error }

/// Immutable view of the latest power-action attempt.
///
/// `idle → loading → success | error` — [action] is set while loading so the
/// UI can spin only the tapped button.
class PowerActionState {
  const PowerActionState._({
    required this.phase,
    this.action,
    this.response,
    this.error,
  });

  const PowerActionState.idle() : this._(phase: PowerActionPhase.idle);

  const PowerActionState.loading(PowerAction action)
      : this._(phase: PowerActionPhase.loading, action: action);

  const PowerActionState.success(PowerResponse response)
      : this._(phase: PowerActionPhase.success, response: response);

  const PowerActionState.error(ApiError error)
      : this._(phase: PowerActionPhase.error, error: error);

  final PowerActionPhase phase;

  /// The in-flight action while [phase] is loading.
  final PowerAction? action;
  final PowerResponse? response;
  final ApiError? error;

  bool get isLoading => phase == PowerActionPhase.loading;
  bool get isSuccess => phase == PowerActionPhase.success;
  bool get isError => phase == PowerActionPhase.error;

  /// True when [action] is the call currently in flight.
  bool isLoadingAction(PowerAction action) => isLoading && this.action == action;
}

/// Optimistic local status overlay written after a successful power call so
/// the detail screen reflects `stopping` / `booting` / `rebooting` before the
/// provider reports back. Cleared by the scheduled single detail refresh.
/// A 409 (`SERVER_NOT_ACTIVE` / `SERVER_NOT_STOPPED`) never touches it.
final serverStatusOverrideProvider =
    StateProvider.family<ServerStatus?, int>((ref, serverId) => null);

/// Delay before the one-shot detail refresh after a power action. Deliberately
/// a single refresh — never a poll loop (pull-to-refresh covers newer state).
final powerRefreshDelayProvider =
    Provider<Duration>((ref) => const Duration(seconds: 3));

/// Runs `POST /servers/power` for one server and owns its optimistic state.
class PowerActionNotifier extends FamilyNotifier<PowerActionState, int> {
  @override
  PowerActionState build(int serverId) => const PowerActionState.idle();

  int get serverId => arg;

  /// Fires one power action; never throws — failures land in [state].
  Future<PowerActionState> perform(PowerAction action) async {
    if (state.isLoading) return state;
    state = PowerActionState.loading(action);
    try {
      final response = await ref
          .read(serverRepositoryProvider)
          .powerAction(serverId: serverId, action: action);
      // Optimistic status: stop→stopping, start→booting, reboot→rebooting.
      ref.read(serverStatusOverrideProvider(serverId).notifier).state =
          switch (action) {
        PowerAction.stop => ServerStatus.stopping,
        PowerAction.start => ServerStatus.booting,
        PowerAction.reboot => ServerStatus.rebooting,
      };
      state = PowerActionState.success(response);
      unawaited(_refreshAfterAction());
      return state;
    } on ApiError catch (e) {
      state = PowerActionState.error(e);
      return state;
    } catch (e) {
      state = PowerActionState.error(
        ApiError(code: 'CLIENT_ERROR', message: e.toString()),
      );
      return state;
    }
  }

  /// Single detail refresh after the provider has had time to settle.
  Future<void> _refreshAfterAction() async {
    await Future<void>.delayed(ref.read(powerRefreshDelayProvider));
    try {
      ref.read(serverStatusOverrideProvider(serverId).notifier).state = null;
      ref.invalidate(serverDetailProvider(serverId));
    } catch (_) {
      // Notifier/container disposed while the timer was pending.
    }
  }
}

/// Power-action state per server (`powerActionProvider(serverId)`).
final powerActionProvider = NotifierProvider.family<
    PowerActionNotifier, PowerActionState, int>(PowerActionNotifier.new);

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_error.dart';
import '../../../core/api/response_parser.dart';
import '../../../shared/models/paged.dart';
import 'admin_auth_repository.dart';
import 'models/admin_dashboard.dart';
import 'models/admin_notification.dart';
import 'models/admin_order.dart';
import 'models/admin_server.dart';
import 'models/admin_ticket.dart';
import 'models/admin_ticket_detail.dart';
import 'models/admin_topup.dart';
import 'models/admin_user.dart';
import 'models/admin_user_detail.dart';
import 'models/admin_withdrawal.dart';

/// Admin management API (`/api/v1/admin/*`) — the 26 management endpoints on
/// top of the admin auth surface. Uses the admin audience's Dio client so the
/// admin bearer token is attached and the user audience is never touched.
class AdminRepository {
  AdminRepository(this._client);

  final ApiClient _client;

  /// `GET /admin/dashboard`.
  Future<AdminDashboard> getDashboard() async {
    try {
      final response =
          await _client.dio.get<Map<String, dynamic>>('admin/dashboard');
      return parseResponse(response, AdminDashboard.fromJson);
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  // ── Users ───────────────────────────────────────────────────────────────

  /// `GET /admin/users`.
  Future<Paged<AdminUser>> getUsers({
    int page = 1,
    int perPage = 20,
    String? search,
    String? role,
  }) async {
    try {
      final response = await _client.dio.get<Map<String, dynamic>>(
        'admin/users',
        queryParameters: {
          'page': page,
          'per_page': perPage,
          if (search != null && search.isNotEmpty) 'search': search,
          if (role != null && role.isNotEmpty && role != 'all') 'role': role,
        },
      );
      return parseResponse(
        response,
        (json) => Paged.fromJson<AdminUser>(json, AdminUser.fromJson),
      );
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// `GET /admin/users/detail?user_id=`.
  Future<AdminUserDetail> getUserDetail(int userId) async {
    try {
      final response = await _client.dio.get<Map<String, dynamic>>(
        'admin/users/detail',
        queryParameters: {'user_id': userId},
      );
      return parseResponse(response, AdminUserDetail.fromJson);
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// `POST /admin/users/toggle-active`.
  Future<void> toggleUserActive(int userId, bool active) async {
    try {
      await _client.dio.post<Map<String, dynamic>>(
        'admin/users/toggle-active',
        data: {'user_id': userId, 'active': active},
      );
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// `POST /admin/users/change-role`.
  Future<void> changeUserRole(int userId, String role) async {
    try {
      await _client.dio.post<Map<String, dynamic>>(
        'admin/users/change-role',
        data: {'user_id': userId, 'role': role},
      );
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// `POST /admin/users/adjust-wallet` → returns the server message.
  Future<String> adjustWallet(
    int userId,
    double amountUsd,
    String note,
  ) async {
    try {
      final response = await _client.dio.post<Map<String, dynamic>>(
        'admin/users/adjust-wallet',
        data: {'user_id': userId, 'amount_usd': amountUsd, 'note': note},
      );
      return response.data?['message']?.toString() ?? 'Wallet adjusted.';
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  // ── Servers ─────────────────────────────────────────────────────────────

  /// `GET /admin/servers`.
  Future<Paged<AdminServer>> getServers({
    int page = 1,
    int perPage = 20,
    String? status,
    int? userId,
  }) async {
    try {
      final response = await _client.dio.get<Map<String, dynamic>>(
        'admin/servers',
        queryParameters: {
          'page': page,
          'per_page': perPage,
          if (status != null && status.isNotEmpty && status != 'all')
            'status': status,
          if (userId != null) 'user_id': userId,
        },
      );
      return parseResponse(
        response,
        (json) => Paged.fromJson<AdminServer>(json, AdminServer.fromJson),
      );
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// `GET /admin/servers/detail?server_id=`.
  Future<AdminServer> getServerDetail(int serverId) async {
    try {
      final response = await _client.dio.get<Map<String, dynamic>>(
        'admin/servers/detail',
        queryParameters: {'server_id': serverId},
      );
      return parseResponse(response, AdminServer.fromJson);
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// `POST /admin/servers/force-destroy`.
  Future<void> forceDestroyServer(int serverId, String? note) async {
    try {
      await _client.dio.post<Map<String, dynamic>>(
        'admin/servers/force-destroy',
        data: {
          'server_id': serverId,
          if (note != null && note.isNotEmpty) 'note': note,
        },
      );
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// `POST /admin/servers/force-refresh`.
  Future<void> forceRefreshServer(int serverId) async {
    try {
      await _client.dio.post<Map<String, dynamic>>(
        'admin/servers/force-refresh',
        data: {'server_id': serverId},
      );
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  // ── Orders ──────────────────────────────────────────────────────────────

  /// `GET /admin/orders`.
  Future<Paged<AdminOrder>> getOrders({
    int page = 1,
    int perPage = 20,
    String? status,
    int? userId,
  }) async {
    try {
      final response = await _client.dio.get<Map<String, dynamic>>(
        'admin/orders',
        queryParameters: {
          'page': page,
          'per_page': perPage,
          if (status != null && status.isNotEmpty && status != 'all')
            'status': status,
          if (userId != null) 'user_id': userId,
        },
      );
      return parseResponse(
        response,
        (json) => Paged.fromJson<AdminOrder>(json, AdminOrder.fromJson),
      );
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// `POST /admin/orders/approve`.
  Future<void> approveOrder(int orderId, String? note) async {
    try {
      await _client.dio.post<Map<String, dynamic>>(
        'admin/orders/approve',
        data: {
          'order_id': orderId,
          'request_id': orderId,
          if (note != null && note.isNotEmpty) 'note': note,
        },
      );
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// `POST /admin/orders/reject`.
  Future<void> rejectOrder(int orderId, String reason) async {
    try {
      await _client.dio.post<Map<String, dynamic>>(
        'admin/orders/reject',
        data: {'order_id': orderId, 'request_id': orderId, 'reason': reason},
      );
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  // ── Top-ups ─────────────────────────────────────────────────────────────

  /// `GET /admin/topups`.
  Future<Paged<AdminTopup>> getTopups({
    int page = 1,
    int perPage = 20,
    String? status,
  }) async {
    try {
      final response = await _client.dio.get<Map<String, dynamic>>(
        'admin/topups',
        queryParameters: {
          'page': page,
          'per_page': perPage,
          if (status != null && status.isNotEmpty && status != 'all')
            'status': status,
        },
      );
      return parseResponse(
        response,
        (json) => Paged.fromJson<AdminTopup>(json, AdminTopup.fromJson),
      );
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// `POST /admin/topups/approve`.
  Future<void> approveTopup(int topupId, String? note) async {
    try {
      await _client.dio.post<Map<String, dynamic>>(
        'admin/topups/approve',
        data: {
          'topup_id': topupId,
          'request_id': topupId,
          if (note != null && note.isNotEmpty) 'note': note,
        },
      );
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// `POST /admin/topups/reject`.
  Future<void> rejectTopup(int topupId, String reason) async {
    try {
      await _client.dio.post<Map<String, dynamic>>(
        'admin/topups/reject',
        data: {'topup_id': topupId, 'request_id': topupId, 'reason': reason},
      );
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  // ── Withdrawals ─────────────────────────────────────────────────────────

  /// `GET /admin/withdrawals`.
  Future<Paged<AdminWithdrawal>> getWithdrawals({
    int page = 1,
    int perPage = 20,
    String? status,
  }) async {
    try {
      final response = await _client.dio.get<Map<String, dynamic>>(
        'admin/withdrawals',
        queryParameters: {
          'page': page,
          'per_page': perPage,
          if (status != null && status.isNotEmpty && status != 'all')
            'status': status,
        },
      );
      return parseResponse(
        response,
        (json) => Paged.fromJson<AdminWithdrawal>(
          json,
          AdminWithdrawal.fromJson,
        ),
      );
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// `POST /admin/withdrawals/approve`.
  Future<void> approveWithdrawal(int withdrawalId, String? note) async {
    try {
      await _client.dio.post<Map<String, dynamic>>(
        'admin/withdrawals/approve',
        data: {
          'withdrawal_id': withdrawalId,
          'request_id': withdrawalId,
          if (note != null && note.isNotEmpty) 'note': note,
        },
      );
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// `POST /admin/withdrawals/reject`.
  Future<void> rejectWithdrawal(int withdrawalId, String reason) async {
    try {
      await _client.dio.post<Map<String, dynamic>>(
        'admin/withdrawals/reject',
        data: {
          'withdrawal_id': withdrawalId,
          'request_id': withdrawalId,
          'reason': reason,
        },
      );
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  // ── Tickets ─────────────────────────────────────────────────────────────

  /// `GET /admin/tickets`.
  Future<Paged<AdminTicket>> getTickets({
    int page = 1,
    int perPage = 20,
    String? status,
    int? userId,
  }) async {
    try {
      final response = await _client.dio.get<Map<String, dynamic>>(
        'admin/tickets',
        queryParameters: {
          'page': page,
          'per_page': perPage,
          if (status != null && status.isNotEmpty && status != 'all')
            'status': status,
          if (userId != null) 'user_id': userId,
        },
      );
      return parseResponse(
        response,
        (json) => Paged.fromJson<AdminTicket>(json, AdminTicket.fromJson),
      );
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// `GET /admin/tickets/detail?ticket_id=`.
  Future<AdminTicketDetail> getTicketDetail(int ticketId) async {
    try {
      final response = await _client.dio.get<Map<String, dynamic>>(
        'admin/tickets/detail',
        queryParameters: {'ticket_id': ticketId},
      );
      return parseResponse(response, AdminTicketDetail.fromJson);
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// `POST /admin/tickets/reply`.
  Future<void> replyToTicket(int ticketId, String message) async {
    try {
      await _client.dio.post<Map<String, dynamic>>(
        'admin/tickets/reply',
        data: {'ticket_id': ticketId, 'message': message},
      );
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// `POST /admin/tickets/close`.
  Future<void> closeTicket(int ticketId) async {
    try {
      await _client.dio.post<Map<String, dynamic>>(
        'admin/tickets/close',
        data: {'ticket_id': ticketId},
      );
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// `POST /admin/tickets/set-priority`.
  Future<void> setTicketPriority(int ticketId, String priority) async {
    try {
      await _client.dio.post<Map<String, dynamic>>(
        'admin/tickets/set-priority',
        data: {'ticket_id': ticketId, 'priority': priority},
      );
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  // ── Notifications ───────────────────────────────────────────────────────

  /// `POST /admin/notifications/send`. `target` is `all` or `user`.
  Future<void> sendNotification(
    String title,
    String message,
    String target,
    int? userId,
  ) async {
    try {
      await _client.dio.post<Map<String, dynamic>>(
        'admin/notifications/send',
        data: {
          'title': title,
          'message': message,
          'target': target,
          if (userId != null) 'user_id': userId,
        },
      );
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// `GET /admin/notifications/history`.
  Future<Paged<AdminNotification>> getNotificationHistory({
    int page = 1,
    int perPage = 20,
  }) async {
    try {
      final response = await _client.dio.get<Map<String, dynamic>>(
        'admin/notifications/history',
        queryParameters: {'page': page, 'per_page': perPage},
      );
      return parseResponse(
        response,
        (json) =>
            Paged.fromJson<AdminNotification>(json, AdminNotification.fromJson),
      );
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }
}

final adminRepositoryProvider = Provider<AdminRepository>(
  (ref) => AdminRepository(ref.watch(adminApiClientProvider)),
);

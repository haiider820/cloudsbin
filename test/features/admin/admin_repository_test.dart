import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:cloudsbin/core/api/api_client.dart';
import 'package:cloudsbin/core/api/api_error.dart';
import 'package:cloudsbin/core/storage/secure_storage.dart';
import 'package:cloudsbin/features/admin/data/admin_auth_repository.dart';
import 'package:cloudsbin/features/admin/data/admin_repository.dart';
import 'package:cloudsbin/shared/enums/app_enums.dart';

import '../../helpers/fakes.dart';

void main() {
  late MemorySecureStorage storage;
  late ApiClient client;
  late AdminAuthRepository repo;
  late AdminRepository mgmt;

  ScriptedAdapter script(List<ScriptedResponse> responses) {
    final adapter = ScriptedAdapter(responses);
    client.dio.httpClientAdapter = adapter;
    return adapter;
  }

  setUp(() {
    storage = MemorySecureStorage();
    client = ApiClient(
      storage: storage,
      appVersion: '1.0.0',
      tokenKeys: TokenKeys.admin,
    );
    repo = AdminAuthRepository(client, storage);
    mgmt = AdminRepository(client);
  });

  group('AdminAuthRepository', () {
    test('login sends the device payload and stores only admin tokens',
        () async {
      final adapter = script(const [
        ScriptedResponse(
          200,
          {'access_token': 'admin-a', 'refresh_token': 'admin-r'},
        ),
      ]);

      await repo.login(
        email: 'root@cloudsbin.io',
        password: 'pw',
        deviceId: 'dev-42',
        platform: 'android',
        appVersion: '2.1.0',
      );

      final request = adapter.requests.single;
      expect(request.uri.path, '/api/v1/admin/auth/login');
      // Dio serialises nested freezed objects at encode time — mirror the
      // wire payload with a JSON round-trip.
      final body = jsonDecode(jsonEncode(request.data)) as Map<String, dynamic>;
      expect(body['email'], 'root@cloudsbin.io');
      final device = body['device'] as Map<String, dynamic>;
      expect(device['id'], 'dev-42');
      expect(device['platform'], 'android');
      expect(device['app_version'], '2.1.0');

      expect(storage.values['admin_access_token'], 'admin-a');
      expect(storage.values['admin_refresh_token'], 'admin-r');
      expect(storage.values['access_token'], isNull);
      expect(storage.values['refresh_token'], isNull);
    });

    test('logout clears only the admin keys, user tokens survive', () async {
      storage.values
        ..['admin_access_token'] = 'aa'
        ..['admin_refresh_token'] = 'ar'
        ..['access_token'] = 'ua'
        ..['refresh_token'] = 'ur';
      final adapter = script(const [
        ScriptedResponse(200, {'logged_out': true}),
      ]);

      await repo.logout();

      expect(adapter.requests.single.uri.path, '/api/v1/admin/auth/logout');
      expect(storage.values['admin_access_token'], isNull);
      expect(storage.values['admin_refresh_token'], isNull);
      expect(storage.values['access_token'], 'ua');
      expect(storage.values['refresh_token'], 'ur');
    });

    test('logoutAll clears only the admin keys', () async {
      storage.values
        ..['admin_access_token'] = 'aa'
        ..['admin_refresh_token'] = 'ar'
        ..['access_token'] = 'ua'
        ..['refresh_token'] = 'ur';
      final adapter = script(const [
        ScriptedResponse(200, {'revoked': 3}),
      ]);

      await repo.logoutAll();

      expect(adapter.requests.single.uri.path, '/api/v1/admin/auth/logout-all');
      expect(storage.values['admin_access_token'], isNull);
      expect(storage.values['access_token'], 'ua');
    });

    test('getProfile hits /admin/me and parses AdminProfile', () async {
      final adapter = script(const [
        ScriptedResponse(200, {
          'id': 7,
          'email': 'root@cloudsbin.io',
          'role': 'admin',
          'created_at': '2026-01-05T10:00:00Z',
          'referral_code': null,
        }),
      ]);

      final profile = await repo.getProfile();

      expect(adapter.requests.single.uri.path, '/api/v1/admin/me');
      expect(profile.id, 7);
      expect(profile.email, 'root@cloudsbin.io');
      expect(profile.role, 'admin');
      expect(profile.createdAt, isNotNull);
      expect(profile.referralCode, isNull);
    });

    test('getSessions hits admin sessions path and parses items', () async {
      final adapter = script(const [
        ScriptedResponse(200, {
          'items': [
            {
              'id': 228,
              'device_name': 'Pixel 8',
              'platform': 'android',
              'app_version': '1.0.0',
              'last_used_at': '2026-10-16T10:04:05Z',
              'last_ip': '127.0.0.1',
              'created_at': '2026-10-16T10:04:05Z',
              'current': true,
            },
            {
              'id': 229,
              'device_name': 'iPhone 15',
              'platform': 'ios',
              'app_version': '1.0.0',
              'last_used_at': '2026-10-15T09:00:00Z',
              'last_ip': '198.51.100.9',
              'created_at': '2026-10-15T09:00:00Z',
              'current': false,
            },
          ],
          'page': 1,
          'per_page': 25,
          'total': 2,
          'has_more': false,
        }),
      ]);

      final paged = await repo.getSessions();

      expect(
        adapter.requests.single.uri.path,
        '/api/v1/admin/auth/sessions',
      );
      expect(paged.items, hasLength(2));
      expect(paged.items.first.id, 228);
      expect(paged.items.first.current, isTrue);
      expect(paged.items.first.lastUsedAt, isNotNull);
      expect(paged.items.last.platform, 'ios');
      expect(paged.items.last.current, isFalse);
      expect(paged.total, 2);
    });

    test('revokeSession posts session_id to the admin revoke endpoint',
        () async {
      final adapter = script(const [
        ScriptedResponse(200, {'revoked': true}),
      ]);

      final revoked = await repo.revokeSession(42);

      expect(revoked, isTrue);
      final request = adapter.requests.single;
      expect(
        request.uri.path,
        '/api/v1/admin/auth/sessions-revoke',
      );
      expect(request.data!['session_id'], 42);
    });
  });

  group('AdminRepository (management, 26 endpoints)', () {
    // ── Dashboard ─────────────────────────────────────────────────────────
    test('getDashboard → /admin/dashboard, parses every counter block',
        () async {
      final adapter = script(const [
        ScriptedResponse(200, {
          'users': {'total': 150, 'new_today': 3, 'new_this_month': 45},
          'servers': {
            'total': 89,
            'active': 67,
            'provisioning': 2,
            'destroyed': 20,
          },
          'orders': {'pending': 5, 'total_this_month': 34},
          'revenue': {'today_usd': '45.00', 'this_month_usd': 1250},
          'tickets': {'open': 8, 'unread': 3},
          'topups': {'pending_count': 2, 'pending_amount_usd': 75.0},
        }),
      ]);

      final d = await mgmt.getDashboard();

      expect(adapter.requests.single.uri.path, '/api/v1/admin/dashboard');
      expect(d.users.total, 150);
      expect(d.users.newThisMonth, 45);
      expect(d.servers.active, 67);
      expect(d.orders.pending, 5);
      // moneyString normalises both decimal strings and numbers to a string.
      expect(d.revenue.thisMonthUsd, '1250');
      expect(d.tickets.open, 8);
      expect(d.topups.pendingCount, 2);
      expect(d.topups.pendingAmountUsd, '75.0');
    });

    test('getDashboard tolerates a partial payload (all blocks default)',
        () async {
      script(const [ScriptedResponse(200, {'users': {'total': 4}})]);

      final d = await mgmt.getDashboard();

      expect(d.users.total, 4);
      expect(d.servers.total, 0);
      expect(d.revenue.thisMonthUsd, isNull);
      expect(d.tickets.open, 0);
    });

    // ── Users ─────────────────────────────────────────────────────────────
    test('getUsers sends page/per_page/search/role and parses items',
        () async {
      final adapter = script(const [
        ScriptedResponse(200, {
          'items': [
            {
              'id': 1,
              'email': 'a@b.c',
              'role': 'admin',
              'wallet_balance_usd': '84.00',
              'server_count': 3,
              'is_active': false,
              'created_at': '2026-10-12T08:18:39Z',
              'last_login_at': '2026-10-16T10:04:05Z',
            },
          ],
          'page': 1,
          'per_page': 20,
          'total': 1,
          'has_more': false,
        }),
      ]);

      final paged = await mgmt.getUsers(
        page: 2,
        perPage: 5,
        search: 'sa',
        role: 'admin',
      );

      final q = adapter.requests.single.uri.queryParameters;
      expect(adapter.requests.single.uri.path, '/api/v1/admin/users');
      expect(q['page'], '2');
      expect(q['per_page'], '5');
      expect(q['search'], 'sa');
      expect(q['role'], 'admin');
      expect(paged.items.single.email, 'a@b.c');
      expect(paged.items.single.isActive, isFalse);
      expect(paged.items.single.walletBalanceUsd, '84.00');
      expect(paged.items.single.createdAt, isNotNull);
      expect(paged.items.single.lastLoginAt, isNotNull);
    });

    test('getUsers omits blank search and "all" role filters', () async {
      final adapter = script(const [
        ScriptedResponse(200, {
          'items': [],
          'page': 1,
          'per_page': 20,
          'total': 0,
          'has_more': false,
        }),
      ]);

      await mgmt.getUsers(search: '', role: 'all');

      final q = adapter.requests.single.uri.queryParameters;
      expect(q.containsKey('search'), isFalse);
      expect(q.containsKey('role'), isFalse);
    });

    test('getUserDetail sends user_id and parses admin-only fields', () async {
      final adapter = script(const [
        ScriptedResponse(200, {
          'id': 900152,
          'email': 'demo@cloudsbin.local',
          'lifetime_spent_usd': '310.75',
          'ticket_count': 4,
          'referral_code': 'A2FA',
          'last_login_ip': '203.0.113.9',
        }),
      ]);

      final detail = await mgmt.getUserDetail(900152);

      final req = adapter.requests.single;
      expect(req.uri.path, '/api/v1/admin/users/detail');
      expect(req.uri.queryParameters['user_id'], '900152');
      expect(detail.lifetimeSpentUsd, '310.75');
      expect(detail.ticketCount, 4);
      expect(detail.referralCode, 'A2FA');
      expect(detail.lastLoginIp, '203.0.113.9');
    });

    test('toggleUserActive posts user_id + active', () async {
      final adapter = script(const [ScriptedResponse(200, {'message': 'ok'})]);

      await mgmt.toggleUserActive(7, false);

      final req = adapter.requests.single;
      expect(req.uri.path, '/api/v1/admin/users/toggle-active');
      expect(req.data!['user_id'], 7);
      expect(req.data!['active'], false);
    });

    test('changeUserRole posts user_id + role', () async {
      final adapter = script(const [ScriptedResponse(200, {'message': 'ok'})]);

      await mgmt.changeUserRole(7, 'admin');

      final req = adapter.requests.single;
      expect(req.uri.path, '/api/v1/admin/users/change-role');
      expect(req.data!['user_id'], 7);
      expect(req.data!['role'], 'admin');
    });

    test('adjustWallet posts amount + note and returns the server message',
        () async {
      final adapter = script(const [
        ScriptedResponse(200, {'message': 'Wallet credited.'}),
      ]);

      final message = await mgmt.adjustWallet(7, 25.5, 'goodwill');

      final req = adapter.requests.single;
      expect(req.uri.path, '/api/v1/admin/users/adjust-wallet');
      expect(req.data!['user_id'], 7);
      expect(req.data!['amount_usd'], 25.5);
      expect(req.data!['note'], 'goodwill');
      expect(message, 'Wallet credited.');
    });

    // ── Servers ───────────────────────────────────────────────────────────
    test('getServers parses owner email, status and provider slug', () async {
      final adapter = script(const [
        ScriptedResponse(200, {
          'items': [
            {
              'id': 9206568,
              'user_id': 900152,
              'user_email': 'demo@cloudsbin.local',
              'status': 'active',
              'plan_name': 'nano',
              'region': 'us-east',
              'ip_address': '203.0.113.10',
              'provider_slug': 'linode',
              'created_at': '2026-10-16T10:04:04Z',
            },
          ],
          'page': 1,
          'per_page': 20,
          'total': 1,
          'has_more': false,
        }),
      ]);

      final paged = await mgmt.getServers(status: 'active', userId: 900152);

      final req = adapter.requests.single;
      expect(req.uri.path, '/api/v1/admin/servers');
      expect(req.uri.queryParameters['status'], 'active');
      expect(req.uri.queryParameters['user_id'], '900152');
      final server = paged.items.single;
      expect(server.userEmail, 'demo@cloudsbin.local');
      expect(server.status, ServerStatus.active);
      expect(server.providerSlug, 'linode');
    });

    test('getServerDetail sends server_id', () async {
      final adapter = script(const [
        ScriptedResponse(200, {
          'id': 9206568,
          'user_id': 900152,
          'status': 'destroyed',
        }),
      ]);

      final server = await mgmt.getServerDetail(9206568);

      final req = adapter.requests.single;
      expect(req.uri.path, '/api/v1/admin/servers/detail');
      expect(req.uri.queryParameters['server_id'], '9206568');
      expect(server.status, ServerStatus.destroyed);
    });

    test('forceDestroyServer includes an optional note only when provided',
        () async {
      final adapter = script(const [
        ScriptedResponse(200, {'message': 'gone'}),
        ScriptedResponse(200, {'message': 'gone'}),
      ]);

      await mgmt.forceDestroyServer(9206568, 'abuse');
      await mgmt.forceDestroyServer(9206569, null);

      final first = adapter.requests.first;
      expect(first.uri.path, '/api/v1/admin/servers/force-destroy');
      expect(first.data!['server_id'], 9206568);
      expect(first.data!['note'], 'abuse');
      expect(adapter.requests.last.data!.containsKey('note'), isFalse);
    });

    test('forceRefreshServer posts server_id', () async {
      final adapter = script(const [ScriptedResponse(200, {'message': 'ok'})]);

      await mgmt.forceRefreshServer(9206568);

      final req = adapter.requests.single;
      expect(req.uri.path, '/api/v1/admin/servers/force-refresh');
      expect(req.data!['server_id'], 9206568);
    });

    // ── Orders ────────────────────────────────────────────────────────────
    test('getOrders parses cents, receipt flag and note', () async {
      final adapter = script(const [
        ScriptedResponse(200, {
          'items': [
            {
              'id': 4205,
              'user_id': 900152,
              'user_email': 'demo@cloudsbin.local',
              'status': 'pending',
              'plan_name': 'Standard 1',
              'total_cents': 575,
              'has_receipt': true,
              'receipt_url': 'https://example.com/r.png',
              'admin_note': null,
              'created_at': '2026-10-16T10:24:00Z',
            },
          ],
          'page': 1,
          'per_page': 20,
          'total': 1,
          'has_more': false,
        }),
      ]);

      final paged = await mgmt.getOrders(userId: 900152);

      expect(adapter.requests.single.uri.path, '/api/v1/admin/orders');
      final order = paged.items.single;
      expect(order.totalCents, 575);
      expect(order.hasReceipt, isTrue);
      expect(order.receiptUrl, 'https://example.com/r.png');
      expect(order.status, 'pending');
    });

    test('approveOrder posts order_id + optional note', () async {
      final adapter = script(const [ScriptedResponse(200, {'message': 'ok'})]);

      await mgmt.approveOrder(4205, 'verified');

      final req = adapter.requests.single;
      expect(req.uri.path, '/api/v1/admin/orders/approve');
      expect(req.data!['order_id'], 4205);
      expect(req.data!['note'], 'verified');
    });

    test('rejectOrder posts order_id + reason', () async {
      final adapter = script(const [ScriptedResponse(200, {'message': 'ok'})]);

      await mgmt.rejectOrder(4205, 'invalid receipt');

      final req = adapter.requests.single;
      expect(req.uri.path, '/api/v1/admin/orders/reject');
      expect(req.data!['order_id'], 4205);
      expect(req.data!['reason'], 'invalid receipt');
    });

    // ── Top-ups ───────────────────────────────────────────────────────────
    test('getTopups parses amount + method', () async {
      final adapter = script(const [
        ScriptedResponse(200, {
          'items': [
            {
              'id': 7781,
              'user_id': 900152,
              'user_email': 'demo@cloudsbin.local',
              'amount_usd': '50.00',
              'method': 'bank_transfer',
              'status': 'pending',
              'receipt_url': 'https://example.com/t.jpg',
              'created_at': '2026-10-16T09:12:00Z',
            },
          ],
          'page': 1,
          'per_page': 20,
          'total': 1,
          'has_more': false,
        }),
      ]);

      final paged = await mgmt.getTopups(status: 'pending');

      expect(adapter.requests.single.uri.path, '/api/v1/admin/topups');
      expect(paged.items.single.amountUsd, '50.00');
      expect(paged.items.single.method, 'bank_transfer');
    });

    test('approveTopup posts topup_id + note', () async {
      final adapter = script(const [ScriptedResponse(200, {'message': 'ok'})]);

      await mgmt.approveTopup(7781, 'ok');

      final req = adapter.requests.single;
      expect(req.uri.path, '/api/v1/admin/topups/approve');
      expect(req.data!['topup_id'], 7781);
      expect(req.data!['note'], 'ok');
    });

    test('rejectTopup posts topup_id + reason', () async {
      final adapter = script(const [ScriptedResponse(200, {'message': 'ok'})]);

      await mgmt.rejectTopup(7781, 'blurry receipt');

      final req = adapter.requests.single;
      expect(req.uri.path, '/api/v1/admin/topups/reject');
      expect(req.data!['topup_id'], 7781);
      expect(req.data!['reason'], 'blurry receipt');
    });

    // ── Withdrawals ───────────────────────────────────────────────────────
    test('getWithdrawals parses account details', () async {
      final adapter = script(const [
        ScriptedResponse(200, {
          'items': [
            {
              'id': 3310,
              'user_id': 900156,
              'user_email': 'bilal@example.com',
              'amount_usd': '120.00',
              'method': 'bank_transfer',
              'account_details': 'HBL 1234 · Bilal',
              'status': 'pending',
              'created_at': '2026-10-16T08:30:00Z',
            },
          ],
          'page': 1,
          'per_page': 20,
          'total': 1,
          'has_more': false,
        }),
      ]);

      final paged = await mgmt.getWithdrawals();

      expect(adapter.requests.single.uri.path, '/api/v1/admin/withdrawals');
      expect(paged.items.single.accountDetails, 'HBL 1234 · Bilal');
      expect(paged.items.single.amountUsd, '120.00');
    });

    test('approveWithdrawal posts withdrawal_id + note', () async {
      final adapter = script(const [ScriptedResponse(200, {'message': 'ok'})]);

      await mgmt.approveWithdrawal(3310, null);

      final req = adapter.requests.single;
      expect(req.uri.path, '/api/v1/admin/withdrawals/approve');
      expect(req.data!['withdrawal_id'], 3310);
      expect(req.data!.containsKey('note'), isFalse);
    });

    test('rejectWithdrawal posts withdrawal_id + reason', () async {
      final adapter = script(const [ScriptedResponse(200, {'message': 'ok'})]);

      await mgmt.rejectWithdrawal(3310, 'kyc failed');

      final req = adapter.requests.single;
      expect(req.uri.path, '/api/v1/admin/withdrawals/reject');
      expect(req.data!['withdrawal_id'], 3310);
      expect(req.data!['reason'], 'kyc failed');
    });

    // ── Tickets ───────────────────────────────────────────────────────────
    test('getTickets parses status, priority and unread count', () async {
      final adapter = script(const [
        ScriptedResponse(200, {
          'items': [
            {
              'id': 501,
              'user_id': 900152,
              'user_email': 'demo@cloudsbin.local',
              'subject': 'Cannot SSH',
              'status': 'open',
              'priority': 'urgent',
              'last_reply_at': '2026-10-16T10:30:00Z',
              'unread_count': 2,
              'created_at': '2026-10-16T09:00:00Z',
            },
          ],
          'page': 1,
          'per_page': 20,
          'total': 1,
          'has_more': false,
        }),
      ]);

      final paged = await mgmt.getTickets(status: 'open');

      expect(adapter.requests.single.uri.path, '/api/v1/admin/tickets');
      final ticket = paged.items.single;
      expect(ticket.subject, 'Cannot SSH');
      expect(ticket.priority, 'urgent');
      expect(ticket.unreadCount, 2);
    });

    test('getTicketDetail sends ticket_id and parses the message thread',
        () async {
      final adapter = script(const [
        ScriptedResponse(200, {
          'id': 501,
          'user_id': 900152,
          'subject': 'Cannot SSH',
          'status': 'open',
          'priority': 'urgent',
          'messages': [
            {'id': 9001, 'sender': 'user', 'message': 'help'},
            {'id': 9002, 'sender': 'admin', 'message': 'on it'},
          ],
        }),
      ]);

      final detail = await mgmt.getTicketDetail(501);

      final req = adapter.requests.single;
      expect(req.uri.path, '/api/v1/admin/tickets/detail');
      expect(req.uri.queryParameters['ticket_id'], '501');
      expect(detail.messages, hasLength(2));
      expect(detail.messages.first.sender, 'user');
      expect(detail.messages.last.sender, 'admin');
      expect(detail.messages.last.message, 'on it');
    });

    test('replyToTicket posts ticket_id + message', () async {
      final adapter = script(const [ScriptedResponse(200, {'message': 'ok'})]);

      await mgmt.replyToTicket(501, 'Looking into it.');

      final req = adapter.requests.single;
      expect(req.uri.path, '/api/v1/admin/tickets/reply');
      expect(req.data!['ticket_id'], 501);
      expect(req.data!['message'], 'Looking into it.');
    });

    test('closeTicket posts ticket_id', () async {
      final adapter = script(const [ScriptedResponse(200, {'message': 'ok'})]);

      await mgmt.closeTicket(501);

      final req = adapter.requests.single;
      expect(req.uri.path, '/api/v1/admin/tickets/close');
      expect(req.data!['ticket_id'], 501);
    });

    test('setTicketPriority posts ticket_id + priority', () async {
      final adapter = script(const [ScriptedResponse(200, {'message': 'ok'})]);

      await mgmt.setTicketPriority(501, 'high');

      final req = adapter.requests.single;
      expect(req.uri.path, '/api/v1/admin/tickets/set-priority');
      expect(req.data!['ticket_id'], 501);
      expect(req.data!['priority'], 'high');
    });

    // ── Notifications ─────────────────────────────────────────────────────
    test('sendNotification posts title/message/target and optional user_id',
        () async {
      final adapter = script(const [
        ScriptedResponse(200, {'message': 'sent', 'recipient_count': 150}),
        ScriptedResponse(200, {'message': 'sent', 'recipient_count': 1}),
      ]);

      await mgmt.sendNotification('Maintenance', 'Downtime tonight', 'all', null);
      await mgmt.sendNotification('Wallet', 'Credited', 'user', 900152);

      final broadcast = adapter.requests.first;
      expect(broadcast.uri.path, '/api/v1/admin/notifications/send');
      expect(broadcast.data!['target'], 'all');
      expect(broadcast.data!.containsKey('user_id'), isFalse);

      final targeted = adapter.requests.last;
      expect(targeted.data!['target'], 'user');
      expect(targeted.data!['user_id'], 900152);
    });

    test('getNotificationHistory parses recipient count + sent_at', () async {
      final adapter = script(const [
        ScriptedResponse(200, {
          'items': [
            {
              'id': 61,
              'title': 'Scheduled maintenance',
              'message': 'We will perform maintenance.',
              'target': 'all',
              'recipient_count': 150,
              'sent_at': '2026-10-15T09:00:00Z',
            },
          ],
          'page': 1,
          'per_page': 20,
          'total': 1,
          'has_more': false,
        }),
      ]);

      final paged = await mgmt.getNotificationHistory();

      expect(
        adapter.requests.single.uri.path,
        '/api/v1/admin/notifications/history',
      );
      final notice = paged.items.single;
      expect(notice.title, 'Scheduled maintenance');
      expect(notice.recipientCount, 150);
      expect(notice.sentAt, isNotNull);
    });

    test('surfaces ApiError on a non-2xx admin response', () async {
      script(const [
        ScriptedResponse(403, {'code': 'FORBIDDEN', 'message': 'nope'}),
      ]);

      await expectLater(mgmt.getDashboard(), throwsA(isA<ApiError>()));
    });
  });
}

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/utils/date_formatter.dart';

part 'admin_notification.freezed.dart';
part 'admin_notification.g.dart';

/// One item of `GET /admin/notifications/history`.
@freezed
class AdminNotification with _$AdminNotification {
  const factory AdminNotification({
    required int id,
    @Default('') String title,
    @Default('') String message,
    @Default('all') String target,
    @JsonKey(name: 'recipient_count') @Default(0) int recipientCount,
    @JsonKey(name: 'sent_at', fromJson: DateFormatter.parseIsoUtc)
    DateTime? sentAt,
  }) = _AdminNotification;

  factory AdminNotification.fromJson(Map<String, dynamic> json) =>
      _$AdminNotificationFromJson(json);
}

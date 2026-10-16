import 'package:flutter/material.dart';

import '../enums/app_enums.dart';

/// Colour-coded server status pill.
/// active=green · provisioning=amber · destroyed=grey · others=orange.
class StatusChip extends StatelessWidget {
  const StatusChip({super.key, required this.status});

  final ServerStatus status;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final (Color bg, Color fg) = switch (status.raw) {
      'active' => (const Color(0xFFDCFCE7), const Color(0xFF166534)),
      'provisioning' || 'booting' => (const Color(0xFFFEF3C7), const Color(0xFF92400E)),
      'destroyed' || 'terminated' => (scheme.surfaceContainerHighest, scheme.outline),
      _ => (const Color(0xFFFFEDD5), const Color(0xFF9A3412)),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        status.label,
        style: TextStyle(color: fg, fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/error_snackbar.dart';

/// A colour-coded pill for admin statuses (order/topup/withdrawal/ticket).
class AdminStatusPill extends StatelessWidget {
  const AdminStatusPill({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final (Color bg, Color fg) = switch (status.toLowerCase()) {
      'active' || 'approved' || 'open' || 'completed' || 'paid' =>
        (AppColors.activeBg, AppColors.activeFg),
      'pending' || 'processing' || 'provisioning' =>
        (AppColors.pendingBg, AppColors.pendingFg),
      'rejected' || 'banned' || 'failed' =>
        (AppColors.dangerBg, AppColors.dangerFg),
      'closed' || 'destroyed' || 'cancelled' || 'inactive' =>
        (AppColors.inactiveBg, AppColors.inactiveFg),
      _ => (AppColors.attentionBg, AppColors.attentionFg),
    };

    return _Pill(
      bg: bg,
      fg: fg,
      label: status.split('_').map(_cap).join(' '),
    );
  }
}

/// Ticket priority pill: urgent=red, high=orange, normal=blue, low=grey.
class AdminPriorityPill extends StatelessWidget {
  const AdminPriorityPill({super.key, required this.priority});

  final String priority;

  @override
  Widget build(BuildContext context) {
    final (Color bg, Color fg) = switch (priority.toLowerCase()) {
      'urgent' => (AppColors.dangerBg, AppColors.dangerFg),
      'high' => (AppColors.attentionBg, AppColors.attentionFg),
      'normal' => (
          AppColors.info.withValues(alpha: 0.15),
          AppColors.info,
        ),
      _ => (AppColors.inactiveBg, AppColors.inactiveFg),
    };

    return _Pill(bg: bg, fg: fg, label: _cap(priority));
  }
}

/// Small provider badge (e.g. `linode`, `aws`, `digitalocean`).
class ProviderBadge extends StatelessWidget {
  const ProviderBadge({super.key, required this.slug});

  final String slug;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.adminAccent.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(
          color: AppColors.adminAccent.withValues(alpha: 0.45),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.dns_outlined, size: 12, color: AppColors.adminAccentLight),
          const SizedBox(width: 4),
          Text(
            slug.isEmpty ? 'unknown' : slug,
            style: const TextStyle(
              color: AppColors.adminAccentLight,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

/// Horizontal, scrollable set of single-select filter chips.
class AdminFilterChips extends StatelessWidget {
  const AdminFilterChips({
    super.key,
    required this.values,
    required this.selected,
    required this.onChanged,
    this.labels,
  });

  final List<String> values;
  final String selected;
  final ValueChanged<String> onChanged;
  final Map<String, String>? labels;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Row(
        children: [
          for (final value in values) ...[
            _Chip(
              label: labels?[value] ?? value,
              selected: value == selected,
              onTap: () => onChanged(value),
            ),
            const SizedBox(width: AppSpacing.xs),
          ],
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.adminAccent : AppColors.bg2,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: Border.all(
            color: selected
                ? AppColors.adminAccent
                : AppColors.line,
          ),
        ),
        child: Text(
          label.split('_').map(_cap).join(' '),
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.bg, required this.fg, required this.label});

  final Color bg;
  final Color fg;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: fg.withValues(alpha: 0.35)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: fg,
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

String _cap(String word) {
  if (word.isEmpty) return word;
  return '${word[0].toUpperCase()}${word.substring(1)}';
}

/// Modal prompt that collects a single line of text (a note or a reject
/// reason). Returns the trimmed text, or null when cancelled.
Future<String?> adminTextPrompt(
  BuildContext context, {
  required String title,
  String? hint,
  String confirmLabel = 'Submit',
  String cancelLabel = 'Cancel',
  bool required = true,
  bool danger = false,
}) {
  final controller = TextEditingController();
  return showDialog<String>(
    context: context,
    builder: (context) {
      String? error;
      return StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          backgroundColor: AppColors.bg1,
          title: Text(title),
          content: TextField(
            controller: controller,
            autofocus: true,
            maxLines: 3,
            minLines: 1,
            decoration: InputDecoration(
              hintText: hint,
              errorText: error,
            ),
          ),
          actions: [
            AppButton(
              label: cancelLabel,
              variant: AppButtonVariant.secondary,
              dense: true,
              fullWidth: false,
              onPressed: () => Navigator.of(context).pop(),
            ),
            AppButton(
              label: confirmLabel,
              variant:
                  danger ? AppButtonVariant.danger : AppButtonVariant.primary,
              dense: true,
              fullWidth: false,
              onPressed: () {
                final text = controller.text.trim();
                if (required && text.isEmpty) {
                  setState(() => error = 'This field is required.');
                  return;
                }
                Navigator.of(context).pop(text);
              },
            ),
          ],
        ),
      );
    },
  ).whenComplete(controller.dispose);
}

/// Opens [url] in the external browser, degrading to a snackbar on failure.
Future<void> adminOpenUrl(BuildContext context, String url) async {
  final uri = Uri.tryParse(url);
  if (uri == null) {
    showInfoSnackBar(context, 'Invalid receipt URL.');
    return;
  }
  try {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (_) {
    if (context.mounted) {
      showInfoSnackBar(context, 'Could not open the receipt.');
    }
  }
}

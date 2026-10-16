import 'package:flutter/material.dart';

/// Premium dark design tokens for the CloudsBin brand.
///
/// Deep navy/slate surfaces, one electric accent (cyan) with a violet
/// companion, and high-contrast text. Every screen in the app is built
/// from these tokens — no ad-hoc colours.
class AppColors {
  const AppColors._();

  // ── Surfaces ──────────────────────────────────────────────────────────
  /// Page background.
  static const Color bg0 = Color(0xFF060B14);

  /// Default surface (app bars, sheets sit on this).
  static const Color bg1 = Color(0xFF0A1220);

  /// Card surface.
  static const Color bg2 = Color(0xFF0F1A2D);

  /// Elevated / input surface.
  static const Color bg3 = Color(0xFF16233A);

  /// Hairline borders and dividers.
  static const Color line = Color(0xFF1E2C47);

  // ── Text ──────────────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFFF1F5FB);
  static const Color textSecondary = Color(0xFF9DACCA);
  static const Color textMuted = Color(0xFF5D6F8F);

  // ── Brand ─────────────────────────────────────────────────────────────
  static const Color accent = Color(0xFF22D3EE); // electric cyan
  static const Color accentViolet = Color(0xFFA78BFA);
  static const Color onAccent = Color(0xFF04222B);

  /// Signature brand gradient (cyan → violet).
  static const LinearGradient brandGradient = LinearGradient(
    colors: [Color(0xFF22D3EE), Color(0xFFA78BFA)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ── Semantic ──────────────────────────────────────────────────────────
  static const Color success = Color(0xFF34D399);
  static const Color warning = Color(0xFFFBBF24);
  static const Color danger = Color(0xFFF87171);
  static const Color info = Color(0xFF60A5FA);

  // ── Dark-theme status chip tones (bg, fg) ─────────────────────────────
  static const Color activeBg = Color(0xFF0B2E23);
  static const Color activeFg = Color(0xFF34D399);
  static const Color pendingBg = Color(0xFF33260A);
  static const Color pendingFg = Color(0xFFFBBF24);
  static const Color inactiveBg = Color(0xFF1A2438);
  static const Color inactiveFg = Color(0xFF8FA1BE);
  static const Color attentionBg = Color(0xFF33160C);
  static const Color attentionFg = Color(0xFFFB923C);
  static const Color dangerBg = Color(0xFF331014);
  static const Color dangerFg = Color(0xFFF87171);

  /// Soft glow used behind hero elements.
  static const Color glowCyan = Color(0x3322D3EE);
  static const Color glowViolet = Color(0x33A78BFA);
}

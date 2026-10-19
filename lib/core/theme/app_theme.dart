import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_spacing.dart';

/// Polished dark theme for the CloudsBin brand.
///
/// Single source of truth for Material-level styling; feature screens
/// compose on top of these tokens plus the shared primitives in
/// `lib/shared/widgets/`.
class AppTheme {
  const AppTheme._();

  static ThemeData get dark => _dark;
  static ThemeData get light => _dark; // dark-first brand; kept for compat.

  static final ThemeData _dark = _build();

  static ThemeData _build() {
    const scheme = ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.accent,
      onPrimary: AppColors.onAccent,
      primaryContainer: AppColors.bg3,
      onPrimaryContainer: AppColors.textPrimary,
      secondary: AppColors.accentViolet,
      onSecondary: AppColors.onAccent,
      secondaryContainer: AppColors.bg3,
      onSecondaryContainer: AppColors.textPrimary,
      tertiary: AppColors.info,
      error: AppColors.danger,
      onError: Color(0xFF2B0B0E),
      errorContainer: AppColors.dangerBg,
      onErrorContainer: AppColors.dangerFg,
      surface: AppColors.bg1,
      onSurface: AppColors.textPrimary,
      surfaceContainerHighest: AppColors.bg3,
      surfaceContainerHigh: AppColors.bg2,
      outline: AppColors.textMuted,
      outlineVariant: AppColors.line,
      scrim: Colors.black54,
    );

    final base = ThemeData(useMaterial3: true, colorScheme: scheme);

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.bg0,
      splashFactory: InkSparkle.splashFactory,
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.textPrimary,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.2,
          color: AppColors.textPrimary,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: AppColors.bg2,
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          side: const BorderSide(color: AppColors.line),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.bg3,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        hintStyle:
            const TextStyle(color: AppColors.textMuted, fontSize: 15),
        labelStyle:
            const TextStyle(color: AppColors.textSecondary, fontSize: 15),
        floatingLabelStyle:
            const TextStyle(color: AppColors.accent, fontSize: 13),
        prefixIconColor: AppColors.textMuted,
        suffixIconColor: AppColors.textMuted,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColors.line),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColors.line),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide:
              const BorderSide(color: AppColors.accent, width: 1.6),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide:
              const BorderSide(color: AppColors.danger, width: 1.4),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide:
              const BorderSide(color: AppColors.danger, width: 1.6),
        ),
        errorStyle:
            const TextStyle(color: AppColors.danger, fontSize: 12.5),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: AppColors.onAccent,
          disabledBackgroundColor: AppColors.bg3,
          disabledForegroundColor: AppColors.textMuted,
          minimumSize: const Size.fromHeight(54),
          textStyle: const TextStyle(
            fontSize: 15.5,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          disabledForegroundColor: AppColors.textMuted,
          minimumSize: const Size.fromHeight(54),
          side: const BorderSide(color: AppColors.line, width: 1.4),
          textStyle: const TextStyle(
            fontSize: 15.5,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.accent,
          textStyle: const TextStyle(
            fontSize: 14.5,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: AppColors.textSecondary,
          backgroundColor: AppColors.bg2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.sm),
            side: const BorderSide(color: AppColors.line),
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.bg3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          side: const BorderSide(color: AppColors.line),
        ),
        contentTextStyle:
            const TextStyle(color: AppColors.textPrimary, fontSize: 14),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.bg2,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xl),
          side: const BorderSide(color: AppColors.line),
        ),
        titleTextStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.bg2,
        modalBackgroundColor: AppColors.bg2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadius.xl),
          ),
          side: BorderSide(color: AppColors.line),
        ),
        showDragHandle: true,
      ),
      dividerTheme:
          const DividerThemeData(color: AppColors.line, thickness: 1),
      listTileTheme: const ListTileThemeData(
        iconColor: AppColors.textSecondary,
        textColor: AppColors.textPrimary,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.accent,
      ),
      chipTheme: base.chipTheme.copyWith(
        backgroundColor: AppColors.bg3,
        side: const BorderSide(color: AppColors.line),
        labelStyle:
            const TextStyle(color: AppColors.textSecondary, fontSize: 13),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected)
                ? AppColors.accent
                : AppColors.textMuted),
        trackColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected)
                ? AppColors.accent.withValues(alpha: 0.35)
                : AppColors.bg3),
      ),
      tabBarTheme: const TabBarThemeData(
        labelColor: AppColors.accent,
        unselectedLabelColor: AppColors.textMuted,
        indicatorColor: AppColors.accent,
      ),
    );
  }
}

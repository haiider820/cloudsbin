import 'package:flutter/material.dart';

import '../../../shared/widgets/coming_soon_screen.dart';

/// Phase 12 stub. There is no v1 password-change endpoint, so this stays a
/// coming-soon screen (see COVERAGE.md §6.36).
///
/// NOTE: a full form was deliberately not built here — submitting a
/// password change requires a backend endpoint that does not exist, and
/// the design task's "three AppTextFields" description assumed an API that
/// `AccountRepository` does not expose.
class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComingSoonScreen(
      title: 'Change password',
      subtitle:
          'Self-service password change is not part of the v1 API. Please contact support to change your password.',
    );
  }
}

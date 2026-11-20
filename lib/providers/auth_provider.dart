import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/app_user.dart';

/// The signed-in user, or null before sign-in.
/// Read it in build with `ref.watch(authProvider)`.
final authProvider = NotifierProvider<AuthNotifier, AppUser?>(AuthNotifier.new);

class AuthNotifier extends Notifier<AppUser?> {
  @override
  AppUser? build() => null;

  void signIn({required String email, required UserRole role}) {
    // TODO(Mardon): look up the user in sample_data.dart once it lands.
    // Until then the courses match the Figma frames.
    state = AppUser(
      id: email,
      name: _nameFromEmail(email),
      email: email,
      role: role,
      courseIds: role == UserRole.professor
          ? const ['CS301', 'CS210']
          : const ['CS301', 'MATH201', 'PHYS110'],
    );
  }

  void signOut() => state = null;
}

/// 'e.xushvaqtov@newuu.uz' -> 'E Xushvaqtov'
String _nameFromEmail(String email) {
  return email
      .split('@')
      .first
      .split(RegExp(r'[._-]'))
      .where((part) => part.isNotEmpty)
      .map((part) => part[0].toUpperCase() + part.substring(1))
      .join(' ');
}

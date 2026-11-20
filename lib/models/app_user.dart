// Owner: Asadxon. Added early because sign-in needs it.

enum UserRole { student, professor }

class AppUser {
  const AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.courseIds,
  });

  final String id;
  final String name;
  final String email;
  final UserRole role;
  final List<String> courseIds;

  bool get isProfessor => role == UserRole.professor;
}

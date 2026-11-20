import 'package:material_ui/material_ui.dart';

import 'screens/course_detail_screen.dart';
import 'screens/home_shell.dart';
import 'screens/login_screen.dart';
import 'screens/post_update_screen.dart';
import 'screens/room_schedule_screen.dart';
import 'theme/app_theme.dart';

/// Route names. Always navigate with these, never with a typed string.
abstract final class AppRoutes {
  static const login = '/login';

  /// Home shell with the Today, Deadlines and Rooms tabs.
  static const home = '/home';

  /// Argument: `String courseId`, e.g. `'CS301'`.
  static const course = '/course';

  /// Returns the new `CourseUpdate` with `Navigator.pop(context, update)`.
  /// Read it as: `final result = await Navigator.pushNamed(context, AppRoutes.post);`
  /// then `if (result is CourseUpdate) ...`.
  static const post = '/post';

  /// Argument: `String room`, e.g. `'B-204'`.
  static const room = '/room';
}

class BlueBerryApp extends StatelessWidget {
  const BlueBerryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BlueBerry',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      initialRoute: AppRoutes.login,
      routes: {
        AppRoutes.login: (_) => const LoginScreen(),
        AppRoutes.home: (_) => const HomeShell(),
        AppRoutes.post: (_) => const PostUpdateScreen(),
      },
      onGenerateRoute: _routeWithArgument,
    );
  }

  /// Routes that take an argument pass it to the screen's constructor.
  static Route<dynamic>? _routeWithArgument(RouteSettings settings) {
    return switch (settings.name) {
      AppRoutes.course => MaterialPageRoute(
        settings: settings,
        builder: (_) =>
            CourseDetailScreen(courseId: settings.arguments as String),
      ),
      AppRoutes.room => MaterialPageRoute(
        settings: settings,
        builder: (_) => RoomScheduleScreen(room: settings.arguments as String),
      ),
      _ => null,
    };
  }
}

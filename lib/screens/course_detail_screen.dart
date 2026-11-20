import 'package:material_ui/material_ui.dart';

// Screen 3 · Course detail. Owner: Istamjon.
// One course's update history and deadlines, in two tabs.
// Opened with: Navigator.pushNamed(context, AppRoutes.course, arguments: courseId)
// Figma: "3. CS301 · Updates", "3. CS301 · Deadlines" and the other courses.
//
// Placeholder from the project skeleton. Replace everything below.

class CourseDetailScreen extends StatelessWidget {
  const CourseDetailScreen({super.key, required this.courseId});

  final String courseId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(courseId)),
      body: const Center(
        child: Text('Course detail · Istamjon is building this'),
      ),
    );
  }
}

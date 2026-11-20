import 'package:material_ui/material_ui.dart';

// Screen 5 · Post update. Owner: Elshod.
// A professor posts a typed update to one course.
// Opened from the + button on the Today feed. When the form is valid, close
// with Navigator.pop(context, update) where update is the new CourseUpdate.
// Don't add it to updatesProvider here; the Today feed does that.
// Figma: "5. Post update".
//
// Placeholder from the project skeleton. Replace everything below.

class PostUpdateScreen extends StatelessWidget {
  const PostUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post update')),
      body: const Center(child: Text('Post update · Elshod is building this')),
    );
  }
}

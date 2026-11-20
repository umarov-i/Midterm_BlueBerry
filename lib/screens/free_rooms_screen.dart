import 'package:material_ui/material_ui.dart';

import '../app.dart';

// Screen 6 · Free rooms. Owner: Sardor.
// Classrooms free right now, and for how long.
// Figma: "6. Free rooms — Student · Any time", "· 1 h+", "· 2 h+".
//
// Placeholder from the project skeleton. Replace everything below.

class FreeRoomsScreen extends StatelessWidget {
  const FreeRoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Free rooms')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Free rooms · Sardor is building this'),
            const SizedBox(height: 16),
            // Temporary link so Room schedule can be opened before this screen exists.
            OutlinedButton(
              onPressed: () => Navigator.pushNamed(
                context,
                AppRoutes.room,
                arguments: 'B-204',
              ),
              child: const Text('Open B-204'),
            ),
          ],
        ),
      ),
    );
  }
}

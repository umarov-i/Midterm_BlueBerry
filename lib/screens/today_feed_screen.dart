import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../app.dart';
import '../providers/auth_provider.dart';

// Screen 2 · Today feed. Owner: Istamjon.
// Today's classes and new updates for the user's courses, newest first.
// Figma: "2. Today — Student", "2b. Today — Professor",
// "2c. Today — Professor (after posting)".
//
// Placeholder from the project skeleton. Replace everything below.

class TodayFeedScreen extends ConsumerWidget {
  const TodayFeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Today')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Signed in as ${user?.name} (${user?.role.name})'),
            const SizedBox(height: 4),
            const Text('Today feed · Istamjon is building this'),
            const SizedBox(height: 16),
            // Temporary link so Course detail can be opened before this screen exists.
            OutlinedButton(
              onPressed: () => Navigator.pushNamed(
                context,
                AppRoutes.course,
                arguments: 'CS301',
              ),
              child: const Text('Open CS301'),
            ),
          ],
        ),
      ),
      floatingActionButton: (user?.isProfessor ?? false)
          ? FloatingActionButton(
              tooltip: 'Post update',
              // Istamjon: add the returned update with
              // ref.read(updatesProvider.notifier).add(result).
              onPressed: () => Navigator.pushNamed(context, AppRoutes.post),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}

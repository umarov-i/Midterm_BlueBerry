import 'package:material_ui/material_ui.dart';

// Screen 7 · Room schedule. Owner: Sardor.
// One room's day, to see how long it stays free.
// Opened with: Navigator.pushNamed(context, AppRoutes.room, arguments: 'B-204')
// Figma: "7. Room — A-101", "7. Room — B-204" and the other rooms.
//
// Placeholder from the project skeleton. Replace everything below.

class RoomScheduleScreen extends StatelessWidget {
  const RoomScheduleScreen({super.key, required this.room});

  final String room;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(room)),
      body: const Center(
        child: Text('Room schedule · Sardor is building this'),
      ),
    );
  }
}

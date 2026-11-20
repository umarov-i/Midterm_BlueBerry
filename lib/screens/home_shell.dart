import 'package:material_ui/material_ui.dart';

import 'deadlines_screen.dart';
import 'free_rooms_screen.dart';
import 'today_feed_screen.dart';

// Home shell with the bottom navigation bar. Owner: Mardon.
// Each tab is its own screen with its own Scaffold, AppBar and buttons.

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _tab = 0;

  static const _tabs = [
    TodayFeedScreen(),
    DeadlinesScreen(),
    FreeRoomsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack keeps each tab's scroll position and filters when switching.
      body: IndexedStack(index: _tab, children: _tabs),
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
        ),
        child: NavigationBar(
          selectedIndex: _tab,
          onDestinationSelected: (index) => setState(() => _tab = index),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              label: 'Today',
            ),
            NavigationDestination(
              icon: Icon(Icons.calendar_today_outlined),
              label: 'Deadlines',
            ),
            NavigationDestination(
              icon: Icon(Icons.door_front_door_outlined),
              label: 'Rooms',
            ),
          ],
        ),
      ),
    );
  }
}

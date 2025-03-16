import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zenflow/core/constants/route_constants.dart';

class ZenBottomNav extends StatelessWidget {
  final int currentIndex;

  const ZenBottomNav({Key? key, this.currentIndex = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.task_alt), label: 'Tasks'),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Journal'),
        BottomNavigationBarItem(
          icon: Icon(Icons.self_improvement),
          label: 'Mindfulness',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.emoji_events),
          label: 'Achievements',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
      onTap: (index) {
        if (index == currentIndex) return;

        switch (index) {
          case 0:
            context.go(RouteConstants.tasks);
            break;
          case 1:
            context.go(RouteConstants.journal);
            break;
          case 2:
            context.go(RouteConstants.mindfulness);
            break;
          case 3:
            context.go(RouteConstants.gamification);
            break;
          case 4:
            context.go(RouteConstants.settings);
            break;
        }
      },
    );
  }
}

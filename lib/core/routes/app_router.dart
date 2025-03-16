import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zenflow/core/constants/route_constants.dart';
import 'package:zenflow/features/journal/presentation/screens/journal_screen.dart';
import 'package:zenflow/features/mindfulness/presentation/screens/mindfulness_screen.dart';
import 'package:zenflow/features/tasks/presentation/screens/tasks_screen.dart';
import 'package:zenflow/features/auth/presentation/screens/login_screen.dart';
import 'package:zenflow/features/home/presentation/screens/home_screen.dart';
import 'package:zenflow/features/profile/presentation/screens/profile_screen.dart';
import 'package:zenflow/widgets/common/zen_app_bar.dart';
import 'package:zenflow/widgets/common/zen_bottom_nav.dart';

final appRouter = GoRouter(
  initialLocation: RouteConstants.home,
  routes: [
    // Main routes
    GoRoute(
      path: RouteConstants.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: RouteConstants.tasks,
      builder: (context, state) => const TasksScreen(),
    ),
    GoRoute(
      path: RouteConstants.journal,
      builder: (context, state) => const JournalScreen(),
    ),
    GoRoute(
      path: RouteConstants.mindfulness,
      builder: (context, state) => const MindfulnessScreen(),
    ),
    GoRoute(
      path: RouteConstants.profile,
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: RouteConstants.gamification,
      builder:
          (context, state) => const Scaffold(
            appBar: ZenAppBar(title: 'Achievements'),
            body: Center(child: Text('Achievements coming soon')),
            bottomNavigationBar: ZenBottomNav(currentIndex: 3),
          ),
    ),
    GoRoute(
      path: RouteConstants.settings,
      builder:
          (context, state) => const Scaffold(
            appBar: ZenAppBar(title: 'Settings'),
            body: Center(child: Text('Settings coming soon')),
            bottomNavigationBar: ZenBottomNav(currentIndex: 4),
          ),
    ),

    // Auth routes
    GoRoute(
      path: RouteConstants.login,
      builder: (context, state) => const LoginScreen(),
    ),
  ],
);

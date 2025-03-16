import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zenflow/core/constants/route_constants.dart';
import 'package:zenflow/widgets/common/zen_app_bar.dart';
import 'package:zenflow/widgets/common/zen_bottom_nav.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ZenAppBar(title: 'ZenFlow'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to ZenFlow',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Your personal wellness companion',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
                _buildFeatureCard(
                  context,
                  'Tasks',
                  Icons.task_alt,
                  RouteConstants.tasks,
                ),
                _buildFeatureCard(
                  context,
                  'Journal',
                  Icons.book,
                  RouteConstants.journal,
                ),
                _buildFeatureCard(
                  context,
                  'Mindfulness',
                  Icons.self_improvement,
                  RouteConstants.mindfulness,
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const ZenBottomNav(),
    );
  }

  Widget _buildFeatureCard(BuildContext context, String title, IconData icon, String route) {
    return InkWell(
      onTap: () => context.go(route),
      child: Card(
        elevation: 4,
        child: SizedBox(
          width: 150,
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50),
              const SizedBox(height: 10),
              Text(title, style: const TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
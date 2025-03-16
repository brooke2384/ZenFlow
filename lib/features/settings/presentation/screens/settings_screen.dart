import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zenflow/core/theme/theme_provider.dart';
import 'package:zenflow/core/theme/theme_selector_provider.dart';
import 'package:zenflow/features/gamification/domain/models/user_profile_model.dart';
import 'package:zenflow/widgets/common/zen_app_bar.dart';
import 'package:zenflow/widgets/common/zen_bottom_nav.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final selectedTheme = ref.watch(selectedThemeNameProvider);
    
    // This would come from a user profile provider in a real implementation
    final bool isPremiumUser = false;

    return Scaffold(
      appBar: const ZenAppBar(title: 'Settings'),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSectionTitle(context, 'Appearance'),
          _buildThemeModeSelector(context, themeMode, ref),
          const SizedBox(height: 16),
          _buildThemeSelector(context, selectedTheme, isPremiumUser, ref),
          const Divider(height: 32),
          
          _buildSectionTitle(context, 'Premium Features'),
          _buildPremiumStatus(context, isPremiumUser),
          if (!isPremiumUser) _buildUpgradeButton(context),
          
          const Divider(height: 32),
          _buildSectionTitle(context, 'Notifications'),
          SwitchListTile(
            title: const Text('Daily Reminders'),
            subtitle: const Text('Receive daily reminders for tasks and journaling'),
            value: true, // This would be from a provider in real implementation
            onChanged: (value) {
              // Update notification settings
            },
          ),
          
          const Divider(height: 32),
          _buildSectionTitle(context, 'Data & Privacy'),
          ListTile(
            title: const Text('Export Data'),
            subtitle: const Text('Export your journal entries and tasks'),
            trailing: const Icon(Icons.download),
            onTap: () {
              // Handle data export
            },
          ),
          ListTile(
            title: const Text('Delete Account'),
            subtitle: const Text('Permanently delete your account and data'),
            trailing: const Icon(Icons.delete_forever, color: Colors.red),
            onTap: () {
              // Show delete account confirmation
            },
          ),
        ],
      ),
      bottomNavigationBar: const ZenBottomNav(currentIndex: 4),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Widget _buildThemeModeSelector(BuildContext context, ThemeMode currentMode, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Theme Mode'),
            const SizedBox(height: 8),
            SegmentedButton<ThemeMode>(
              segments: const [
                ButtonSegment<ThemeMode>(
                  value: ThemeMode.light,
                  label: Text('Light'),
                  icon: Icon(Icons.light_mode),
                ),
                ButtonSegment<ThemeMode>(
                  value: ThemeMode.dark,
                  label: Text('Dark'),
                  icon: Icon(Icons.dark_mode),
                ),
                ButtonSegment<ThemeMode>(
                  value: ThemeMode.system,
                  label: Text('System'),
                  icon: Icon(Icons.settings_suggest),
                ),
              ],
              selected: {currentMode},
              onSelectionChanged: (Set<ThemeMode> selected) {
                if (selected.isNotEmpty) {
                  saveThemeMode(selected.first);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeSelector(BuildContext context, String currentTheme, bool isPremiumUser, WidgetRef ref) {
    final themes = [
      {'name': 'default', 'displayName': 'Default', 'isPremium': false},
      {'name': 'auroraBorealis', 'displayName': 'Aurora Borealis', 'isPremium': true},
      {'name': 'zenGarden', 'displayName': 'Zen Garden', 'isPremium': true},
      {'name': 'midnightGold', 'displayName': 'Midnight Gold', 'isPremium': true},
      {'name': 'minimalFrost', 'displayName': 'Minimal Frost', 'isPremium': true},
      {'name': 'sunsetSerenity', 'displayName': 'Sunset Serenity', 'isPremium': true},
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Theme Style'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: themes.map((theme) {
                final bool isSelected = theme['name'] == currentTheme;
                final bool isPremium = theme['isPremium'] as bool;
                final bool isAvailable = !isPremium || isPremiumUser;

                return GestureDetector(
                  onTap: isAvailable
                      ? () {
                          saveThemeName(theme['name'] as String);
                        }
                      : () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('This is a premium theme. Upgrade to access it.'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary.withOpacity(0.2)
                          : Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.outline,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.palette,
                                color: isSelected
                                    ? Theme.of(context).colorScheme.primary
                                    : null,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                theme['displayName'] as String,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: isSelected
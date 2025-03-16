import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../lib/core/theme/app_theme.dart';

class ZenAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool centerTitle;
  final double elevation;

  const ZenAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.centerTitle = true,
    this.elevation = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: centerTitle,
      elevation: elevation,
      actions: [
        ...?actions,
        IconButton(
          icon: Icon(
            ref.watch(themeModeProvider) == ThemeMode.dark
                ? Icons.light_mode
                : Icons.dark_mode,
          ),
          onPressed: () {
            ref.read(themeModeProvider.notifier).state =
                ref.read(themeModeProvider) == ThemeMode.dark
                    ? ThemeMode.light
                    : ThemeMode.dark;
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
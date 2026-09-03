import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/theme_provider.dart';

class ThemeSwitcherPage extends ConsumerWidget {
  const ThemeSwitcherPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Switching'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Select your preferred theme. This selection is persisted locally.',
          ),
          const SizedBox(height: 24),
          RadioListTile<ThemeMode>(
            title: const Text('System Default'),
            value: ThemeMode.system,
            groupValue: themeMode,
            onChanged: (mode) {
              if (mode != null) {
                ref.read(themeProvider.notifier).setTheme(mode);
              }
            },
          ),
          RadioListTile<ThemeMode>(
            title: const Text('Light Theme'),
            value: ThemeMode.light,
            groupValue: themeMode,
            onChanged: (mode) {
              if (mode != null) {
                ref.read(themeProvider.notifier).setTheme(mode);
              }
            },
          ),
          RadioListTile<ThemeMode>(
            title: const Text('Dark Theme'),
            value: ThemeMode.dark,
            groupValue: themeMode,
            onChanged: (mode) {
              if (mode != null) {
                ref.read(themeProvider.notifier).setTheme(mode);
              }
            },
          ),
        ],
      ),
    );
  }
}

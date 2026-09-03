import 'package:flutter/material.dart';

class AnimationsPage extends StatefulWidget {
  const AnimationsPage({super.key});

  @override
  State<AnimationsPage> createState() => _AnimationsPageState();
}

class _AnimationsPageState extends State<AnimationsPage> {
  bool _expanded = false;
  bool _isFavourited = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Animations')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Animated Container', style: theme.textTheme.titleLarge),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => setState(() => _expanded = !_expanded),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: double.infinity,
                height: _expanded ? 200 : 100,
                decoration: BoxDecoration(
                  color: _expanded
                      ? theme.colorScheme.primary
                      : theme.colorScheme.secondary,
                  borderRadius: BorderRadius.circular(_expanded ? 24 : 12),
                ),
                alignment: Alignment.center,
                child: Text(
                  _expanded ? 'Expanded' : 'Tap to Expand',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text('Animated Switcher', style: theme.textTheme.titleLarge),
            const SizedBox(height: 16),
            Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: IconButton(
                  key: ValueKey<bool>(_isFavourited),
                  iconSize: 64,
                  color: _isFavourited ? Colors.red : Colors.grey,
                  icon: Icon(
                    _isFavourited ? Icons.favorite : Icons.favorite_border,
                  ),
                  onPressed: () =>
                      setState(() => _isFavourited = !_isFavourited),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

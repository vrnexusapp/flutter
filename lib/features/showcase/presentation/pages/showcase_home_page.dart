import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShowcaseItem {
  final String title;
  final String description;
  final IconData icon;
  final String route;
  final String difficulty;
  final List<String> tags;

  const ShowcaseItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.route,
    required this.difficulty,
    required this.tags,
  });
}

class ShowcaseHomePage extends StatelessWidget {
  const ShowcaseHomePage({super.key});

  static const List<ShowcaseItem> items = [
    ShowcaseItem(
      title: 'API Products List',
      description: 'Dio, Riverpod, Pagination, Shimmer, Search, Refresh',
      icon: Icons.shopping_bag_outlined,
      route: '/products',
      difficulty: 'Intermediate',
      tags: ['API', 'State Management', 'Lists'],
    ),
    ShowcaseItem(
      title: 'Theme Switching',
      description: 'Light/Dark mode toggle with persistence',
      icon: Icons.palette_outlined,
      route: '/theme',
      difficulty: 'Beginner',
      tags: ['UI', 'Storage'],
    ),
    ShowcaseItem(
      title: 'Authentication Forms',
      description: 'Form validation, custom text fields, mock login',
      icon: Icons.login_outlined,
      route: '/login',
      difficulty: 'Beginner',
      tags: ['Forms', 'UI'],
    ),
    ShowcaseItem(
      title: 'Animations',
      description: 'AnimatedContainer, AnimatedSwitcher, Hero',
      icon: Icons.animation,
      route: '/animations',
      difficulty: 'Intermediate',
      tags: ['UI', 'Animations'],
    ),
    ShowcaseItem(
      title: 'Responsive Dashboard',
      description: 'Mobile/Tablet/Desktop adaptive layout',
      icon: Icons.dashboard,
      route: '/dashboard',
      difficulty: 'Intermediate',
      tags: ['Layout', 'UI'],
    ),
    ShowcaseItem(
      title: 'Local Favourites',
      description: 'Save products to local storage',
      icon: Icons.favorite,
      route: '/favourites',
      difficulty: 'Intermediate',
      tags: ['Storage', 'State'],
    ),
    ShowcaseItem(
      title: 'Dialogs & Bottom Sheets',
      description: 'Reusable modal components',
      icon: Icons.open_in_new,
      route: '/dialogs',
      difficulty: 'Beginner',
      tags: ['UI', 'Modals'],
    ),
    ShowcaseItem(
      title: 'File & Image Selection',
      description: 'Mock native file picker UI',
      icon: Icons.attach_file,
      route: '/media',
      difficulty: 'Beginner',
      tags: ['Forms', 'UI'],
    ),
    // Additional items can be added here as implemented
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter UI Showcase'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              // Show info dialog
            },
          )
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  if (item.route.isNotEmpty && item.route != '/') {
                    context.push(item.route);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Coming soon!')),
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(item.icon, color: theme.colorScheme.primary),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.title, style: theme.textTheme.titleMedium),
                                const SizedBox(height: 4),
                                Text(item.description, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.7))),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          _buildChip(context, item.difficulty, isDifficulty: true),
                          const SizedBox(width: 8),
                          ...item.tags.take(2).map((tag) => Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: _buildChip(context, tag),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildChip(BuildContext context, String label, {bool isDifficulty = false}) {
    final theme = Theme.of(context);
    final color = isDifficulty ? _getDifficultyColor(label) : theme.colorScheme.secondary;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        return Colors.green;
      case 'intermediate':
        return Colors.orange;
      case 'advanced':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

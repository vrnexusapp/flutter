import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../features/showcase/presentation/pages/showcase_home_page.dart';
import '../features/showcase/presentation/pages/theme_switcher_page.dart';
import '../features/products/presentation/pages/products_page.dart';
import '../features/products/presentation/pages/product_details_page.dart';
import '../features/products/data/models/product_model.dart';
import '../features/forms/presentation/pages/login_page.dart';
import '../features/animations/presentation/pages/animations_page.dart';
import '../features/dashboard/presentation/pages/dashboard_page.dart';
import '../features/favourites/presentation/pages/favourites_page.dart';
import '../features/dialogs/presentation/pages/dialogs_page.dart';
import '../features/media/presentation/pages/media_page.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const ShowcaseHomePage(),
      ),
      GoRoute(
        path: '/theme',
        name: 'theme',
        builder: (context, state) => const ThemeSwitcherPage(),
      ),
      GoRoute(
        path: '/products',
        name: 'products',
        builder: (context, state) => const ProductsPage(),
        routes: [
          GoRoute(
            path: ':id',
            name: 'product_details',
            builder: (context, state) {
              final product = state.extra as Product;
              return ProductDetailsPage(product: product);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/animations',
        name: 'animations',
        builder: (context, state) => const AnimationsPage(),
      ),
      GoRoute(
        path: '/dashboard',
        name: 'dashboard',
        builder: (context, state) => const DashboardPage(),
      ),
      GoRoute(
        path: '/favourites',
        name: 'favourites',
        builder: (context, state) => const FavouritesPage(),
      ),
      GoRoute(
        path: '/dialogs',
        name: 'dialogs',
        builder: (context, state) => const DialogsPage(),
      ),
      GoRoute(
        path: '/media',
        name: 'media',
        builder: (context, state) => const MediaPage(),
      ),
      // Add feature routes here as we build them...
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Route not found: ${state.uri.toString()}'),
      ),
    ),
  );
}

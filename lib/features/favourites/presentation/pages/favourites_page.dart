import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/favourites_provider.dart';
import '../../../products/presentation/controllers/products_provider.dart';
import '../../../products/presentation/widgets/product_card.dart';

class FavouritesPage extends ConsumerWidget {
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favouriteIds = ref.watch(favouritesProvider);
    final productsState = ref.watch(productsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Local Favourites')),
      body: productsState.when(
        data: (state) {
          final favourites = state.products
              .where((product) => favouriteIds.contains(product.id))
              .toList();

          if (favourites.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.favorite_border, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text('No favourites yet.', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  const Text('Go to the products page to add some!'),
                ],
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: favourites.length,
            itemBuilder: (context, index) {
              return ProductCard(
                product: favourites[index],
                onTap: () {},
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error loading products: $error')),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:async';
import '../controllers/products_provider.dart';
import '../widgets/product_card.dart';
import 'dart:ui';
import '../../../../core/theme/animated_glass_background.dart';
import '../widgets/product_card_skeleton.dart';

class ProductsPage extends ConsumerStatefulWidget {
  const ProductsPage({super.key});

  @override
  ConsumerState<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends ConsumerState<ProductsPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      ref.read(productsProvider.notifier).loadMore();
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      ref.read(productsProvider.notifier).search(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    final productsState = ref.watch(productsProvider);

    return AnimatedGlassBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent, // Make scaffold transparent to see background
        extendBodyBehindAppBar: true, // Allow content to scroll under frosted appbar
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(110), // Adjust height for app bar + search
          child: ClipRRect( // Clip the blur to the appbar bounds
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15), // Frosted glass blur
              child: AppBar(
                backgroundColor: Colors.black.withValues(alpha: 0.2), // Translucent dark
                title: const Text('API Products'),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(60),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Search products...',
                        hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
                        prefixIcon: const Icon(Icons.search, color: Colors.white),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear, color: Colors.white),
                                onPressed: () {
                                  _searchController.clear();
                                  _onSearchChanged('');
                                },
                              )
                            : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white.withValues(alpha: 0.1), // Translucent input
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      onChanged: _onSearchChanged,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: productsState.when(
        data: (state) {
          if (state.products.isEmpty) {
            return const Center(child: Text('No products found.'));
          }

          return RefreshIndicator(
            onRefresh: () => ref.read(productsProvider.notifier).refresh(),
            child: GridView.builder(
              controller: _scrollController,
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: MediaQuery.of(context).padding.top + 110 + 16, // Push list down below the floating app bar
                bottom: MediaQuery.of(context).padding.bottom + 80,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.52,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: state.products.length + (state.hasMore ? 2 : 0),
              itemBuilder: (context, index) {
                if (index < state.products.length) {
                  final product = state.products[index];
                  return ProductCard(
                    product: product,
                    onTap: () {
                      context.push('/products/${product.id}', extra: product);
                    },
                  );
                } else {
                  return Shimmer.fromColors(
                    baseColor: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey[850]!
                        : Colors.grey[300]!,
                    highlightColor: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey[800]!
                        : Colors.grey[100]!,
                    child: const ProductCardSkeleton(),
                  );
                }
              },
            ),
          );
        },
        loading: () => Shimmer.fromColors(
          baseColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey[850]!
              : Colors.grey[300]!,
          highlightColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey[800]!
              : Colors.grey[100]!,
          child: GridView.builder(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: MediaQuery.of(context).padding.top + 110 + 16,
              bottom: MediaQuery.of(context).padding.bottom + 80,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.65,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: 6,
            itemBuilder: (context, index) => const ProductCardSkeleton(),
          ),
        ),        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error: ${error.toString()}'),
              ElevatedButton(
                onPressed: () => ref.read(productsProvider.notifier).refresh(),
                child: const Text('Retry'),
              )
            ],
          ),
        ),
      ),
    ));
  }
}

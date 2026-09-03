import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/storage/shared_prefs.dart';

part 'favourites_provider.g.dart';

@riverpod
class FavouritesNotifier extends _$FavouritesNotifier {
  static const _key = 'favourites_list';

  @override
  List<int> build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final list = prefs.getStringList(_key) ?? [];
    return list.map((e) => int.tryParse(e) ?? 0).toList();
  }

  void toggleFavourite(int productId) {
    final currentState = state;
    List<int> newState;
    
    if (currentState.contains(productId)) {
      newState = currentState.where((id) => id != productId).toList();
    } else {
      newState = [...currentState, productId];
    }
    
    state = newState;
    _save(newState);
  }

  void _save(List<int> list) {
    final prefs = ref.read(sharedPreferencesProvider);
    prefs.setStringList(_key, list.map((e) => e.toString()).toList());
  }
}

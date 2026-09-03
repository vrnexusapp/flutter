// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourites_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FavouritesNotifier)
final favouritesProvider = FavouritesNotifierProvider._();

final class FavouritesNotifierProvider
    extends $NotifierProvider<FavouritesNotifier, List<int>> {
  FavouritesNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favouritesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favouritesNotifierHash();

  @$internal
  @override
  FavouritesNotifier create() => FavouritesNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<int> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<int>>(value),
    );
  }
}

String _$favouritesNotifierHash() =>
    r'58c02e22cd73465cf63496ccbe706de4e4073cb8';

abstract class _$FavouritesNotifier extends $Notifier<List<int>> {
  List<int> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<List<int>, List<int>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<int>, List<int>>,
              List<int>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

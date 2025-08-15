// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_notifier_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$playerNotifierHash() => r'f6f5f1d5448b1c985dbbb6f0a266f22f8d30b225';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$PlayerNotifier extends BuildlessAutoDisposeNotifier<Player> {
  late final dynamic playerId;

  Player build(
    dynamic playerId,
  );
}

/// See also [PlayerNotifier].
@ProviderFor(PlayerNotifier)
const playerNotifierProvider = PlayerNotifierFamily();

/// See also [PlayerNotifier].
class PlayerNotifierFamily extends Family<Player> {
  /// See also [PlayerNotifier].
  const PlayerNotifierFamily();

  /// See also [PlayerNotifier].
  PlayerNotifierProvider call(
    dynamic playerId,
  ) {
    return PlayerNotifierProvider(
      playerId,
    );
  }

  @override
  PlayerNotifierProvider getProviderOverride(
    covariant PlayerNotifierProvider provider,
  ) {
    return call(
      provider.playerId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'playerNotifierProvider';
}

/// See also [PlayerNotifier].
class PlayerNotifierProvider
    extends AutoDisposeNotifierProviderImpl<PlayerNotifier, Player> {
  /// See also [PlayerNotifier].
  PlayerNotifierProvider(
    dynamic playerId,
  ) : this._internal(
          () => PlayerNotifier()..playerId = playerId,
          from: playerNotifierProvider,
          name: r'playerNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$playerNotifierHash,
          dependencies: PlayerNotifierFamily._dependencies,
          allTransitiveDependencies:
              PlayerNotifierFamily._allTransitiveDependencies,
          playerId: playerId,
        );

  PlayerNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.playerId,
  }) : super.internal();

  final dynamic playerId;

  @override
  Player runNotifierBuild(
    covariant PlayerNotifier notifier,
  ) {
    return notifier.build(
      playerId,
    );
  }

  @override
  Override overrideWith(PlayerNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: PlayerNotifierProvider._internal(
        () => create()..playerId = playerId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        playerId: playerId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<PlayerNotifier, Player> createElement() {
    return _PlayerNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PlayerNotifierProvider && other.playerId == playerId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, playerId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PlayerNotifierRef on AutoDisposeNotifierProviderRef<Player> {
  /// The parameter `playerId` of this provider.
  dynamic get playerId;
}

class _PlayerNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<PlayerNotifier, Player>
    with PlayerNotifierRef {
  _PlayerNotifierProviderElement(super.provider);

  @override
  dynamic get playerId => (origin as PlayerNotifierProvider).playerId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

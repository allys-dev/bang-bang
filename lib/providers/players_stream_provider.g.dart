// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'players_stream_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$playersStreamHash() => r'1652d86fca7325c74b5f2690556fc757da02ab15';

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

abstract class _$PlayersStream
    extends BuildlessAutoDisposeStreamNotifier<List<Player>> {
  late final dynamic gameCode;

  Stream<List<Player>> build(
    dynamic gameCode,
  );
}

/// See also [PlayersStream].
@ProviderFor(PlayersStream)
const playersStreamProvider = PlayersStreamFamily();

/// See also [PlayersStream].
class PlayersStreamFamily extends Family<AsyncValue<List<Player>>> {
  /// See also [PlayersStream].
  const PlayersStreamFamily();

  /// See also [PlayersStream].
  PlayersStreamProvider call(
    dynamic gameCode,
  ) {
    return PlayersStreamProvider(
      gameCode,
    );
  }

  @override
  PlayersStreamProvider getProviderOverride(
    covariant PlayersStreamProvider provider,
  ) {
    return call(
      provider.gameCode,
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
  String? get name => r'playersStreamProvider';
}

/// See also [PlayersStream].
class PlayersStreamProvider
    extends AutoDisposeStreamNotifierProviderImpl<PlayersStream, List<Player>> {
  /// See also [PlayersStream].
  PlayersStreamProvider(
    dynamic gameCode,
  ) : this._internal(
          () => PlayersStream()..gameCode = gameCode,
          from: playersStreamProvider,
          name: r'playersStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$playersStreamHash,
          dependencies: PlayersStreamFamily._dependencies,
          allTransitiveDependencies:
              PlayersStreamFamily._allTransitiveDependencies,
          gameCode: gameCode,
        );

  PlayersStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.gameCode,
  }) : super.internal();

  final dynamic gameCode;

  @override
  Stream<List<Player>> runNotifierBuild(
    covariant PlayersStream notifier,
  ) {
    return notifier.build(
      gameCode,
    );
  }

  @override
  Override overrideWith(PlayersStream Function() create) {
    return ProviderOverride(
      origin: this,
      override: PlayersStreamProvider._internal(
        () => create()..gameCode = gameCode,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        gameCode: gameCode,
      ),
    );
  }

  @override
  AutoDisposeStreamNotifierProviderElement<PlayersStream, List<Player>>
      createElement() {
    return _PlayersStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PlayersStreamProvider && other.gameCode == gameCode;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, gameCode.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PlayersStreamRef on AutoDisposeStreamNotifierProviderRef<List<Player>> {
  /// The parameter `gameCode` of this provider.
  dynamic get gameCode;
}

class _PlayersStreamProviderElement
    extends AutoDisposeStreamNotifierProviderElement<PlayersStream,
        List<Player>> with PlayersStreamRef {
  _PlayersStreamProviderElement(super.provider);

  @override
  dynamic get gameCode => (origin as PlayersStreamProvider).gameCode;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

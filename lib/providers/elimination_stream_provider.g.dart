// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'elimination_stream_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$eliminationStreamHash() => r'ca45a81d3b84dc059c847ac312620cd0a3d368d4';

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

abstract class _$EliminationStream
    extends BuildlessAutoDisposeStreamNotifier<List<Elimination>> {
  late final dynamic gameCode;

  Stream<List<Elimination>> build(
    dynamic gameCode,
  );
}

/// See also [EliminationStream].
@ProviderFor(EliminationStream)
const eliminationStreamProvider = EliminationStreamFamily();

/// See also [EliminationStream].
class EliminationStreamFamily extends Family<AsyncValue<List<Elimination>>> {
  /// See also [EliminationStream].
  const EliminationStreamFamily();

  /// See also [EliminationStream].
  EliminationStreamProvider call(
    dynamic gameCode,
  ) {
    return EliminationStreamProvider(
      gameCode,
    );
  }

  @override
  EliminationStreamProvider getProviderOverride(
    covariant EliminationStreamProvider provider,
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
  String? get name => r'eliminationStreamProvider';
}

/// See also [EliminationStream].
class EliminationStreamProvider extends AutoDisposeStreamNotifierProviderImpl<
    EliminationStream, List<Elimination>> {
  /// See also [EliminationStream].
  EliminationStreamProvider(
    dynamic gameCode,
  ) : this._internal(
          () => EliminationStream()..gameCode = gameCode,
          from: eliminationStreamProvider,
          name: r'eliminationStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$eliminationStreamHash,
          dependencies: EliminationStreamFamily._dependencies,
          allTransitiveDependencies:
              EliminationStreamFamily._allTransitiveDependencies,
          gameCode: gameCode,
        );

  EliminationStreamProvider._internal(
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
  Stream<List<Elimination>> runNotifierBuild(
    covariant EliminationStream notifier,
  ) {
    return notifier.build(
      gameCode,
    );
  }

  @override
  Override overrideWith(EliminationStream Function() create) {
    return ProviderOverride(
      origin: this,
      override: EliminationStreamProvider._internal(
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
  AutoDisposeStreamNotifierProviderElement<EliminationStream, List<Elimination>>
      createElement() {
    return _EliminationStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EliminationStreamProvider && other.gameCode == gameCode;
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
mixin EliminationStreamRef
    on AutoDisposeStreamNotifierProviderRef<List<Elimination>> {
  /// The parameter `gameCode` of this provider.
  dynamic get gameCode;
}

class _EliminationStreamProviderElement
    extends AutoDisposeStreamNotifierProviderElement<EliminationStream,
        List<Elimination>> with EliminationStreamRef {
  _EliminationStreamProviderElement(super.provider);

  @override
  dynamic get gameCode => (origin as EliminationStreamProvider).gameCode;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

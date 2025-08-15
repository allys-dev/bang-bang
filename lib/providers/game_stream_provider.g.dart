// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_stream_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$gameStreamHash() => r'08074b476ac138936b16394e20b648ab5ecb2ab6';

/// See also [GameStream].
@ProviderFor(GameStream)
final gameStreamProvider =
    AutoDisposeStreamNotifierProvider<GameStream, List<Game>>.internal(
  GameStream.new,
  name: r'gameStreamProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$gameStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GameStream = AutoDisposeStreamNotifier<List<Game>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

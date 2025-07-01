import 'package:bang_bang/providers/game_stream_provider.dart';
import 'package:bang_bang/providers/player_provider.dart';
import 'package:bang_bang/views/pages/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WidgetTree extends ConsumerWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(playerNotifierProvider);
    ref.watch(gameStreamProvider);
    return LandingPage();
  }
}

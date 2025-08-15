import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bang_bang/providers/local_data_notifier_provider.dart';
import 'package:bang_bang/views/pages/get_ready_page.dart';

class GetReadyGuard extends ConsumerWidget {
  const GetReadyGuard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localDataAsync = ref.watch(localDataNotifierProvider);

    return localDataAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (err, stack) => Scaffold(
        body: Center(child: Text('Error loading data')),
      ),
      data: (localData) {
        if (localData.gameCode.isEmpty) {
          print("waiting for gameCode to be set");
          // Wait until gameCode is set, show loading spinner
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return const GetReadyPage();
      },
    );
  }
}
import 'package:bang_bang/data/supabase_config.dart';
import 'package:bang_bang/providers/game_stream_provider.dart';
import 'package:bang_bang/providers/local_data_notifier_provider.dart';
import 'package:bang_bang/routes/route_configs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Supabase.initialize(
    url: SupabaseConfig.supabaseUrl,
    anonKey: SupabaseConfig.supabaseApiKey,
  );

  runApp(const ProviderScope(child: BangBang()));
}

final supabase = Supabase.instance.client;

class BangBang extends ConsumerWidget {
  const BangBang({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    ref.watch(gameStreamProvider);
    ref.watch(localDataNotifierProvider);
    
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Bang Bang',
      theme: ThemeData(primarySwatch: Colors.red),
      routerConfig: AppRouter().router
    );
  }
}

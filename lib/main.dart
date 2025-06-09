import 'package:bang_bang/data/game_values.dart';
import 'package:bang_bang/data/supabase_config.dart';
import 'package:bang_bang/views/widget_tree.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_provider/settings_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: SupabaseConfig.supabaseUrl,
    anonKey: SupabaseConfig.supabaseApiKey,
  );

  GameValues game = GameValues();

  await game.initialize();

  runApp(
    Provider(
      create: (BuildContext context) => game,
      child: const BangBang(),
      )
  );
}


final supabase = Supabase.instance.client;

class BangBang extends StatelessWidget {
  const BangBang({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bang Bang',
      theme: ThemeData(primarySwatch: Colors.red),
      home: WidgetTree(),
    );
  }
}

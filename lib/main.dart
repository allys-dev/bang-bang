import 'package:bang_bang/views/widget_tree.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BangBang());
}

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
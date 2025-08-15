import 'package:bang_bang/data/constants.dart';
import 'package:bang_bang/routes/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Text('BANG BANG', style: KTextStyle.heading1),
              ),
            ),
            SizedBox(height: 60),
            ElevatedButton(
              onPressed: () => context.pushNamed(RouteConstants.playPage),
              child: Text('PLAY', style: KTextStyle.heading2),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => context.pushNamed(RouteConstants.howToPage),
              child: Text('HOW TO', style: KTextStyle.heading4),
            ),
          ],
        ),
      ),
    );
  }
}

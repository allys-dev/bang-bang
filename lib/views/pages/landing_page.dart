import 'package:bang_bang/views/pages/how_to_page.dart';
import 'package:bang_bang/views/pages/play_page.dart';
import 'package:flutter/material.dart';

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
                child: Text('BANG BANG', style: TextStyle(fontSize: 30)),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const PlayPage();
                    },
                  ),
                );
              },
              child: const Text('PLAY'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const HowToPage();
                    },
                  ),
                );
              },
              child: const Text('HOW TO'),
            ),
          ],
        ),
      ),
    );
  }
}

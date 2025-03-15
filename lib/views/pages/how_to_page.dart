import 'package:flutter/material.dart';

class HowToPage extends StatefulWidget {
  const HowToPage({super.key});

  @override
  State<HowToPage> createState() => _HowToPageState();
}

class _HowToPageState extends State<HowToPage> with TickerProviderStateMixin {
  late PageController _pageViewController;
  late TabController _tabController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
    _tabController = TabController(length: 8, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PageView(
          controller: _pageViewController,
          onPageChanged: _handlePageViewChanged,
          children: [
            HowToPage1(),
            HowToPage2(),
            HowToPage3(),
            HowToPage4(),
            HowToPage5(),
            HowToPage6(),
            HowToPage7(),
            HowToPage8(),
          ],
        ),
        PageIndicator(
          tabController: _tabController,
          currentPageIndex: _currentPageIndex,
          onUpdateCurrentPageIndex: _updateCurrentPageIndex,
          // isOnDesktopAndWeb: _isOnDesktopAndWeb,
        ),
      ],
    );
  }

  void _handlePageViewChanged(int currentPageIndex) {
    // if (!_isOnDesktopAndWeb) {
    //   return;
    // }
    _tabController.index = currentPageIndex;
    setState(() {
      _currentPageIndex = currentPageIndex;
    });
  }

  void _updateCurrentPageIndex(int index) {
    _tabController.index = index;
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
}

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    required this.tabController,
    required this.currentPageIndex,
    required this.onUpdateCurrentPageIndex,
    // required this.isOnDesktopAndWeb,
  });

  final int currentPageIndex;
  final TabController tabController;
  final void Function(int) onUpdateCurrentPageIndex;
  // final bool isOnDesktopAndWeb;

  @override
  Widget build(BuildContext context) {
    // if (!isOnDesktopAndWeb) {
    //   return const SizedBox.shrink();
    // }
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            splashRadius: 16.0,
            padding: EdgeInsets.zero,
            onPressed: () {
              if (currentPageIndex == 0) {
                return;
              }
              onUpdateCurrentPageIndex(currentPageIndex - 1);
            },
            icon: const Icon(Icons.arrow_left_rounded, size: 32.0),
          ),
          TabPageSelector(
            controller: tabController,
            color: colorScheme.surface,
            selectedColor: colorScheme.primary,
          ),
          IconButton(
            splashRadius: 16.0,
            padding: EdgeInsets.zero,
            onPressed: () {
              if (currentPageIndex == 2) {
                return;
              }
              onUpdateCurrentPageIndex(currentPageIndex + 1);
            },
            icon: const Icon(Icons.arrow_right_rounded, size: 32.0),
          ),
        ],
      ),
    );
  }
}

class HowToPage1 extends StatelessWidget {
  const HowToPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Column(
          children: [
            Text('How to Play', style: TextStyle(fontSize: 30)),
            Text('You need 4 or more friends to start a game'),
            Text('All players must download the app'),
            Text(
              'Follow the prompts on the app to start a game. One the \'Get Ready\' page, enter your name, an everyday object(e.g. a drink, a spoon, a newspaper) and location (e.g. the kitchen, the lounge room, the beach).',
            ),
          ],
        ),
      ),
    );
  }
}

class HowToPage2 extends StatelessWidget {
  const HowToPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Column(
          children: [
            Text('How to Play', style: TextStyle(fontSize: 30)),
            Text('The game is played in person between friends'),
            Text('Each player is given a secret mission'),
            Text('The aim of the game is to kill the most players'),
          ],
        ),
      ),
    );
  }
}

class HowToPage3 extends StatelessWidget {
  const HowToPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Column(
          children: [
            Text('How to Kill', style: TextStyle(fontSize: 30)),
            Text('A successful kill has four elements'),
            Text(
              '1. When you\'re at the correct location, you must hand your target the everyday object',
            ),
          ],
        ),
      ),
    );
  }
}

class HowToPage4 extends StatelessWidget {
  const HowToPage4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Column(
          children: [
            Text('How to Kill', style: TextStyle(fontSize: 30)),
            Text(
              '2. You must whisper \'Bang Bang You\'re Dead\' to the target to complete the kill. Make sure you\'re sneaky. If another player hears you attempting a kill, they can hit the "Overheard a Kill" button in the app and you and the target will be eliminated and the eavesdropper will get an extra target.',
            ),
          ],
        ),
      ),
    );
  }
}

class HowToPage5 extends StatelessWidget {
  const HowToPage5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Column(
          children: [
            Text('How to Kill', style: TextStyle(fontSize: 30)),
            Text(
              '3. Once the kill is completed. You hit \'Eliminate\' on your mission screen and the target will receive a notification to confirm the kill. But, play it cool, and keep it secret.',
            ),
          ],
        ),
      ),
    );
  }
}

class HowToPage6 extends StatelessWidget {
  const HowToPage6({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Column(
          children: [
            Text('How to Kill', style: TextStyle(fontSize: 30)),
            Text(
              '4. You will acquire your next mission from the eliminated target.',
            ),
          ],
        ),
      ),
    );
  }
}

class HowToPage7 extends StatelessWidget {
  const HowToPage7({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Column(
          children: [
            Text('Winning the Game', style: TextStyle(fontSize: 30)),
            Text(
              'At the end of the countdown the scoreboard will be revealed.',
            ),
            Text('The person with the most kills wins.'),
            Text(
              'If there is a tie, the player remaining alive the longest wins.',
            ),
            Text(
              'If there is still no winner, then a group decision of "Most Difficult Kill" will crown the winnder.',
            ),
          ],
        ),
      ),
    );
  }
}

class HowToPage8 extends StatelessWidget {
  const HowToPage8({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Column(
          children: [
            Text('DO NOT', style: TextStyle(fontSize: 30)),
            Text('1. Do not tell anyone your mission.'),
            Text(
              '2. Do not get caught in the act! The key is to keep it a secret.',
            ),
            Text(
              '3. Do not make a scene once you\'ve been killed. All kills are to be kept silent until the end of the game.',
            ),
            Text(
              '4. Do not use violent or inappropraite objects or locations.',
            ),
            Text('5. Do not take your mission literally. It\'s just a game.'),
          ],
        ),
      ),
    );
  }
}

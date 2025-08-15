import 'package:bang_bang/routes/route_constants.dart';
import 'package:bang_bang/views/pages/create_room_page.dart';
import 'package:bang_bang/views/pages/game_tree.dart';
import 'package:bang_bang/views/pages/get_ready_guard.dart';
import 'package:bang_bang/views/pages/get_ready_page.dart';
import 'package:bang_bang/views/pages/how_to_page.dart';
import 'package:bang_bang/views/pages/join_room_page.dart';
import 'package:bang_bang/views/pages/landing_page.dart';
import 'package:bang_bang/views/pages/lobby_page.dart';
import 'package:bang_bang/views/pages/play_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  GoRouter router = GoRouter(
    debugLogDiagnostics: true, // Add this line
    redirect: (context, state) {
      print('Router redirect called: ${state.uri.toString()}');
      // Return null if no redirect needed
      return null;
    },
    routes: [
      GoRoute(
        name: RouteConstants.landingPage,
        path: '/',
        builder: (context, state) => const LandingPage(),
      ),
      GoRoute(
        name: RouteConstants.playPage,
        path: '/play',
        builder: (context, state) => const PlayPage(),
      ),
      GoRoute(
        name: RouteConstants.howToPage,
        path: '/how-to',
        builder: (context, state) => const HowToPage(),
      ),
      GoRoute(
        name: RouteConstants.createRoompage,
        path: '/create-room',
        builder: (context, state) => const CreateRoomPage(),
      ),
      GoRoute(
        name: RouteConstants.joinRoomPage,
        path: '/join-room',
        builder: (context, state) => const JoinRoomPage(),
      ),
      GoRoute(
        name: RouteConstants.getReadyPage,
        path: '/get-ready',
        builder: (context, state) {
          print("Building GetReadyPage route");
          return const GetReadyGuard();
        },
      ),
      GoRoute(
        name: RouteConstants.lobbyPage,
        path: '/lobby',
        builder: (context, state) => const LobbyPage(),
      ),
      GoRoute(
        name: RouteConstants.gameTreePage,
        path: '/game-tree',
        builder: (context, state) => const GameTree(),
      ),
    ],
  );
}

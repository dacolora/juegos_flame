import 'package:flame/flame.dart';
import 'package:hive/hive.dart';
import 'package:flutter/foundation.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'components/player/player_data.dart';
import 'widgets/hud.dart';

import 'widgets/main_menu.dart';

import 'helpers/joypad.dart';
import 'game.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  //Flame.device.setLandscape();
  await initHive();
  runApp(const App());
}

// This function will initilize hive with apps documents directory.
// Additionally it will also register all the hive adapters.
Future<void> initHive() async {
  // For web hive does not need to be initialized.
  if (!kIsWeb) {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
  }

  Hive.registerAdapter<PlayerData>(PlayerDataAdapter());
  //Hive.registerAdapter<Settings>(SettingsAdapter());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ColoRun',
      home: MainGamePage(),
    );
  }
}

class MainGamePage extends StatefulWidget {
  const MainGamePage({Key? key}) : super(key: key);

  @override
  MainGameState createState() => MainGameState();
}

class MainGameState extends State<MainGamePage> {
  ColoRunGame game = ColoRunGame();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
        body: Stack(
          children: [
            GameWidget(
              game: game,
              loadingBuilder: (conetxt) => const Center(
                child: SizedBox(
                  width: 200,
                  child: LinearProgressIndicator(),
                ),
              ),
              // Register all the overlays that will be used by this game.
              overlayBuilderMap: {
                MainMenu.id: (_, ColoRunGame gameRef) => MainMenu(gameRef),
                //      PauseMenu.id: (_, ColoRunGame gameRef) => PauseMenu(gameRef),
                Hud.id: (_, ColoRunGame gameRef) => Hud(gameRef),
                //        GameOverMenu.id: (_, ColoRunGame gameRef) =>
                //            GameOverMenu(gameRef),
                //        SettingsMenu.id: (_, ColoRunGame gameRef) =>
                //           SettingsMenu(gameRef),
              },
              initialActiveOverlays: const [MainMenu.id],
            ),
          ],
        ));
  }
}

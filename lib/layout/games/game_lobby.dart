import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/layout/games/XO_game/XO_game.dart';
import 'package:todo/layout/games/brick_broken_game/difficulty_screen.dart';
import 'package:todo/layout/games/widget/game_card_widget.dart';

class GameLoobyScreen extends StatelessWidget {
  const GameLoobyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var hight = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.gameLobby),
        centerTitle: true,
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: hight * 0.1,
            ),
            GameCardWidget(
              hight: hight,
              width: width,
              image: "assets/images/XO.jpg",
              gameScreen: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const XOScreen(),
                  ),
                );
              },
            ),
            SizedBox(
              height: hight * 0.1,
            ),
            GameCardWidget(
              hight: hight,
              width: width,
              image: "assets/images/BRICK BREAKER.png",
              gameScreen: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DifficultyScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

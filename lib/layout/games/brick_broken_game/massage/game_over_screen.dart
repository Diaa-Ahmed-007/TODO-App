import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/style/app_color.dart';

class GameOverScreen extends StatelessWidget {
  const GameOverScreen(
      {super.key, required this.isGameOver, required this.playAgain});
  final bool isGameOver;
  final Function() playAgain;
  @override
  Widget build(BuildContext context) {
    TextStyle gameFont = GoogleFonts.pressStart2p(
        textStyle: const TextStyle(
      color: AppColor.primary,
      letterSpacing: 0,
      fontSize: 22,
    ));
    return isGameOver
        ? Stack(
            children: [
              Container(
                alignment: const Alignment(0, -0.3),
                margin: const EdgeInsets.only(top: 100),
                child: Text(
                  "G A M E  O V E R",
                  style: gameFont,
                ),
              ),
              Container(
                alignment: const Alignment(0, 0),
                child: GestureDetector(
                  onTap: playAgain,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: AppColor.primary,
                      child: const Text(
                        "PLAY AGAIN",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        : const SizedBox(
            height: 0,
            width: 0,
          );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/style/app_color.dart';

class CoverScreen extends StatelessWidget {
  const CoverScreen({
    super.key,
    required this.hasGameStarted,
    required this.isGameOver,
    required this.isWinner,
  });
  final bool hasGameStarted;
  final bool isGameOver;
  final bool isWinner;
  @override
  Widget build(BuildContext context) {
    TextStyle gameFont = GoogleFonts.pressStart2p(
        textStyle: const TextStyle(
      color: AppColor.primary,
      letterSpacing: 0,
      fontSize: 22,
    ));
    return hasGameStarted
        ? isWinner
            ? const SizedBox(
                height: 0,
                width: 0,
              )
            : Container(
                alignment: const Alignment(0, -0.3),
                child: Text(
                  isGameOver ? '' : "BRICK BREAKER",
                  style: gameFont.copyWith(
                      color: const Color.fromARGB(86, 245, 106, 31)),
                ),
              )
        : Stack(
            children: [
              Container(
                alignment: const Alignment(0, -0.3),
                child: Text(
                  "BRICK BREAKER",
                  style: gameFont,
                ),
              ),
              Container(
                alignment: const Alignment(0, -0.1),
                child: const Text(
                  "tap to play",
                  style: TextStyle(color: AppColor.primary2),
                ),
              ),
            ],
          );
  }
}

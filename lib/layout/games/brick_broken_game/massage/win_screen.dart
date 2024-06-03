import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class WinScreen extends StatelessWidget {
  const WinScreen({super.key, required this.isWin});
  final bool isWin;
  @override
  Widget build(BuildContext context) {
    TextStyle gameFont = GoogleFonts.pressStart2p(
        textStyle: TextStyle(
      color: Colors.orange[500],
      letterSpacing: 0,
      fontSize: 22,
    ));
    return isWin
        ? AvatarGlow(
            glowColor: Colors.orange[700]!,
            animate: true,
            repeat: true,
            curve: Curves.easeInOut,
            child: Stack(
              children: [
                Container(
                    alignment: const Alignment(0, -0.1),
                    child: LottieBuilder.asset("assets/images/win.json")),
                Container(
                  alignment: const Alignment(0, 0.4),
                  child: Text(
                    'W I N N E R',
                    style: gameFont,
                  ),
                )
              ],
            ),
          )
        : const SizedBox(
            height: 0,
            width: 0,
          );
  }
}

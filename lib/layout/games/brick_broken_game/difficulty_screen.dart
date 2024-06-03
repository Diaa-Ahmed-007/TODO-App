import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/layout/games/brick_broken_game/brick_breaker_game_home_screen.dart';

class DifficultyScreen extends StatelessWidget {
  const DifficultyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle gameFont = GoogleFonts.pressStart2p(
        textStyle: const TextStyle(
      color: Colors.white,
      letterSpacing: 0,
      fontSize: 22,
    ));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Difficult'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          DifficultButtons(
            gameFont: gameFont.copyWith(fontSize: 16),
            name: 'E A S Y',
            y: -0.4,
            color: Colors.orange.shade500,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const BrickBreakerGame(ballXIncrements: 0.01),
                ),
              );
            },
          ),
          DifficultButtons(
            gameFont: gameFont.copyWith(fontSize: 16),
            name: 'M E D I U M',
            y: 0,
            color: Colors.orange.shade700,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const BrickBreakerGame(ballXIncrements: 0.03),
                ),
              );
            },
          ),
          DifficultButtons(
            gameFont: gameFont.copyWith(fontSize: 16),
            name: 'H A R D',
            y: 0.4,
            color: Colors.orange.shade900,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const BrickBreakerGame(ballXIncrements: 0.04),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class DifficultButtons extends StatelessWidget {
  const DifficultButtons({
    super.key,
    required this.gameFont,
    required this.name,
    required this.y,
    required this.color,
    required this.onTap,
  });

  final TextStyle gameFont;
  final String name;
  final double y;
  final Color color;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment(0, y),
        child: Container(
          alignment: Alignment.center,
          height: 70,
          width: 250,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(16)),
          child: Text(
            name,
            style: gameFont,
          ),
        ),
      ),
    );
  }
}

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/layout/Home/provider/settings_provider.dart';
import 'package:todo/style/app_color.dart';

class MyBall extends StatelessWidget {
  const MyBall({
    super.key,
    required this.ballX,
    required this.ballY,
    required this.isGameOver,
    required this.hasGameStarted,
  });
  final double ballX;
  final double ballY;
  final bool isGameOver;
  final bool hasGameStarted;
  @override
  Widget build(BuildContext context) {
    SettingsProvider provider = Provider.of<SettingsProvider>(context);
    return hasGameStarted
        ? Container(
            alignment: Alignment(ballX, ballY),
            child: Container(
              height: 15,
              width: 15,
              decoration: BoxDecoration(
                  color: isGameOver
                      ? const Color.fromARGB(87, 245, 138, 31)
                      : AppColor.primary,
                  shape: BoxShape.circle),
            ),
          )
        : Container(
            alignment: Alignment(ballX, ballY),
            child: AvatarGlow(
              glowColor: AppColor.primary5,
              animate: true,
              repeat: true,
              glowShape: BoxShape.circle,
              child: Material(
                elevation: 10,
                color: Colors.transparent,
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: Container(
                    height: 15,
                    width: 15,
                    decoration: const BoxDecoration(
                        color: AppColor.primary, shape: BoxShape.circle),
                  ),
                ),
              ),
            ),
          );
  }
}

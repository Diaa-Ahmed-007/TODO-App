import 'package:flutter/material.dart';
import 'package:todo/style/app_color.dart';

class Bricks extends StatelessWidget {
  const Bricks({
    super.key,
    required this.brickHight,
    required this.brickWidth,
    required this.brickX,
    required this.brickY,
    required this.brickBroken,
  });

  final double brickX;
  final double brickY;
  final double brickHight;
  final double brickWidth;
  final bool brickBroken;

  @override
  Widget build(BuildContext context) {
    return brickBroken
        ? const SizedBox(
            height: 0,
            width: 0,
          )
        : Container(
            alignment:
                Alignment((2 * brickX + brickWidth) / (2 - brickWidth), brickY),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: MediaQuery.of(context).size.height * brickHight / 2,
                width: MediaQuery.of(context).size.height * brickWidth / 2,
                color: AppColor.primary4,
              ),
            ),
          );
  }
}

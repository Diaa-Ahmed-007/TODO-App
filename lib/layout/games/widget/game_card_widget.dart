import 'package:flutter/material.dart';

class GameCardWidget extends StatelessWidget {
  const GameCardWidget({
    super.key,
    required this.hight,
    required this.width,
    required this.image,
    required this.gameScreen,
  });

  final double hight;
  final double width;
  final String image;
  final Function() gameScreen;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameScreen,
      child: Material(
        elevation: 50,
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image: DecorationImage(image: AssetImage(image), fit: BoxFit.fill),
          ),
          height: hight * 0.3,
          width: width * 0.7,
        ),
      ),
    );
  }
}

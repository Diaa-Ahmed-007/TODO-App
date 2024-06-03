import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo/layout/games/brick_broken_game/componants/brick.dart';
import 'package:todo/layout/games/brick_broken_game/componants/myball.dart';
import 'package:todo/layout/games/brick_broken_game/componants/player.dart';
import 'package:todo/layout/games/brick_broken_game/massage/cover_screen.dart';
import 'package:todo/layout/games/brick_broken_game/massage/game_over_screen.dart';
import 'package:todo/layout/games/brick_broken_game/massage/win_screen.dart';

class BrickBreakerGame extends StatefulWidget {
  const BrickBreakerGame({
    super.key,
    required this.ballXIncrements,
  });
  final double ballXIncrements;
  @override
  State<BrickBreakerGame> createState() => _BrickBreakerGameState();
}

class _BrickBreakerGameState extends State<BrickBreakerGame> {
  double ballX = 0;
  double ballY = 0;
  late double ballXIncrements;
  double ballYIncrements = 0.01;
  var ballXDirection = Direction.left;
  var ballYDirection = Direction.down;
  bool hasGameStarted = false;
  double playerX = -0.2;
  double playerWidth = 0.4;

  bool isGameOver = false;
  static double brickX = -1 + wallGap1;
  static double firstBrickY = -0.7;
  static double secondBrickY = -0.6;
  static double thirdBrickY = -0.5;
  static double fourthBrickY = -0.4;
  static double brickWidth = 0.15;
  static double brickHeight = 0.04;
  static double brickGap = 0.32;
  static double numberOfBricksInRow = 4;
  static double wallGap1 = 0.5 *
      (2 -
          numberOfBricksInRow * brickWidth -
          (numberOfBricksInRow - 1) * brickGap);
  static List<List<dynamic>> myBricks = [
    [brickX + 0 * (brickWidth + brickGap), firstBrickY, false],
    [brickX + 1 * (brickWidth + brickGap), firstBrickY, false],
    [brickX + 2 * (brickWidth + brickGap), firstBrickY, false],
    [brickX + 3 * (brickWidth + brickGap), firstBrickY, false],
    //------------------------------------------------------------
    [brickX + 0 * (brickWidth + brickGap), secondBrickY, false],
    [brickX + 1 * (brickWidth + brickGap), secondBrickY, false],
    [brickX + 2 * (brickWidth + brickGap), secondBrickY, false],
    [brickX + 3 * (brickWidth + brickGap), secondBrickY, false],
    //------------------------------------------------------------
    [brickX + 0 * (brickWidth + brickGap), thirdBrickY, false],
    [brickX + 1 * (brickWidth + brickGap), thirdBrickY, false],
    [brickX + 2 * (brickWidth + brickGap), thirdBrickY, false],
    [brickX + 3 * (brickWidth + brickGap), thirdBrickY, false],
    //------------------------------------------------------------
    [brickX + 0 * (brickWidth + brickGap), fourthBrickY, false],
    [brickX + 1 * (brickWidth + brickGap), fourthBrickY, false],
    [brickX + 2 * (brickWidth + brickGap), fourthBrickY, false],
    [brickX + 3 * (brickWidth + brickGap), fourthBrickY, false],
  ];
  void startGame() {
    hasGameStarted = true;
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      updateDirection();
      moveBall();
      if (isPlayerWin()) {
        timer.cancel();
        setState(() {});
      }
      if (isPlayerDead()) {
        timer.cancel();
        isGameOver = true;
        setState(() {});
      }
      checkForBrokenBricks();
    });
  }

  bool isPlayerDead() {
    if (ballY >= 1) {
      return true;
    }
    return false;
  }

  void moveBall() {
    setState(() {
      if (ballXDirection == Direction.right) {
        ballX += ballXIncrements;
      } else if (ballXDirection == Direction.left) {
        ballX -= ballXIncrements;
      }
      if (ballYDirection == Direction.down) {
        ballY += ballYIncrements;
      } else if (ballYDirection == Direction.up) {
        ballY -= ballYIncrements;
      }
    });
  }

  void updateDirection() {
    setState(() {
      if (ballY >= 0.9 && ballX >= playerX && ballX <= playerX + playerWidth) {
        ballYDirection = Direction.up;
      } else if (ballY <= -1) {
        ballYDirection = Direction.down;
      }
      if (ballX >= 1) {
        ballXDirection = Direction.left;
      } else if (ballX <= -1) {
        ballXDirection = Direction.right;
      }
    });
  }

  bool isPlayerWin() {
    int count = 0;
    for (var i = 0; i < myBricks.length; i++) {
      if (myBricks[i][2] == true) {
        count++;
      }
    }
    if (count == myBricks.length) {
      return true;
    } else {
      return false;
    }
  }

  String findMin(double leftSideDist, double rightSideDist, double topSideDist,
      double bottomSideDist) {
    List<double> minList = [
      leftSideDist,
      rightSideDist,
      topSideDist,
      bottomSideDist
    ];
    double currentMin = leftSideDist;
    for (var i = 0; i < minList.length; i++) {
      if (minList[i] < currentMin) {
        currentMin = minList[i];
      }
    }
    if ((currentMin - topSideDist) < 0.01) {
      return 'top';
    } else if ((currentMin - bottomSideDist) < 0.01) {
      return 'down';
    } else if ((currentMin - rightSideDist) < 0.01) {
      return 'right';
    } else if ((currentMin - leftSideDist) < 0.01) {
      return 'left';
    }
    return '';
  }

  void checkForBrokenBricks() {
    for (var i = 0; i < myBricks.length; i++) {
      if (ballX >= myBricks[i][0] - 0.06 &&
          (ballX <= myBricks[i][0] + brickWidth + 0.12) &&
          ballY >= myBricks[i][1] &&
          ballY <= myBricks[i][1] + brickHeight &&
          !(myBricks[i][2])) {
        setState(() {
          myBricks[i][2] = true;
          double leftSideDist = (myBricks[i][0] - ballX).abs();
          double rightSideDist = (myBricks[i][0] + brickHeight - ballX).abs();
          double topSideDist = (myBricks[i][0] - ballY).abs();
          double bottomSideDist = (myBricks[i][0] + brickHeight - ballX).abs();

          String min =
              findMin(leftSideDist, rightSideDist, topSideDist, bottomSideDist);

          switch (min) {
            case 'left':
              ballXDirection = Direction.left;
              break;
            case 'right':
              ballXDirection = Direction.right;
              break;
            case 'top':
              ballYDirection = Direction.up;
              break;
            case 'down':
              ballYDirection = Direction.down;
              break;
          }
        });
      }
    }
  }

  void reserGame() {
    setState(() {
      playerX = -0.2;
      ballX = 0;
      ballY = 0;
      isGameOver = false;
      hasGameStarted = false;
      myBricks = [
        [brickX + 0 * (brickWidth + brickGap), firstBrickY, false],
        [brickX + 1 * (brickWidth + brickGap), firstBrickY, false],
        [brickX + 2 * (brickWidth + brickGap), firstBrickY, false],
        [brickX + 3 * (brickWidth + brickGap), firstBrickY, false],
        //------------------------------------------------------------
        [brickX + 0 * (brickWidth + brickGap), secondBrickY, false],
        [brickX + 1 * (brickWidth + brickGap), secondBrickY, false],
        [brickX + 2 * (brickWidth + brickGap), secondBrickY, false],
        [brickX + 3 * (brickWidth + brickGap), secondBrickY, false],
        //------------------------------------------------------------
        [brickX + 0 * (brickWidth + brickGap), thirdBrickY, false],
        [brickX + 1 * (brickWidth + brickGap), thirdBrickY, false],
        [brickX + 2 * (brickWidth + brickGap), thirdBrickY, false],
        [brickX + 3 * (brickWidth + brickGap), thirdBrickY, false],
        //------------------------------------------------------------
        [brickX + 0 * (brickWidth + brickGap), fourthBrickY, false],
        [brickX + 1 * (brickWidth + brickGap), fourthBrickY, false],
        [brickX + 2 * (brickWidth + brickGap), fourthBrickY, false],
        [brickX + 3 * (brickWidth + brickGap), fourthBrickY, false],
      ];
    });
  }

  void moveLeft() {
    setState(() {
      if (!(playerX - 0.2 < -1)) {
        playerX -= 0.2;
      }
    });
  }

  void moveRight() {
    setState(() {
      if (!(playerX + playerWidth >= 1)) {
        playerX += 0.2;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reserGame();
    ballXIncrements = widget.ballXIncrements;
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (value) {
        if (value.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          moveLeft();
        } else if (value.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          moveRight();
        }
      },
      child: GestureDetector(
        onTap: startGame,
        onHorizontalDragUpdate: (details) {
          setState(() {
            playerX += details.delta.dx / MediaQuery.of(context).size.width * 2;
            if (playerX < -1) {
              playerX = -1;
            } else if (playerX + playerWidth > 1) {
              playerX = 1 - playerWidth;
            }
          });
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          body: Center(
            child: Stack(
              children: [
                CoverScreen(
                  hasGameStarted: hasGameStarted,
                  isGameOver: isGameOver,
                  isWinner: isPlayerWin(),
                ),
                GameOverScreen(
                  isGameOver: isGameOver,
                  playAgain: reserGame,
                ),
                WinScreen(
                  isWin: isPlayerWin(),
                ),
                MyBall(
                  ballX: ballX,
                  ballY: ballY,
                  isGameOver: isGameOver,
                  hasGameStarted: hasGameStarted,
                ),
                MyPlayer(playerX: playerX, playerWidth: playerWidth),
                ...myBricks.map((brick) {
                  return Bricks(
                    brickWidth: brickWidth,
                    brickX: brick[0],
                    brickY: brick[1],
                    brickBroken: brick[2],
                    brickHight: brickHeight,
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum Direction { up, down, left, right }

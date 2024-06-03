import 'package:flutter/material.dart';

class XOScreen extends StatefulWidget {
  const XOScreen({
    super.key,
  });

  @override
  _XOScreenState createState() => _XOScreenState();
}

class _XOScreenState extends State<XOScreen> {
  static const double RADIUS_CORNER = 12;
  static const int NONE = 0;
  static const int VALUE_X = 1;
  static const int VALUE_O = 2;

  /// Theme game
  Color colorBorder = Colors.orange[600]!;
  Color colorBackground(BuildContext context) =>
      Theme.of(context).colorScheme.secondary;
  Color colorBackgroundChannelNone = Colors.orange[200]!;
  Color colorBackgroundChannelValueX = Colors.orange[400]!;
  Color colorBackgroundChannelValueO = Colors.orange[400]!;
  Color colorChannelIcon = Colors.orange[800]!;
  Color colorTextCurrentTurn = Colors.orange[900]!;

  // State of Game
  List<List<int>> channelStatus = [
    [NONE, NONE, NONE],
    [NONE, NONE, NONE],
    [NONE, NONE, NONE],
  ];

  //
  int currentTurn = VALUE_X;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        color: colorBackground(context),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("Turn of player",
                  style: TextStyle(
                      fontSize: 36,
                      color: colorTextCurrentTurn,
                      fontWeight: FontWeight.bold)),
              Icon(getIconFromStatus(currentTurn),
                  size: 60, color: colorChannelIcon),
              Container(
                margin: const EdgeInsets.only(top: 12),
                decoration: BoxDecoration(
                    color: colorBorder,
                    borderRadius: const BorderRadius.all(Radius.circular(8))),
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: buildRowChannel(0)),
                    Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: buildRowChannel(1)),
                    Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: buildRowChannel(2))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildRowChannel(int row) {
    List<Widget> listWidget = [];
    for (int col = 0; col < 3; col++) {
      double tlRadius = row == 0 && col == 0 ? RADIUS_CORNER : 0;
      double trRadius = row == 0 && col == 2 ? RADIUS_CORNER : 0;
      double blRadius = row == 2 && col == 0 ? RADIUS_CORNER : 0;
      double brRadius = row == 2 && col == 2 ? RADIUS_CORNER : 0;
      Widget widget = buildChannel(row, col, tlRadius, trRadius, blRadius,
          brRadius, channelStatus[row][col]);
      listWidget.add(widget);
    }
    return listWidget;
  }

  Widget buildChannel(int row, int col, double tlRadius, double trRadius,
          double blRadius, double brRadius, int status) =>
      GestureDetector(
        onTap: () => onChannelPressed(row, col),
        child: Container(
          margin: const EdgeInsets.all(2),
          width: 100,
          height: 100,
          decoration: BoxDecoration(
              color: getBackgroundChannelFromStatus(status),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(tlRadius),
                  topRight: Radius.circular(trRadius),
                  bottomLeft: Radius.circular(blRadius),
                  bottomRight: Radius.circular(brRadius))),
          child: Icon(getIconFromStatus(status),
              size: 60, color: colorChannelIcon),
        ),
      );

  IconData? getIconFromStatus(int status) {
    if (status == VALUE_X) {
      return Icons.close;
    } else if (status == VALUE_O) {
      return Icons.radio_button_unchecked;
    }
    return null;
  }

  Color getBackgroundChannelFromStatus(int status) {
    if (status == VALUE_X) {
      return colorBackgroundChannelValueX;
    } else if (status == VALUE_O) {
      return colorBackgroundChannelValueO;
    }
    return colorBackgroundChannelNone;
  }

  onChannelPressed(int row, int col) {
    if (channelStatus[row][col] == NONE) {
      setState(() {
        channelStatus[row][col] = currentTurn;

        if (isGameEndedByWin()) {
          showEndGameDialog(currentTurn);
        } else {
          if (isGameEndedByDraw()) {
            showEndGameByDrawDialog();
          } else {
            switchPlayer();
          }
        }
      });
    }
  }

  void switchPlayer() {
    setState(() {
      if (currentTurn == VALUE_X) {
        currentTurn = VALUE_O;
      } else if (currentTurn == VALUE_O) {
        currentTurn = VALUE_X;
      }
    });
  }

  bool isGameEndedByDraw() {
    for (int row = 0; row < 3; row++) {
      for (int col = 0; col < 3; col++) {
        if (channelStatus[row][col] == NONE) {
          return false;
        }
      }
    }
    return true;
  }

  bool isGameEndedByWin() {
    // check vertical.
    for (int col = 0; col < 3; col++) {
      if (channelStatus[0][col] != NONE &&
          channelStatus[0][col] == channelStatus[1][col] &&
          channelStatus[1][col] == channelStatus[2][col]) {
        return true;
      }
    }

    // check horizontal.
    for (int row = 0; row < 3; row++) {
      if (channelStatus[row][0] != NONE &&
          channelStatus[row][0] == channelStatus[row][1] &&
          channelStatus[row][1] == channelStatus[row][2]) {
        return true;
      }
    }

    // check cross left to right.
    if (channelStatus[0][0] != NONE &&
        channelStatus[0][0] == channelStatus[1][1] &&
        channelStatus[1][1] == channelStatus[2][2]) {
      return true;
    }

    // check cross right to left.
    if (channelStatus[0][2] != NONE &&
        channelStatus[0][2] == channelStatus[1][1] &&
        channelStatus[1][1] == channelStatus[2][0]) {
      return true;
    }

    return false;
  }

  void showEndGameDialog(int winner) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Text("The winner is",
              style: TextStyle(
                  fontSize: 32,
                  color: colorTextCurrentTurn,
                  fontWeight: FontWeight.bold)),
          Icon(getIconFromStatus(currentTurn),
              size: 60, color: colorChannelIcon),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
              backgroundColor: Colors.yellow[800],
            ),
            child: const Text("Play again",
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            onPressed: () {
              playAgain();
              Navigator.of(context).pop();
            },
          )
        ]));
      },
    );
  }

  void showEndGameByDrawDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Text("Draw",
              style: TextStyle(
                  fontSize: 32,
                  color: colorTextCurrentTurn,
                  fontWeight: FontWeight.bold)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow[800],
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
            ),
            child: const Text("Play again",
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            onPressed: () {
              playAgain();
              Navigator.of(context).pop();
            },
          )
        ]));
      },
    );
  }

  playAgain() {
    setState(() {
      currentTurn = VALUE_X;
      channelStatus = [
        [NONE, NONE, NONE],
        [NONE, NONE, NONE],
        [NONE, NONE, NONE],
      ];
    });
  }
}

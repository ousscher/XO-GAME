import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:xo_game/pages/Dialog.dart';

class TicTacToeGame extends StatefulWidget {
  @override
  _TicTacToeGameState createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  int scoreX = 0;
  int scoreY = 0;
  List<List<String>> board =
      List.generate(3, (_) => List.generate(3, (_) => ''));
  bool isPlayerX = true; // Le joueur X commence
  bool isBoardFull() {
    //checker si le match est null
    for (int row = 0; row < 3; row++) {
      for (int col = 0; col < 3; col++) {
        if (board[row][col] == '') {
          return false;
        }
      }
    }
    return true;
  }

  bool checkWinner(String player) {
    //checker le gagnat
    // check les lignes
    for (int row = 0; row < 3; row++) {
      if (board[row][0] == player &&
          board[row][1] == player &&
          board[row][2] == player) {
        return true;
      }
    }

    // check les colonnes
    for (int col = 0; col < 3; col++) {
      if (board[0][col] == player &&
          board[1][col] == player &&
          board[2][col] == player) {
        return true;
      }
    }

    // check les diagonales
    if ((board[0][0] == player &&
            board[1][1] == player &&
            board[2][2] == player) ||
        (board[0][2] == player &&
            board[1][1] == player &&
            board[2][0] == player)) {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: 0.08 * size.height,
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        "Tic-Tac-Toe",
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      )),
                  Image.asset("assets/images/line.png")
                ],
              ),
            ),
            SizedBox(
              height: 0.03 * size.height,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    scoreX.toString(),
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 212, 41),
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    " : ",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    scoreY.toString(),
                    style: TextStyle(
                      color: Color.fromARGB(228, 6, 164, 255),
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 0.02 * size.height,
            ),
            Text(
              isPlayerX ? "Tour du joueur X" : "Tour du joueur O",
              style: TextStyle(
                  fontSize: 30,
                  color: isPlayerX
                      ? Color.fromARGB(255, 255, 212, 41)
                      : Color.fromARGB(228, 6, 164, 255)),
            ),
            SizedBox(
              height: 0.03 * size.height,
            ),
            GridView.builder(
              shrinkWrap: true,
              itemCount: 9,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                int row = index ~/ 3;
                int col = index % 3;
                return GestureDetector(
                  onTap: () async {
                    if (board[row][col] == '') {
                      setState(() {
                        if (isPlayerX) {
                          board[row][col] = 'X';
                          if (checkWinner('X')) {
                            print("x le gagnant");
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialog(text: "X is the winner");
                              },
                            );
                            setState(() {
                              board = List.generate(
                                  3, (_) => List.generate(3, (_) => ''));
                              scoreX++;
                            });
                          } else if (isBoardFull()) {
                            print("match null");
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialog(
                                  text: "Match null",
                                );
                              },
                            );
                            setState(() {
                              board = List.generate(
                                  3, (_) => List.generate(3, (_) => ''));
                            });
                          }
                        } else {
                          board[row][col] = 'O';
                          if (checkWinner('O')) {
                            print("o le gagnant ");
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialog(text: "O is the winner");
                              },
                            );
                            setState(() {
                              board = List.generate(
                                  3, (_) => List.generate(3, (_) => ''));
                              scoreY++;
                            });
                          } else if (isBoardFull()) {
                            print("match null");
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialog(
                                  text: "Match null",
                                );
                              },
                            );
                            setState(() {
                              board = List.generate(
                                  3, (_) => List.generate(3, (_) => ''));
                            });
                          }
                        }
                        isPlayerX = !isPlayerX;
                      });
                    }
                  },
                  child: CustomGridTile(board[row][col], row, col),
                );
              },
            ),
            SizedBox(
              height: 0.05 * size.height,
            ),
            InkWell(
              onTap: () {
                resetBoard();
              },
              child: Container(
                height: 0.07 * size.height,
                width: 0.8 * size.width,
                decoration: BoxDecoration(
                  color: Color.fromARGB(228, 6, 164, 255),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: Text(
                    "Reset",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void resetBoard() {
    setState(() {
      board = List.generate(3, (_) => List.generate(3, (_) => ''));
      isPlayerX = true;
      scoreX = 0;
      scoreY = 0;
    });
  }
}

class CustomGridTile extends StatelessWidget {
  final String value;
  final int row;
  final int col;

  CustomGridTile(this.value, this.row, this.col);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //draw of the matrix xD
        border: (row == 0)
            ? (col == 0)
                ? Border(
                    top: BorderSide.none,
                    left: BorderSide.none,
                    bottom: BorderSide(
                        width: 2.0, color: Color.fromARGB(228, 6, 164, 255)),
                    right: BorderSide(
                        width: 2.0, color: Color.fromARGB(228, 6, 164, 255)))
                : (col == 1)
                    ? Border(
                        top: BorderSide.none,
                        left: BorderSide(
                            width: 2.0,
                            color: Color.fromARGB(228, 6, 164, 255)),
                        bottom: BorderSide(
                            width: 2.0,
                            color: Color.fromARGB(228, 6, 164, 255)),
                        right: BorderSide(
                            width: 2.0,
                            color: Color.fromARGB(228, 6, 164, 255)))
                    : Border(
                        top: BorderSide.none,
                        left: BorderSide(
                            width: 2.0,
                            color: Color.fromARGB(228, 6, 164, 255)),
                        bottom: BorderSide(
                            width: 2.0,
                            color: Color.fromARGB(228, 6, 164, 255)),
                        right: BorderSide.none)
            : (row == 1)
                ? (col == 0)
                    ? Border(
                        top: BorderSide(
                            width: 2.0,
                            color: Color.fromARGB(228, 6, 164, 255)),
                        left: BorderSide.none,
                        bottom: BorderSide(
                            width: 2.0,
                            color: Color.fromARGB(228, 6, 164, 255)),
                        right: BorderSide(
                            width: 2.0,
                            color: Color.fromARGB(228, 6, 164, 255)))
                    : (col == 1)
                        ? Border(
                            top: BorderSide(
                                width: 2.0,
                                color: Color.fromARGB(228, 6, 164, 255)),
                            left: BorderSide(
                                width: 2.0,
                                color: Color.fromARGB(228, 6, 164, 255)),
                            bottom: BorderSide(
                                width: 2.0,
                                color: Color.fromARGB(228, 6, 164, 255)),
                            right: BorderSide(
                                width: 2.0,
                                color: Color.fromARGB(228, 6, 164, 255)))
                        : Border(
                            top: BorderSide(
                                width: 2.0,
                                color: Color.fromARGB(228, 6, 164, 255)),
                            left: BorderSide(
                                width: 2.0,
                                color: Color.fromARGB(228, 6, 164, 255)),
                            bottom: BorderSide(
                                width: 2.0,
                                color: Color.fromARGB(228, 6, 164, 255)),
                            right: BorderSide.none)
                : (col == 0)
                    ? Border(
                        top: BorderSide(
                            width: 2.0,
                            color: Color.fromARGB(228, 6, 164, 255)),
                        left: BorderSide.none,
                        bottom: BorderSide.none,
                        right: BorderSide(
                            width: 2.0,
                            color: Color.fromARGB(228, 6, 164, 255)),
                      )
                    : (col == 1)
                        ? Border(
                            top: BorderSide(
                                width: 2.0,
                                color: Color.fromARGB(228, 6, 164, 255)),
                            left: BorderSide(
                                width: 2.0,
                                color: Color.fromARGB(228, 6, 164, 255)),
                            bottom: BorderSide.none,
                            right: BorderSide(
                                width: 2.0,
                                color: Color.fromARGB(228, 6, 164, 255)))
                        : Border(
                            top: BorderSide(
                                width: 2.0,
                                color: Color.fromARGB(228, 6, 164, 255)),
                            left: BorderSide(
                                width: 2.0,
                                color: Color.fromARGB(228, 6, 164, 255)),
                            bottom: BorderSide.none,
                            right: BorderSide.none),
      ),
      child: Center(
        child: Text(
          value,
          style: TextStyle(
              fontSize: 60,
              color: value == 'X'
                  ? Color.fromARGB(255, 255, 212, 41)
                  : Color.fromARGB(228, 6, 164, 255)),
        ),
      ),
    );
  }
}

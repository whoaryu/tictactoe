import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool oTurn = true;
  List<String> displayXO = ['', '', '', '', '', '', '', '', ''];
  List<int> matchedIndexes = [];
  int attempts = 0;

  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;
  String resultDeclaration = '';
  bool winnerFound = false;

  static var customFontWhite = GoogleFonts.coiny(
    textStyle: TextStyle(
      //color: Colors.white,
      color: Colors.amber,
      letterSpacing: 3,
      fontSize: 28,
    ),
  );

  static var customFontWhites = GoogleFonts.coiny(
    textStyle: TextStyle(
      //color: Colors.white,
      color: Colors.amber,
      letterSpacing: 3,
      fontSize: 25,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColor.primarycolor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Player scores
            SizedBox(height: 20),

            SizedBox(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Player O', style: customFontWhites),
                      Text(oScore.toString(), style: customFontWhites),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Player X', style: customFontWhites),
                      Text(xScore.toString(), style: customFontWhites),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),

            // Game grid
            Expanded(
              child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          width: 5,
                          color: MainColor.primarycolor,
                        ),
                        color: matchedIndexes.contains(index)
                            ? MainColor.accentcolor
                            : MainColor.secondarycolor,
                      ),
                      child: Center(
                        child: Text(
                          displayXO[index],
                          style: GoogleFonts.coiny(
                            textStyle: TextStyle(
                              fontSize: 60,
                              color: matchedIndexes.contains(index)
                                  ? MainColor.secondarycolor
                                  : MainColor.primarycolor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 20),

            // Result declaration and button
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(resultDeclaration, style: customFontWhite),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                  onPressed: () {
                    _clearBoard();
                    attempts++;
                  },
                  child: Text(
                    attempts == 0 ? 'Start' : 'Play Again!',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontFamily: 'Pacifico',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _tapped(int index) {
    if (!winnerFound && displayXO[index] == '') {
      setState(() {
        displayXO[index] = oTurn ? 'O' : 'X';
        filledBoxes++;
        oTurn = !oTurn;
        _checkWinner();
      });
    }
  }

  void _checkWinner() {
    // check 1st row
    if (displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[0] + ' Wins!';
        matchedIndexes.addAll([0, 1, 2]);
        //stoptimer();
        _updateScore(displayXO[0]);
      });
    }

    // check 2nd row
    if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] &&
        displayXO[3] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[3] + ' Wins!';
        matchedIndexes.addAll([3, 4, 5]);
        //stoptimer();
        _updateScore(displayXO[3]);
      });
    }

    // check 3rd row
    if (displayXO[6] == displayXO[7] &&
        displayXO[6] == displayXO[8] &&
        displayXO[6] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[6] + ' Wins!';
        matchedIndexes.addAll([6, 7, 8]);
        //stoptimer();
        _updateScore(displayXO[6]);
      });
    }

    // check 1st column
    if (displayXO[0] == displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[0] + ' Wins!';
        matchedIndexes.addAll([0, 3, 6]);
        //stoptimer();
        _updateScore(displayXO[0]);
      });
    }

    // check 2nd column
    if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[1] + ' Wins!';
        matchedIndexes.addAll([1, 4, 7]);

        ////stoptimer();
        _updateScore(displayXO[1]);
      });
    }

    // check 3rd column
    if (displayXO[2] == displayXO[5] &&
        displayXO[2] == displayXO[8] &&
        displayXO[2] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[2] + ' Wins!';
        matchedIndexes.addAll([2, 5, 8]);
        ////stoptimer();
        _updateScore(displayXO[2]);
      });
    }

    // check diagonal
    if (displayXO[0] == displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[0] + ' Wins!';
        matchedIndexes.addAll([0, 4, 8]);
        ////stoptimer();
        _updateScore(displayXO[0]);
      });
    }

    // check diagonal
    if (displayXO[6] == displayXO[4] &&
        displayXO[6] == displayXO[2] &&
        displayXO[6] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[6] + ' Wins!';
        matchedIndexes.addAll([6, 4, 2]);
        //////stoptimer();
        _updateScore(displayXO[6]);
      });
    }
    if (winnerFound == false && filledBoxes == 9) {
      setState(() {
        resultDeclaration = 'Nobody Wins!';
        // ////stoptimer();
      });
    }
  }

  void _updateScore(String winner) {
    if (winner == 'O') {
      oScore++;
    } else if (winner == 'X') {
      xScore++;
    }
    winnerFound = true;
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayXO[i] = '';
      }
      resultDeclaration = '';
      matchedIndexes = [];
    });
    filledBoxes = 0;
    winnerFound = false;
  }
}

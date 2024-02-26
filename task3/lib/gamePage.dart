import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GamePage extends StatefulWidget {
  
  // String player1;
  // String player2;
  // GamePage({required this.player1, required this.player2});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late String _currentPlayer;
  // late String _winner;
  late bool _gameover;
  bool isTurn = true;
  int count = 0;
   List<String> changeXO = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];


  @override 
  void initState(){
    super.initState();
    _currentPlayer="X";
    // _winner="";
    _gameover=false;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 48, 72, 138),
        appBar: AppBar(
          
          title: Text("Игра"),
        ),
        body: Column(
          children: [
           const  Padding(
              padding: EdgeInsets.all(25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // children: [
                  // Column(
                    // children: [
            //           const Padding(
            //             padding: EdgeInsets.all(8.0),
            //             child: Text(
            //               'Игрок Х',
            //               style: txtStyle,
            //             ),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: Text(
            //               xScore.toString(),
            //               style: txtStyle,
            //             ),
            //           )
            //         ],
            //       ),
            //       Column(
            //         children: [
            //           const Padding(
            //             padding: EdgeInsets.all(8.0),
            //             child: Text(
            //               'Игрок О',
            //               style: txtStyle,
            //             ),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: Text(
            //               oScore.toString(),
            //               style: txtStyle,
            //             ),
            //           )
            //         ],
            //       )
              //  ],
             ),
             ),
            Container(
                width: 400,
                height: 400,
                child: GridView.builder(
                    itemCount: changeXO.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemBuilder: (BuildContext ctx, int index) {
                      return GestureDetector(
                        onTap: () => _makeMove(index),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueGrey)),
                          child: Center(
                              child: Text(
                            changeXO[index],
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50.0, color: Colors.amber),
                          )),
                        ),
                      );
                    })),
          ],
        ));
  } void _makeMove(int i) {
    if (isTurn && changeXO[i] == '') {
      setState(() {
        changeXO[i] = 'o';
        isTurn = !isTurn;
      });
    } else if (!isTurn && changeXO[i] == '') {
      setState(() {
        changeXO[i] = 'x';
        isTurn = !isTurn;
      });
      
    }
    count++;
    _checkWinner();
    
 }
 void _checkWinner() {
    if (changeXO[0] == changeXO[1] &&
        changeXO[0] == changeXO[2] &&
        changeXO[0] != '') {
      _showDialog(winner: changeXO[0]);
    }
    if (changeXO[3] == changeXO[4] &&
        changeXO[3] == changeXO[5] &&
        changeXO[3] != '') {
      _showDialog(winner: changeXO[3]);
    }
    if (changeXO[6] == changeXO[7] &&
        changeXO[6] == changeXO[8] &&
        changeXO[6] != '') {
      _showDialog(winner: changeXO[6]);
    }
    if (changeXO[0] == changeXO[3] &&
        changeXO[0] == changeXO[6] &&
        changeXO[0] != '') {
      _showDialog(winner: changeXO[0]);
    }
    if (changeXO[1] == changeXO[4] &&
        changeXO[1] == changeXO[7] &&
        changeXO[1] != '') {
      _showDialog(winner: changeXO[1]);
    }
    if (changeXO[2] == changeXO[5] &&
        changeXO[2] == changeXO[8] &&
        changeXO[2] != '') {
      _showDialog(winner: changeXO[2]);
    }
    if (changeXO[0] == changeXO[4] &&
        changeXO[0] == changeXO[8] &&
        changeXO[0] != '') {
      _showDialog(winner: changeXO[0]);
    }
    if (changeXO[2] == changeXO[4] &&
        changeXO[2] == changeXO[6] &&
        changeXO[2] != '') {
      _showDialog(winner: changeXO[2]);
    }

    if (count == 9) {
      _showDialog(winnerExist: false);
      _clearBoard();
    }
  }
    void _showDialog({String winner = '', bool winnerExist = true}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(winnerExist ? 'Победитель: $winner' : 'Нет победителя'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Играть ещё раз!'))
            ],
          );
        });
    count = 0;
    _clearBoard();
  }
  void _clearBoard() {
    for (int i = 0; i < 9; i++) {
      changeXO[i] = '';
    }
  }
}
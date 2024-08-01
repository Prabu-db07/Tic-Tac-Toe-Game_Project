import 'package:flutter/material.dart';

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  List<List<String>>? _board;
  bool? _isXNext;

  void _run() {
    setState(() {
      _board = List.generate(3, (i) => List.generate(3, (j) => ''));
      _isXNext = true;
    });
  }


  void _show(String title, String message)
  {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              )
            ],
          );
        });
  }

  // ignore: non_constant_identifier_names
  bool _Winner(int row, int col) {
    if (_board![row][0] == _board![row][1] &&
        _board![row][1] == _board![row][2] &&
        _board![row][0].isNotEmpty) {
      return true;
    }
    if (_board![0][col] == _board![1][col] &&
        _board![1][col] == _board![2][col] &&
        _board![0][col].isNotEmpty) {
      return true;
    }

    if ((row == col || row + col == 2) &&
        ((_board![0][0] == _board![1][1] && _board![1][1] == _board![2][2]) ||
            (_board![0][2] == _board![1][1] &&
                _board![1][1] == _board![2][0])) &&
        _board![1][1].isNotEmpty) {
      return true;
    }

    return false;
  }

  bool _boardFulll() {
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 3; j++) {
        if (_board![i][j].isEmpty) {
          return false;
        }
      }
    }
    return true;
  }

  void _handleTap(int row, col) {
    if (_board![row][col].isEmpty) {
      setState(() {
        if (_isXNext!) {
          _board?[row][col] = 'X';
        } else {
          _board?[row][col] = 'O';
        }
        _isXNext = !_isXNext!;
      });
      if (_Winner(row, col)) {
        _show('${_board![row][col]} Wins', 'Congratulations');
        _run();
      } else if (_boardFulll()) {
        _show('It\'s Draw!', 'Try Again');
        _run();
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _run();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.purple, Colors.red],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
        ),
        title: const Text('Tic - Tac - Toe'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.red],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _isXNext! ? 'Player X\'s Turn' : 'Player O\'s Turn',
                style: const TextStyle(
                  fontSize: 25.0,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 16.0,
              ),
              AspectRatio(
                aspectRatio: 1.0,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    int row = index ~/ 3;
                    int col = index % 3;
                    return GestureDetector(
                      onTap: () => _handleTap(row, col),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: Center(
                          child: Text(
                            _board![row][col],
                            style: const TextStyle(
                              fontSize: 40.0,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

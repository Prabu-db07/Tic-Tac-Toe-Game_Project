import 'package:flutter/material.dart';

import 'Game_file/x_o_game.dart';

void main() {
  runApp(const game());
}
class game extends StatelessWidget {
  const game({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic Tac Toe',
      
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,


      ),
home: const TicTacToe(),
    );
  }
}


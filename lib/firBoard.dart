import 'dart:math';
import 'package:flutter/material.dart';

class FirBoardState {
  List<int> board = List.filled(64, 0);
}

class FirBoardPiece extends StatefulWidget {
  var x, y;
  var state = 0;
  FirBoardController controller;

  FirBoardPiece(
    this.x,
    this.y,
    this.state,
    this.controller,
  );

  @override
  _FirBoardPiece createState() => _FirBoardPiece();
}

class _FirBoardPiece extends State<FirBoardPiece> {
  @override
  Widget build(BuildContext context) {
    Icon? icon;
    if (widget.state == 0) {
      icon = null;
    } else if (widget.state == 1) {
      icon = const Icon(Icons.circle, color: Color(0xFFFFFFFF));
    } else {
      icon = const Icon(Icons.circle, color: Color(0xFF000000));
    }

    return GestureDetector(
        onTap: () {
          print("touch ${widget.x} ${widget.y}");
          widget.controller.putStone(widget.x, widget.y, 1);
        },
        child: SizedBox(
            height: 10,
            width: 10,
            child: Container(
                color: Color(0xFF0000FF),
                child: Container(
                  margin: EdgeInsets.all(1),
                  color: Color(0xFF00FF00),
                  child: icon,
                ))));
  }
}

class FirBoardController extends ValueNotifier<FirBoardState> {
  late FirBoardState game;

  factory FirBoardController() => FirBoardController._(FirBoardState());
  FirBoardController._(FirBoardState game)
      : game = game,
        super(game);

  void putStone(int x, int y, int color) {
    print("put stone");
    game.board[x * 8 + y] = color;
    value = game;
    notifyListeners();
  }
}

class FirBoard extends StatefulWidget {
  final FirBoardController controller;

  final double? size;

  const FirBoard({
    Key? key,
    this.size,
    required this.controller,
  }) : super(key: key);

  @override
  _FirBoard createState() => _FirBoard();
}

class _FirBoard extends State<FirBoard> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<FirBoardState>(
        valueListenable: widget.controller,
        builder: (context, game, _) {
          return SizedBox(
            //width: widget.size,
            //height: widget.size,
            width: 400,
            height: 400,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8),
              itemBuilder: (context, index) {
                var row = index ~/ 8;
                var column = index % 8;

                var piece = FirBoardPiece(
                    row,
                    column,
                    widget.controller.game.board[row * 8 + column],
                    widget.controller);

                return piece;
              },
              itemCount: 64,
              //shrinkWrap: true,
              //physics: NeverScrollableScrollPhysics(),
            ),
          );
        });
  }
}

import 'package:fir_client/constants.dart';
import 'package:fir_client/engine.dart';
import 'package:flutter/material.dart';

class FirBoardState {
  bool order = false;
  String oppname = "anon";
  String myname = "anon";
  List<int> board = List.filled(64, -1);

  bool gameEndPopup = false;

  void play(int x, int y, int color) {
    board[x * 8 + y] = color;
  }
}

class FirBoardController extends ValueNotifier<FirBoardState> {
  late FirBoardState game;

  factory FirBoardController() => FirBoardController._(FirBoardState());
  FirBoardController._(FirBoardState game)
      : game = game,
        super(game);

  bool putStone(int x, int y, int color) {
    if (game.board[x * 8 + y] != -1) return false;
    game.board[x * 8 + y] = color;
    value = game;
    notifyListeners();
    return true;
  }

  void setOrder(bool order) {
    game.order = order;
    notifyListeners();
  }

  void PopupGameEnd() {
    this.game.gameEndPopup = true;
    notifyListeners();
  }
}

class FirBoardPiece extends StatefulWidget {
  int x, y;
  int state = 0;
  FirBoardController controller;

  FirBoardPiece(this.x, this.y, this.state, this.controller, {super.key});

  @override
  _FirBoardPiece createState() => _FirBoardPiece();
}

class _FirBoardPiece extends State<FirBoardPiece> {
  @override
  Widget build(BuildContext context) {
    Icon? icon;
    if (widget.state == -1) {
      icon = null;
    } else if (widget.state == 0) {
      icon = const Icon(Icons.circle, color: Color(0xFFFFFFFF));
    } else {
      icon = const Icon(Icons.circle, color: Color(0xFF000000));
    }

    late Color color;
    if ((widget.x + widget.y) % 2 == 0) {
      color = MyColor.surfaceContainer;
    } else {
      color = MyColor.primaryContainer;
    }

    return GestureDetector(
        onTap: () {
          //print("touch ${widget.x} ${widget.y}");
          Engine().playStone(widget.x, widget.y);
        },
        child: SizedBox(
            height: 10,
            width: 10,
            child: Container(
                color: const Color(0xFF0000FF),
                child: Container(
                  margin: const EdgeInsets.all(1),
                  color: color,
                  child: icon,
                ))));
  }
}

class FirBoard extends StatefulWidget {
  final FirBoardController controller;

  final double? size;

  const FirBoard({
    super.key,
    this.size,
    required this.controller,
  });

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
            width: widget.size,
            height: widget.size,
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

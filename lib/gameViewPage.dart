import 'package:fir_client/constants.dart';
import 'package:fir_client/engine.dart';
import 'package:flutter/material.dart';

class FirBoardBogoPiece extends StatefulWidget {
  int x, y;
  int state = 0;

  FirBoardBogoPiece(this.x, this.y, this.state, {super.key});

  @override
  _FirBoardBogoPiece createState() => _FirBoardBogoPiece();
}

class _FirBoardBogoPiece extends State<FirBoardBogoPiece> {
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

    return SizedBox(
        height: 10,
        width: 10,
        child: Container(
            color: const Color(0xFF0000FF),
            child: Container(
              margin: const EdgeInsets.all(1),
              color: color,
              child: icon,
            )));
  }
}

class GameViewPage extends StatelessWidget {
  const GameViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blue, title: const Text("Previouse Game")),
        body: Center(
          child: SizedBox(
            width: 400,
            height: 400,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8),
              itemBuilder: (context, index) {
                var row = index ~/ 8;
                var column = index % 8;
                var li = Engine()
                    .notifier
                    .info
                    .gameinfos[Engine().selectedGame]
                    .notations;
                int stone = -1;
                for (var l in li) {
                  if (l.x == row && l.y == column) {
                    stone = l.color;
                  }
                }
                var piece = FirBoardBogoPiece(row, column, stone);
                return piece;
              },
              itemCount: 64,
            ),
          ),
        ));
  }
}

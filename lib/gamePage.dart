import 'package:fir_client/constants.dart';
import 'package:fir_client/engine.dart';
import 'package:fir_client/firBoard.dart';
import 'package:fir_client/messageBox.dart';
import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  _GamePage createState() => _GamePage();
}

class _GamePage extends State<GamePage> with SingleTickerProviderStateMixin {
  String inputText = '';
  late FirBoardController controller;
  late TabController tabController;
  int idx = 0;

  @override
  initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() => setState(() {
          idx = tabController.index;
          //print('$idx');
        }));
    controller = Engine().controller!;
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Game'),
          backgroundColor: MyColor.appBar,
        ),
        body: ValueListenableBuilder<FirBoardState>(
            valueListenable: Engine().controller!,
            builder: (context, game, _) {
              if (game.gameEndPopup == true) {
                game.gameEndPopup = false;
                flutterDialog(context, 'Game over!', '');
              }

              late Color my, opp;
              if (game.order == true) {
                my = MyColor.primaryContainer;
                opp = MyColor.buttonColor;
              } else {
                my = MyColor.buttonColor;
                opp = MyColor.primaryContainer;
              }

              return Column(children: [
                Container(
                    width: double.infinity,
                    height: 100,
                    alignment: Alignment.centerLeft,
                    color: opp,
                    padding: const EdgeInsets.only(left: 26),
                    child: Text(game.oppname,
                        style: TextStyle(color: MyColor.text, fontSize: 40))),
                Container(
                    width: double.infinity,
                    height: 500,
                    child: Center(
                      child: FirBoard(
                        controller: controller,
                        size: 400,
                      ),
                    )),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        width: double.infinity,
                        height: 100,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 26),
                        color: my,
                        child: Text(game.myname,
                            style:
                                TextStyle(color: MyColor.text, fontSize: 40)))
                  ],
                ))
              ]);
            }),
        bottomNavigationBar: SizedBox(
            height: 80,
            child: Container(
                width: double.infinity,
                height: double.infinity,
                color: MyColor.surfaceContainer,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(children: [
                      IconButton(
                          onPressed: () {
                            if (Engine().isStart == false) return;
                            flutterOkBox(context, 'offer draw?', '', () {
                              Engine().sendOfferDrawCommand();
                            }, () {});
                          },
                          icon: Icon(Icons.remove, color: MyColor.black)),
                      Text("offer draw", style: TextStyle(color: MyColor.text)),
                    ]),
                    Column(children: [
                      IconButton(
                          onPressed: () {
                            if (Engine().isStart == false) return;
                            flutterOkBox(context, 'resign?', '', () {
                              Engine().sendResignCommand();
                            }, () {});
                          },
                          icon: Icon(Icons.cancel, color: MyColor.black)),
                      Text(
                        "resign",
                        style: TextStyle(color: MyColor.text),
                      ),
                    ]),
                  ],
                ))));
  }
}

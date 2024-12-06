import 'package:fir_client/constants.dart';
import 'package:fir_client/engine.dart';
import 'package:fir_client/firBoard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GamePage extends StatefulWidget {
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
          print('$idx');
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
                    child: Text(game.oppname,
                        style: TextStyle(color: MyColor.text))),
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
                        color: my,
                        child: Text(game.myname,
                            style: TextStyle(color: MyColor.text)))
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
                            FlutterOkBox('offer draw?', '', () {}, () {});
                          },
                          icon: Icon(Icons.remove, color: MyColor.black)),
                      Text("offer draw", style: TextStyle(color: MyColor.text)),
                    ]),
                    Column(children: [
                      IconButton(
                          onPressed: () {
                            FlutterOkBox('resign?', '', () {}, () {});
                          },
                          icon: Icon(Icons.cancel, color: MyColor.black)),
                      Text(
                        "resign",
                        style: TextStyle(color: MyColor.text),
                      ),
                    ]),
                  ],
                ) /* TabBar(
                  indicatorColor: MyColor.surfaceContainer,
                  labelColor: Colors.black,
                  controller: tabController,
                  onTap: (int i) {
                    if (i == 0) {
                      FlutterOkBox('offer draw?', '', () {}, () {});
                    } else {
                      FlutterOkBox('resign?', '', () {}, () {});
                    }
                  },
                  tabs: const [
                    Tab(text: 'offer draw', icon: Icon(Icons.remove)),
                    Tab(text: 'resign', icon: Icon(Icons.cancel)),
                  ]))),*/
                )));
  }

  void FlutterOkBox(String title, String msg, Function yes, Function no) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: Text(title),
            content: Text(msg),
            actions: [
              ElevatedButton(
                child: Text("Yes"),
                onPressed: () {
                  yes();
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                child: Text("No"),
                onPressed: () {
                  no();
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  void FlutterDialog(String title, String msg) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            //Dialog Main Title
            title: Column(
              children: [
                Text(title),
              ],
            ),
            //
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(msg),
              ],
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text("확인"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}

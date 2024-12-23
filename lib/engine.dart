import 'dart:convert';
import 'package:fir_client/clientTest.dart';
import 'package:fir_client/firBoard.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'info.dart';

class Infos {
  bool loginState = false;
  String username = "Guest";
  UserKeyInfo key = UserKeyInfo(key: "");
  UserInfo userinfo = UserInfo(id: "", pwd: "", rating: 0, key: "");
  List<GameInfo> gameinfos = List<GameInfo>.empty();
}

class InfoController extends ValueNotifier<Infos> {
  Infos info;

  factory InfoController() => InfoController._(Infos());
  InfoController._(Infos info)
      : info = info,
        super(info);

  update() {
    notifyListeners();
  }
}

class Engine {
  Engine._privateContructor();

  static final Engine _instance = Engine._privateContructor();

  factory Engine() {
    return _instance;
  }

  //final String host = "http://127.0.0.1:3000/";
  //static const String ip = "10.0.2.2:3000"; // android emulation
  static const String ip = "127.0.0.1:3000"; // windows
  static const String host = "http://$ip/";

  InfoController notifier = InfoController();
  int selectedGame = -1;

  Future registerUser(
      String id, String pwd, Function sucess, Function fail) async {
    if (id == '' || pwd == '') {
      fail();
      return;
    }

    final RegisterInfo info = RegisterInfo(id: id, pwd: pwd);
    var response = await dio.post(
      '${host}register',
      data: info.toJson(),
    );
    key = UserKeyInfo.fromJson(json.decode(response.toString()));
    notifier.info.loginState = true;
    print('register ${key.key}');
    if (key.key == "") {
      fail();
    } else {
      sucess();
      await getUserInfo(() {});
      await getGameinfo(() {});
    }
  }

  Future refresh() async {
    await getUserInfo(() {});
    await getGameinfo(() {});
  }

  Future loginUser(
      String id, String pwd, Function success, Function fail) async {
    if (id == '') {
      fail();
      return;
    }

    final LoginInfo info = LoginInfo(id: id, pwd: pwd);
    var response = await dio.post(
      '${host}login',
      data: info.toJson(),
    );
    key = UserKeyInfo.fromJson(json.decode(response.toString()));

    if (key.key == "") {
      fail();
    } else {
      notifier.info.loginState = true;
      await getUserInfo(() {});
      await getGameinfo(() {});
      success();
    }

    print("login ${key.key}");
    notifier.update();
  }

  Future getUserInfo(Function? callback) async {
    if (notifier.info.loginState == false) return;
    var response = await dio.get('${host}getuserinfo', data: key.toJson());
    notifier.info.userinfo =
        UserInfo.fromJson(json.decode(response.toString()));
    print('${notifier.info.userinfo.id}');
    callback!();
    notifier.update();
    print('update');
  }

  Future getGameinfo(Function? callback) async {
    if (notifier.info.loginState == false) return;
    var response = await dio.get('${host}getgameinfo', data: key.toJson());
    Iterable iter = json.decode(response.toString());
    notifier.info.gameinfos =
        List<GameInfo>.from(iter.map((json) => GameInfo.fromJson(json)));
    callback!();
    notifier.update();
  }

  // in game commands
  int side = -2; // 0 black, 1 white
  int opp = -2;
  bool isStart = false;
  WebSocketChannel? channel;
  FirBoardController? controller;

  Future enterGame(Function callback) async {
    print("game entier");
    channel =
        WebSocketChannel.connect(Uri.parse('ws://$ip/connect?key=${key.key}'));
    controller = FirBoardController();
    await gameAsync(channel!, callback);
  }

  void initGame(int side) {
    this.side = side;
    if (side == 0) {
      opp = 1;
    } else {
      opp = 0;
    }
    if (side == 0) {
      controller!.setOrder(true);
    } else {
      controller!.setOrder(false);
    }
  }

  void endGame() {
    channel = null;
    controller = null;
    refresh();
  }

  void playStone(int x, int y) {
    if (controller!.game.order == false) return;
    print('play stone $x $y');
    if (controller!.putStone(x, y, side)) {
      sendPlayCommand(x, y);
      controller!.game.order = false;
    }
  }

  Future sendPlayCommand(int x, int y) async {
    var command = GameCommandInfo(
        side: side,
        command: "Play",
        notation: NotationInfo(color: side, x: x, y: y),
        message: "");
    channel?.sink.add(json.encode(command.toJson()));
  }

  Future sendOfferDrawCommand() async {}

  Future sendResignCommand() async {
    var command = GameCommandInfo(
        side: side,
        command: "Resign",
        notation: NotationInfo(color: 0, x: 0, y: 0),
        message: "");
    channel!.sink.add(json.encode(command.toJson()));
    isStart = false;
  }

  Future gameAsync(WebSocketChannel channel, Function callback) async {
    int side = 0;

    // callback
    channel.stream.listen((message) {
      print('received: $message');
      GameResponseInfo response =
          GameResponseInfo.fromJson(json.decode(message.toString()));

      if (response.command == "Start") {
        isStart = true;
        side = response.notation.color;
        controller!.game.oppname = response.message;
        controller!.game.myname = notifier.info.userinfo.id;
        initGame(side);
        isStart = true;
        print('Game Start with color $side');
        callback();
      }

      if (response.command == "OpponentPlay") {
        var notation = response.notation;
        print('Opponent Play ${notation.x} ${notation.y}');
        controller!.putStone(notation.x, notation.y, opp);
        controller!.game.order = true;
      }

      if (response.command == "OpponentResign") {
        print('Opponent Resign the game');
      }

      if (response.command == "Message") {
        print('Opponent sends the message ${response.message}');
      }

      if (response.command == "GameEnd") {
        print('Game End');
        if (isStart == true) {
          isStart = false;
          controller!.PopupGameEnd();
        }
        endGame();
      }
    }, onDone: () {
      print('WebSocket connection closed');
    }, onError: (error) {
      print('Error: $error');
    });

    while (true) {
      String? str = await readLine();
      List<String> words = str.split(' ');

      if (words.isEmpty) {
        continue;
      }

      if (words[0] == 'exit') {
        break;
      }

      if (isStart == false) continue;

      if (words[0] == 'play') {
        int x = int.parse(words[1]);
        int y = int.parse(words[2]);
        var command = GameCommandInfo(
            side: side,
            command: "Play",
            notation: NotationInfo(color: side, x: x, y: y),
            message: "");
        channel.sink.add(json.encode(command.toJson()));
      }

      if (words[0] == 'message') {
        var command = GameCommandInfo(
            side: side,
            command: "Message",
            notation: NotationInfo(color: 0, x: 0, y: 0),
            message: words[1]);
        //channel.sink.add(str);
        channel.sink.add(json.encode(command.toJson()));
      }

      if (words[0] == 'resign') {
        var command = GameCommandInfo(
            side: side,
            command: "Resign",
            notation: NotationInfo(color: 0, x: 0, y: 0),
            message: "");
        channel.sink.add(json.encode(command.toJson()));
      }
    }

    // close socket
    //channel.sink.close();
  }
}

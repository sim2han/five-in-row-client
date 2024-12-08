import 'dart:io';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:dio/dio.dart';
import 'package:async/async.dart';
import 'info.dart';

final dio = Dio();

// async stdio
// https://gist.github.com/frencojobs/dca6a24e07ada2b9df1683ddc8fa45c6
var _stdinLines = StreamQueue(LineSplitter().bind(Utf8Decoder().bind(stdin)));

Future<String> readLine([String? query]) async {
  if (query != null) stdout.write(query);
  return _stdinLines.next;
}

int count = 0;
const String localHost = "http://127.0.0.1:3000/";
UserKeyInfo key = UserKeyInfo(key: "");

// cli client test
Future cli() async {
  WebSocketChannel channel;

  while (true) {
    stdout.write('>> ');
    String? str = await readLine();
    List<String> words = str.split(' ');

    if (words.isEmpty) {
      continue;
    }

    if (words[0] == "exit") {
      break;
    }

    if (words[0] == "connect") {
      channel = WebSocketChannel.connect(
          Uri.parse('ws://127.0.0.1:3000/connect?key=${key.key}'));
      await webSocketCli(channel);
    }

    if (words[0] == "state") {
      final response = await simpleHttpRequest(localHost + str);
      print(response);
    }

    if (words[0] == "register") {
      final String id = words[1];
      final String pwd = words[2];
      final RegisterInfo info = RegisterInfo(id: id, pwd: pwd);
      var response = await dio.post(
        '${localHost}register',
        data: info.toJson(),
      );
      key = UserKeyInfo.fromJson(json.decode(response.toString()));
      print('response $response');
    }

    if (words[0] == 'getuserinfo') {
      var response = await dio.get(
        '${localHost}getuserinfo',
        data: key.toJson(),
      );
      print('response $response');
      UserInfo info = UserInfo.fromJson(json.decode(response.toString()));
    }

    if (words[0] == 'getgameinfo') {
      var response = await dio.get(
        '${localHost}getgameinfo',
        data: key.toJson(),
      );
      print('response $response');
      Iterable iter = json.decode(response.toString());
      List<GameInfo> infos =
          List<GameInfo>.from(iter.map((json) => GameInfo.fromJson(json)));
    }

    if (words[0] == "login") {
      final String id = words[1];
      final String pwd = words[2];
      final LoginInfo info = LoginInfo(id: id, pwd: pwd);
      var response = await dio.post(
        '${localHost}login',
        data: info.toJson(),
      );
      key = UserKeyInfo.fromJson(json.decode(response.toString()));
      print('response $response');
    }

    if (str == "getuser") {
      try {
        final response = await simpleHttpRequest('${localHost}getuser');
        print(response);
        Iterable l = json.decode(response);
        List<UserInfo> infos =
            List<UserInfo>.from(l.map((json) => UserInfo.fromJson(json)));
        for (int i = 0; i < infos.length; i++) {
          print('$i : ${infos[i].toJson().toString()}');
        }
      } catch (e) {
        print('error: $e');
      }
    }
  }
}

Future<String> simpleHttpRequest(String url) async {
  Response response = await dio.get(url);
  return response.data.toString();
}

Future webSocketCli(WebSocketChannel channel) async {
  bool isStart = false;
  int side = 0;

  // callback
  channel.stream.listen((message) {
    print('received: $message');
    GameResponseInfo response =
        GameResponseInfo.fromJson(json.decode(message.toString()));

    if (response.command == "Start") {
      isStart = true;
      side = response.notation.color;
      print('Game Start with color $side');
    }

    if (response.command == "OpponentPlay") {
      var notation = response.notation;
      print('Opponent Play ${notation.x} ${notation.y}');
    }

    if (response.command == "OpponentResign") {
      print('Opponent Resign the game');
    }

    if (response.command == "Message") {
      print('Opponent sends the message ${response.message}');
    }

    if (response.command == "GameEnd") {
      print('Game End');
      isStart = false;
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

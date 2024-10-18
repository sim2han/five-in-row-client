import 'dart:io';
import 'dart:convert';
import 'package:web_socket_channel/status.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:dio/dio.dart';
import 'package:async/async.dart';

final dio = Dio();

// for async stdio
// https://gist.github.com/frencojobs/dca6a24e07ada2b9df1683ddc8fa45c6
var _stdinLines = StreamQueue(LineSplitter().bind(Utf8Decoder().bind(stdin)));

Future<String> readLine([String? query]) async {
  if (query != null) stdout.write(query);
  return _stdinLines.next;
}

Future main() async {
  Cli();
}

Future Cli() async {
  WebSocketChannel channel;

  while (true) {
    stdout.write('>> ');
    String? str = await readLine();
    if (str == "exit") {
      break;
    }
    if (str == "root") {
      final response = await SimpleHttpRequest('http://127.0.0.1:3000/');
      print(response);
    } else if (str == "state") {
      final response = await SimpleHttpRequest('http://127.0.0.1:3000/state');
      print(response);
    } else if (str == "bogoconnect") {
      final response = await SimpleHttpRequest('http://127.0.0.1:3000/connect');
      print(response);
    } else if (str == "connect") {
      channel =
          WebSocketChannel.connect(Uri.parse('ws://127.0.0.1:3000/connect'));
      channel.sink.add("hello");
      await WebSocketCli(await channel);
    } else {
      print('unkown command $str');
    }
  }
}

Future<String> SimpleHttpRequest(String url) async {
  Response response = await dio.get(url);
  return response.data.toString();
}

Future WebSocketCli(WebSocketChannel channel) async {
  channel.stream.listen((message) {
    print('received: $message');
  }, onDone: () {
    print('WebSocket connection closed');
  }, onError: (error) {
    print('Error: $error');
  });

  while (true) {
    String? str = await readLine();

    if (str == 'exit') {
      break;
    } else {
      channel.sink.add(str);
    }
  }
}

Future SomeAsync() async {
  print("some async start");
  for (int i = 0; i < 100; i++) {
    print("Some ${i}");
    await Future.delayed(Duration(seconds: 5));
  }
}

Future UpgradeRequest() async {
  var channel = WebSocketChannel.connect(
    Uri.parse('ws://127.0.0.1:3000/connect'),
  );

  channel.sink.add('hello!');
  channel.sink.add('hello 2');

  //while (true) {}
}

Future Request() async {
  var serverIp = InternetAddress.loopbackIPv4.host;
  var serverPort = 3000;
  var serverPath;

  var httpClient = HttpClient();

  HttpClientRequest httpRequest;
  HttpClientResponse httpResponse;

  var httpResponseContent;
  var httpContent;
  serverPath = "/";
  httpRequest = await httpClient.get(serverIp, serverPort, serverPath);
  httpRequest.headers.add('Host', '${serverIp}');

  httpResponse = await httpRequest.close();
  httpResponseContent = await utf8.decoder.bind(httpResponse).join();
  printHttpContentInfo(httpResponse, httpResponseContent);

  // change success
  if (httpResponse.statusCode == 101) {
    //WebSocket socket = await WebSocket.connect("ws://127.0.0.1:3000/connect");
    //print("websocket connect");
    //socket.add('Hello');
  }
}

void printHttpContentInfo(var httpResponse, var httpResponseContent) {
  print("|<- status-code    : ${httpResponse.statusCode}");
  print("|<- content-type   : ${httpResponse.headers.contentType}");
  print("|<- content-length : ${httpResponse.headers.contentLength}");
  print("|<- content        : $httpResponseContent");
}

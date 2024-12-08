import 'package:just_audio/just_audio.dart';

final player = AudioPlayer();

Future playAudio(String path) async {
  //print("play $path");
  await player.setAsset(path);
  await player.play();
}

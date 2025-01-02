import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({Key? key}) : super(key: key);

  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  // bool isPlaying = false;

  Future<void> playAudio() async {
    await _audioPlayer.play(AssetSource('assets/audio/Never Love Again.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Image.asset("assets/images/img.png"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: playAudio,
            child: const Text("Thank You",style: TextStyle(color: Colors.black,fontSize: 18),),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}

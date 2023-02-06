import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioScreen extends StatefulWidget {
  const AudioScreen({super.key});

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  Duration duration = Duration.zero;
  Duration currentDuration = Duration.zero;
  final AudioPlayer player = AudioPlayer();
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();

    player.onDurationChanged.listen((Duration d) {
      duration = d;
    });
    player.onPositionChanged.listen((Duration d) {
      currentDuration = d;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF011E32),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 406,
              width: 294,
              decoration: BoxDecoration(
                color: const Color(0xFF023053),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Container(
                      height: 200,
                      width: 185,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Center(child: Text("Bu yerda rasm bo'ladi")),
                    ),
                  ),
                  const SizedBox(height: 44),
                  const Text(
                    "Bu yerda nomi bo'ladi",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )
                ],
              ),
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: 180,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () async {},
                      icon: const Icon(
                        Icons.skip_previous,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: () async {
                        if (isPlaying) {
                          await player.pause();
                        } else {
                          await player.play(AssetSource("mp3/blinding.mp3"));
                        }
                        isPlaying = !isPlaying;
                        setState(() {});
                      },
                      icon: Icon(
                        isPlaying ? Icons.pause : Icons.play_arrow,
                        color: Colors.white,
                        size: 32,
                      )),
                  IconButton(
                      onPressed: () async {},
                      icon: const Icon(
                        Icons.skip_next,
                        color: Colors.white,
                      )),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 30,
                  child: Text(
                    "${currentDuration.inMinutes}:${currentDuration.inSeconds % 60}",
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                SizedBox(
                  width: 280,
                  child: SliderTheme(
                    data: const SliderThemeData(
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 6.0),
                    ),
                    child: Slider(
                      max: duration.inSeconds.toDouble(),
                      value: currentDuration.inSeconds.toDouble(),
                      onChanged: (value) async {
                        await player.seek(Duration(seconds: value.toInt()));
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                  child: Text(
                    "${duration.inMinutes.remainder(60)}:${duration.inSeconds.remainder(60)}",
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}

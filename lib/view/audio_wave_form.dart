import 'package:flutter/material.dart';
import 'package:audio_waveforms/audio_waveforms.dart';

class AudioWaveForm extends StatefulWidget {
  const AudioWaveForm({super.key});

  @override
  State<AudioWaveForm> createState() => _AudioWaveFormState();
}

class _AudioWaveFormState extends State<AudioWaveForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50,),
         /* AudioWaveforms(
            size: Size(MediaQuery.of(context).size.width, 200.0),
            recorderController: controller,
            enableGesture: true,
            waveStyle: WaveStyle(
            color: Colors.white,
            showDurationLabel: true,
            spacing: 8.0,
            showBottom: false,
            extendWaveform: true,
            showMiddleLine: false,
            gradient: ui.Gradient.linear(
            const Offset(70, 50),
            Offset(MediaQuery.of(context).size.width / 2, 0),
            [Colors.red, Colors.green],
          ),
      ),
    ),*/
          ],
        ),
      ),
    );
  }
}

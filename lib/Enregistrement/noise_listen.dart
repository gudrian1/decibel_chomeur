import 'dart:async';
import 'package:chomeurs/Enregistrement/enregistrements.dart';
import 'package:chomeurs/datadisplay.dart';
import 'package:flutter/material.dart';
import 'package:noise_meter/noise_meter.dart';

double? getValue;

class NoiseListen extends StatefulWidget {
  @override
  _NoiseListenState createState() => _NoiseListenState();
}

class _NoiseListenState extends State<NoiseListen> {
  bool _isRecording = false;
  StreamSubscription<NoiseReading>? _noiseSubscription;
  late NoiseMeter _noiseMeter;
  double? maxDB;
  double? meanDB;

  @override
  void initState() {
    super.initState();
    _noiseMeter = NoiseMeter(onError);
  }

  void onData(NoiseReading noiseReading) {
    this.setState(() {
      if (!this._isRecording) this._isRecording = true;
    });
    maxDB = noiseReading.maxDecibel;
    meanDB = noiseReading.meanDecibel;
    getValue = meanDB;

  }

  void onError(Object e) {
    print(e.toString());
    _isRecording = false;
  }

  void start() async {
    try {
      //possible problème ici suite à une attente du programme.
      //await Future.delayed(Duration(seconds: 3));
      _noiseSubscription = _noiseMeter.noiseStream.listen(onData);
    } catch (e) {
      print(e);
    }
  }

  void stop() async {
    try {
      _noiseSubscription!.cancel();
      _noiseSubscription = null;

      this.setState(() => this._isRecording = false);
    } catch (e) {
      print('stopRecorder error: $e');
    }
  }

  double? getMeanDB(){
    return getValue;
  }

  @override
  Widget build(BuildContext context) {
    // ICI FAIRE LA PARTIE D'HENRI
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Text(_isRecording ? 'Stop' : 'Start'),
        onPressed: _isRecording ? stop : start,
        icon: !_isRecording ? Icon(Icons.circle) : null,
        backgroundColor: _isRecording ? Colors.red : Colors.green,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  maxDB != null ? maxDB!.toStringAsFixed(2) : 'Press start',
                ),
              ),
            ),
            Text(
              meanDB != null
                  ? 'Mean: ${meanDB!.toStringAsFixed(2)}'
                  : 'Awaiting data',
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
            ),

            SizedBox(
              height: 68,
            ),
          ],
        ),
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }

}
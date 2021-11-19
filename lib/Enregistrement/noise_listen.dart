import 'dart:async';
import 'package:chomeurs/Enregistrement/enregistrements.dart';
import 'package:chomeurs/datadisplay.dart';
import 'package:flutter/material.dart';
import 'package:noise_meter/noise_meter.dart';
import 'package:flutter/scheduler.dart';
import '../datadisplay.dart';

double? getValue = 0.00;
var cptStart = 0;
var cptStop = 0;

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
      cptStart ++;
    } catch (e) {
      print(e);
    }
  }

  void stop() async {
    try {
      _noiseSubscription!.cancel();
      _noiseSubscription = null;

      this.setState(() => this._isRecording = false);
      cptStop++;
      Navigator.of(context).pushNamed("ThirdRoute");
    } catch (e) {
      print('stopRecorder error: $e');
    }
  }

  double? getMeanDB(){
    if (getValue != null) {
      return getValue;
    }
    return 0.00;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Text(_isRecording ? 'Stop' : 'Start'),
        onPressed: cptStart == 1 ? stop : start,
        icon: !_isRecording ? Icon(Icons.circle) : null,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  meanDB != null ? getMeanDB()!.toStringAsFixed(2) : 'Valeur nulle',
                ),
              ),
            ),
            SizedBox(
              height: 68,
            ),
            PageOrg()
          ],
        ),
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }

}
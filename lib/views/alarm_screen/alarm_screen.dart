import 'dart:async';

import 'package:daily_life_tasks_management/views/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlarmScreen extends StatefulWidget {
  @override
  _AlarmScreenState createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationControllerp;
  final Battery _battery = Battery();
  bool isCharging = false;
  bool isPlayingRingtone = false;
  int batteryLevel = 0;

  @override
  void initState() {
    super.initState();
    animationControllerp = AnimationController(vsync: this);
    _loadSavedBatteryState();
    _checkBatteryStatus();
    Timer.periodic(Duration(seconds: 3), (timer) {
      _checkBatteryLevel();
    });
  }

  void _checkBatteryStatus() {
    _battery.batteryState.then((batteryState) {
      setState(() {
        isCharging = batteryState == BatteryState.charging ||
            batteryState == BatteryState.full;
      });
      if (isCharging && batteryLevel == 100 && !isPlayingRingtone) {
        _startRingtone();
      } else if (!isCharging) {
        _stopRingtone();
      }
    });
  }

  void _checkBatteryLevel() {
    _battery.batteryLevel.then((level) {
      setState(() {
        batteryLevel = level;
        isCharging = level == 100;
      });

      _checkBatteryStatus();
    });
  }

  void _startRingtone() {
    FlutterRingtonePlayer.play(
      android: AndroidSounds.alarm,
      ios: IosSounds.glass,
      looping: true,
      volume: 0.5,
    );

    setState(() {
      isPlayingRingtone = true;
    });
  }

  void _stopRingtone() {
    FlutterRingtonePlayer.stop();
    setState(() {
      isPlayingRingtone = false;
    });
  }

  void _loadSavedBatteryState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      batteryLevel = prefs.getInt('batteryLevel') ?? 0;
      isCharging = prefs.getBool('isCharging') ?? false;
    });
  }

  void _saveBatteryState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('batteryLevel', batteryLevel);
    prefs.setBool('isCharging', isCharging);
  }

  @override
  void dispose() {
    _stopRingtone();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Battery Monitor'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Dashboard()));
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset("assets/json/charging_on.json",
                    height: 200,
                    width: 300,
                    fit: BoxFit.cover,
                    repeat: true,
                    controller: animationControllerp, onLoaded: (composite) {
                  animationControllerp.duration = composite.duration;
                  animationControllerp.repeat();
                }),
                const SizedBox(height: 120),
                Text(
                  'Battery Level: $batteryLevel%',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20),
                Text(
                  isCharging ? 'Charging' : 'Not Charging',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                isCharging
                    ? const SizedBox(
                        width: 50,
                        height: 50,
                        child: const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.green),
                        ),
                      )
                    : Container(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

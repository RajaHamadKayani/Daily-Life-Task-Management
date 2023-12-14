import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_life_tasks_management/view_models/controllers/login_view_controller/login_view_controller.dart';
import 'package:daily_life_tasks_management/views/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';

import '../my_map/my_map.dart';

class GoogleMapPermission extends StatefulWidget {
  const GoogleMapPermission({super.key});

  @override
  State<GoogleMapPermission> createState() => _GoogleMapPermissionState();
}

class _GoogleMapPermissionState extends State<GoogleMapPermission> {
  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;

  @override
  void initState() {
    super.initState();
    _requestPermission();
    // location.changeSettings(interval: 300, accuracy: loc.LocationAccuracy.high);
    // location.enableBackgroundMode(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('live location tracker'),
      ),
      body: Column(
        children: [
           IconButton(
                  onPressed: () {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Dashboard()));
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
          TextButton(
              onPressed: () {
                _getLocation();
              },
              child: const Text('add my location')),
          TextButton(
              onPressed: () {
                _listenLocation();
              },
              child: const Text('enable live location')),
          TextButton(
              onPressed: () {
                _stopListening();
              },
              child: const Text('stop live location')),
          Expanded(
              child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('location').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        title:
                            Text(snapshot.data!.docs[index]['name'].toString()),
                        subtitle: Row(
                          children: [
                            Text(snapshot.data!.docs[index]['latitude']
                                .toString()),
                            SizedBox(
                              width: 20,
                            ),
                            Text(snapshot.data!.docs[index]['longitude']
                                .toString()),
                          ],
                        ),
                        trailing: InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MyMap(snapshot.data!.docs[index].id)));
                          },
                          child: Container(
                            height: 50,
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Center(
                              child: Text(
                                "Show my Location",
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ));
                  });
            },
          )),
        ],
      ),
    );
  }

  _getLocation() async {
    try {
      final loc.LocationData _locationResult = await location.getLocation();
      await FirebaseFirestore.instance.collection('location').doc('user1').set({
        'latitude': _locationResult.latitude,
        'longitude': _locationResult.longitude,
        'name': LoginViewController.userName
      }, SetOptions(merge: true));
    } catch (e) {
      print(e);
    }
  }

  Future<void> _listenLocation() async {
    _locationSubscription = location.onLocationChanged.handleError((onError) {
      print(onError);
      _locationSubscription?.cancel();
      setState(() {
        _locationSubscription = null;
      });
    }).listen((loc.LocationData currentlocation) async {
      await FirebaseFirestore.instance.collection('location').doc('user1').set({
        'latitude': currentlocation.latitude,
        'longitude': currentlocation.longitude,
        'name': LoginViewController.userName
      }, SetOptions(merge: true));
    });
  }

  _stopListening() {
    _locationSubscription?.cancel();
    setState(() {
      _locationSubscription = null;
    });
  }

  _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      print('done');
    } else if (status.isDenied) {
      _requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}

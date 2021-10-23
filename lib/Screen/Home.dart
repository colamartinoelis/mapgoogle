import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:mapgoogle/Component/Pannello.dart';
import 'package:mapgoogle/Component/Mappa.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("MapGOOGLE"),
        ),
        body: new SlidingUpPanel(
          color: Theme.of(context).primaryColor,
          minHeight: 100,
          maxHeight: 300,
          borderRadius: new BorderRadius.circular(20),
          panel: new Pannello(),
          body: new Mappa(),
        ));
  }
}

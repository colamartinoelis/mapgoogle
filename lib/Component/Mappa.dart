import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Mappa extends StatefulWidget {
  @override
  _MappaState createState() => _MappaState();
}

class _MappaState extends State<Mappa> {
  static final CameraPosition initialPosition = new CameraPosition(
    target: LatLng(40.785091, -73.968285),
    tilt: 0,
    bearing: 0,
    zoom: 15,
  );

  static final CameraPosition endPosition = new CameraPosition(
    target: LatLng(40.780091, -73.962185),
    tilt: 0,
    bearing: 0,
    zoom: 15,
  );

  Set<Marker> markers = {};
  Set<Polyline> polylines = {};

  /* Completer è una classe che contiene in automatico una future: The completer
  completes the future asynchronously. That means that callbacks registered on
  the  future are not called immediately when complete  or completeError is
  called.  Instead the callbacks are delayed until  a  later microtask.  */
  final Completer<GoogleMapController> googleMapController = new Completer();
  /*1*/ final Completer<String> googleMapStyle = new Completer();

  @override
  void initState() {
    /*2*/ rootBundle
        .loadString("asset/stile.json")
        .then((value) => googleMapStyle.complete(value));
    setupMap();
    super.initState();
  }

//inizializiamo
  Future<void> setupMap() async {
    final gooleMap = await googleMapController.future;
    /*3*/ final stile = await googleMapStyle.future;
    /*ora è stato iniziliato il controllore che inizialmente avrà solo una
    future che inizialmente non è stata completata ma che verrà settata come
    completata in future dalla riga 61 che contiene al suo interno infatti il
    controllore della mappa. E' stato in qualche modo creato lo
     spazio per un qualcosa che verrà completato in futuro */

    /* ora faccio lo stesso ragionamento per ottenere lo stile che voglio
    sulla mappa: 1) istanzio un completer<String> che mi permetta di
    risolvere e scaircare il json. 2)  andare in initState e permettere di completare la
    variabile istanziata di modo che in 3) setupMap possa impostare il metodo
    asincrono che mi setta la variabile stile che mi servirà di modificare lo
     stile della mappa*/

    /* 4) posso una volta che ho le due variabile che verrano istanziate in
    maniera asincrona (in un futuro quando verrano scaricari i dati ed è per
    questo che non sappiano quando verrano risolte ) impostare il mio stile
    alla mappa!*/

    /*4*/
    gooleMap.setMapStyle(stile);

    //5) per impostare i segnaposti usare il setState e la classe SET e il
    // metodo setState
    setState(() {
      markers.add(new Marker(
        markerId: new MarkerId(//id!
            initialPosition.target.toString()),
        infoWindow: new InfoWindow(title: "Starting point"),
        position: initialPosition.target,
      ));
      markers.add(new Marker(
        markerId: new MarkerId(//id!
            endPosition.target.toString()),
        infoWindow: new InfoWindow(title: "End point"),
        position: endPosition.target,
      ));
      polylines.add(new Polyline(
        polylineId: new PolylineId(
          //id!
          initialPosition.target.toString() + endPosition.target.toString(),
        ),
        width: 4,
        points: [initialPosition.target, endPosition.target],
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return new GoogleMap(
      initialCameraPosition: initialPosition,
      zoomControlsEnabled: false, //disabilita eventuali pulsanti posizionati
      // in basso e a destra
      
      //una volta che la mappa è stata costruita posso agire su di essa
      // tramite l'apposito controllore e con il parametro onMapCreated: è
      // una callback che rivece come parametro che è il controller della
      // mappa che possiamo utilizzare per fare eventuali modifiche come ad
      // asempio aggiungere stile personalizzato alla mappa
      onMapCreated: (GoogleMapController controller) {
        this.googleMapController.complete(controller);
        /* con questo metodo si completa la future e si setta il
        controllore in modo che si possa impostare uno stile personalizzato
        alla mappa o controllare la mappa in modo dinamico */
      },
      /* mapType: MapType.satellite,
     in questo modo vado a selezionare il tipo di stile che voglio della mappa*/

      /* per segnare i segnaposti e una linea di congiungimento utilizzare i seguenti paramentri */
      markers: markers,
      polylines: polylines,
    );
  }
}

/*
Widget map() => GoogleMap(
  initialCameraPosition: initialPosition,
  zoomControlsEnabled: false,

  onMapCreated: (GoogleMapController controller) {
    this.googleMapController.complete(controller);
  },
);*/

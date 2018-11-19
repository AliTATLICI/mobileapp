import 'package:flutter/material.dart';
//import 'package:url_launcher/url_launcher.dart';
import '../shared/global_config.dart';
import 'package:map_view/map_view.dart';

class EczaneSayfasi2 extends StatefulWidget {
  @override
  EczaneSayfasi2State createState() {
    return new EczaneSayfasi2State();
  }
}

class EczaneSayfasi2State extends State<EczaneSayfasi2> {
  MapView mapView = MapView();
  CameraPosition cameraPosition;
  var staticMapProvider = StaticMapProvider(apiKey);
  Uri staticMapUri;

  List<Marker> markers = <Marker>[
    Marker("1", "Işıkkent Mah.", 37.766849, 30.523325, color: Colors.amber),
    Marker("2", "Gökkube", 37.767294, 30.518459, color: Colors.purple)
  ];

  showMap() {
    mapView.show(MapOptions(
        mapViewType: MapViewType.normal,
        initialCameraPosition:
            CameraPosition(Location(37.774829, 30.560586), 15.0),
        showUserLocation: true,
        title: "Recent Location"));
    mapView.setMarkers(markers);
    mapView.zoomToFit(padding: 100);

    mapView.onMapTapped.listen((_) {
      setState(() {
        mapView.setMarkers(markers);
        mapView.zoomToFit(padding: 100);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    cameraPosition = CameraPosition(Location(37.774829, 30.560586), 2.0);
    staticMapUri = staticMapProvider.getStaticUriWithMarkers([
        Marker('position', 'Position', 37.773288, 30.551460)
      ],
          center: Location(37.773288, 30.551460),
          width: 500,
          height: 400,
          maptype: StaticMapViewType.roadmap);
  }

  static const double lat = 37.8015811, long = 30.5095026;
  static const String map_api = "AIzaSyCESLdlBDj2ptHMyXAYYGsr_Qm27xtcb1w";

  @override
  Widget build(BuildContext context) {
    //method to bring out dialog
    void makeDialog() {
      showDialog(
          context: context,
          builder: (_) => new SimpleDialog(
                contentPadding: EdgeInsets.only(left: 30.0, top: 30.0),
                children: <Widget>[
                  new Text(
                    "Address: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  new ButtonBar(
                    children: <Widget>[
                      new IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            Navigator.pop(context);
                          })
                    ],
                  )
                ],
              ));
    }

    return new Scaffold(
        appBar: AppBar(title: Text('Eczane Sayfasi2')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 300.0,
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Container(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          'Map should show here',
                          textAlign: TextAlign.center,
                        )),
                  ),
                  InkWell(
                    child: Center(
                      child: Image.network(staticMapUri.toString()),
                    ),
                    onTap: showMap,
                  )
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Tap the map to interact',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
            Container(
              padding: EdgeInsets.only(top: 25.0),
              child: Text(
                'Camera Position : \n\nLat: ${cameraPosition.center.latitude}\n\nLng:${cameraPosition.center.longitude}\n\nZoom: ${cameraPosition.zoom}',
              ),
            )
          ],
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';
import 'package:geocoder/geocoder.dart';

var api_key = "AIzaSyAtSYZoWvxRujTbQjZ1PM10exOg9nKDx_k";

class MapPage extends StatefulWidget{
  @override
  State createState()=> new MapViewState();
}

class MapViewState extends State<MapPage>{
  MapView mapView = new MapView();
  CameraPosition cameraPosition;
  var staticMapProvider = new StaticMapProvider(api_key);
  Uri staticMapUri;

  List<Marker> markers = <Marker>[
    new Marker("1", "一田百貨", 22.452323, 114.169453, color: Colors.redAccent, draggable: true),
    new Marker("2", "新興花園", 22.453652, 114.174045, color: Colors.redAccent, draggable: true)
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cameraPosition = new CameraPosition(new Location(22.457793, 114.170682), 5.0);
    staticMapUri = staticMapProvider.getStaticUri(
      new Location(22.457793, 114.170682), 12, 
      height: 400, width: 900, mapType: StaticMapViewType.roadmap);
  }

  addLocation(location) async{
    var okay = false;
    print("Touch location: ${location}");
    print("lat: ${location.latitude}");
    print("long: ${location.longitude}");

    final coordinates = new Coordinates(location.latitude, location.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print("${first.featureName} : ${first.addressLine}");


    this.markers.add(Marker('${this.markers.length+1}', first.addressLine, location.latitude, location.longitude, color: Colors.redAccent, draggable: true));
    mapView.dismiss();
    //mapView.clearAnnotations();

    // final coordinates = new Coordinates(location.latitude, location.longitude);
    // Geocoder.local.findAddressesFromCoordinates(coordinates).then(
    //   (data) => print(data));
    
  }

  // addMarker(data){
  //   this.markers.add(new Marker((this.markers.length+1).toString(), data, location.latitude, location.longitude, color: Colors.redAccent, draggable: true));
  //   mapView.dismiss();
  // }

  showMap(){
    mapView.show(
      new MapOptions(
        mapViewType: MapViewType.normal,
        showUserLocation: false,
        showMyLocationButton: true,
        showCompassButton: true,
        hideToolbar: false,
        initialCameraPosition: new CameraPosition(new Location(22.457793, 114.170682), 16.0),
        title: "Pin your favourite location",
      ),
      toolbarActions: [new ToolbarAction("Close", 1)]
    );

    mapView.onToolbarAction.listen((id) {
      if (id == 1) {
        mapView.dismiss();
      }
    });

    mapView.onMapReady.listen((_) {
      //print("Map ready");
      mapView.setMarkers(markers);
      mapView.zoomToFit(padding: 100);
    });
    
    mapView.onMapTapped.listen((location) => this.addLocation(location));

    mapView.onCameraChanged.listen((cameraPosition) =>
     this.setState(() => this.cameraPosition = cameraPosition));

    mapView.onLocationUpdated
     .listen((location) => print("Location updated $location"));

        // This listener fires when the marker is long pressed and could be moved.
    mapView.onAnnotationDragStart.listen((markerMap) {
          var marker = markerMap.keys.first;
          var location = markerMap[marker]; // The original location of the marker before moving it. Use it if needed.
          print("Annotation ${marker.id} dragging started");
        });
    // This listener fires when the user releases the marker.
    mapView.onAnnotationDragEnd.listen((markerMap) {
          var marker = markerMap.keys.first;
          var location = markerMap[marker]; // The actual position of the marker after finishing the dragging.
          print("Annotation ${marker.id} dragging ended");
        });
    // This listener fires every time the marker changes position.
    mapView.onAnnotationDrag.listen((markerMap) {
          var marker = markerMap.keys.first;
          var location = markerMap[marker]; // The updated position of the marker.
          print("Annotation ${marker.id} moved to ${location.latitude} , ${location
              .longitude}");
        });
    
  }
  

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: AppBar(title: Text("Add favourite places"), backgroundColor: Colors.redAccent,),
      body: 
      // new Column(
          // children: <Widget>[
          //   new Container(
              ListView.builder(
                // Let the ListView know how many items it needs to build
                itemCount: this.markers.length,
                // Provide a builder function. This is where the magic happens! We'll
                // convert each item into a Widget based on the type of item it is.
                itemBuilder: (context, index) {
                  final item = this.markers[index];

                    return ListTile(
                      title: Text(item.title),
                      subtitle: Text('id: ${item.id}'),
                    );
                  
                },
              
              ),
            // ),
            // new Container(
            //   child: new InkWell(
            //     child: new Center(
            //       child: new Image.network(staticMapUri.toString()),
            //     ),
            //     onTap: showMap,
            //   ),
            // ),
      //     ],
      // ),       
        
      

        

      floatingActionButton: new FloatingActionButton(
        onPressed: showMap,
        child: new Icon(Icons.add),
      ),
    );
  }
}
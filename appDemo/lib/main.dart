import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import './map.dart';
import './web.dart';


var api_key = "AIzaSyAtSYZoWvxRujTbQjZ1PM10exOg9nKDx_k";

void main() {
  
  MapView.setApiKey(api_key);
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new testApp()
  ));
} 

class testApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      home: new HomePage(),
      theme: new ThemeData(
          primarySwatch: Colors.blue,
      )
    );
  }
}

class HomePage extends StatefulWidget{
  @override
  State createState()=>new HomePageState();
}



class HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  MapView mapView = new MapView();
  final webview = FlutterWebviewPlugin();

  @override
  void initState(){
    super.initState();
    mapView.dismiss();
    webview.close();
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('HKTaxi'), 
        backgroundColor: Colors.redAccent, 

        ),
      backgroundColor: Colors.white,
      body: new SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: new Column(
          
          children: <Widget>[
                      new TextFormField(
                        decoration: new InputDecoration(
                          hintText: "目的地點",
                          contentPadding: new EdgeInsets.all(10.0),
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                      ),
                      new TextFormField(
                        decoration: new InputDecoration(
                          hintText: "付款方式",
                          contentPadding: new EdgeInsets.all(10.0),
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                      ),
                      new TextFormField(
                        decoration: new InputDecoration(
                          hintText: "聯絡電話",
                          contentPadding: new EdgeInsets.all(10.0),
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                      ),
                      new TextFormField(
                        decoration: new InputDecoration(
                          hintText: "隧道",
                          contentPadding: new EdgeInsets.all(10.0),
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                      ),
                      new TextFormField(
                        decoration: new InputDecoration(
                          hintText: "備註",
                          contentPadding: new EdgeInsets.all(10.0),
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                      ),

                      new TextFormField(
                        decoration: new InputDecoration(
                          hintText: "其他要求",
                          contentPadding: new EdgeInsets.all(10.0),
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                      ),

                      new Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                      ),
                      new MaterialButton(
                        height: 40.0,
                        minWidth: 180.0,
                        color: Colors.red,
                        textColor: Colors.white,
                        child: new Text("立即Call車"),
                        onPressed: (){
                          
                        },
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                      ),
                      new MaterialButton(
                        height: 40.0,
                        minWidth: 180.0,
                        color: Colors.teal,
                        textColor: Colors.white,
                        child: new Text("Map View Demo"),
                        onPressed: (){
                          Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => MapPage())
                            );
                        },
                      ),

                      new Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                      ),
                      new MaterialButton(
                        height: 40.0,
                        minWidth: 180.0,
                        color: Colors.blueAccent,
                        textColor: Colors.white,
                        child: new Text("Web View Demo"),
                        onPressed: (){
                          Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => WebPage())
                            );
                        },
                      )
          ],
        ),
      )
    );
  }
}
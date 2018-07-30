import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

String url = 'https://youtube.com';

class WebPage extends StatefulWidget{
  @override
  State createState()=> new WebViewState();
}

class WebViewState extends State<WebPage>{
  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      title: "Webview Demo",
      theme: ThemeData.dark(),
      routes: {
        "/": (_) => Home(),
        "/webview": (_) => WebviewScaffold(
          url: url,
          appBar: new AppBar(
            title: Text("Webview"),
          ),
          withJavascript: true,
          withLocalStorage: true,
          withZoom: true,
          )
      },
    );
  }
}

class Home extends StatefulWidget{
  @override
  State createState() => new HomeState();
}

class HomeState extends State<Home>{
  final webview = FlutterWebviewPlugin();
  TextEditingController controller = new TextEditingController(text: url);

  @override
  void initState(){
    super.initState();
    webview.close();
    controller.addListener((){
      url = controller.text;
    }); 
  }

  @override
  void dispose() {
    webview.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Webview Demo"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: controller,
              ),
            ),
            RaisedButton(
              child: Text("Open new window website"),
              onPressed: (){
                
                Navigator.of(context).pushNamed("/webview");
              },
            ),
            RaisedButton(
              child: Text("Open small website"),
              onPressed: (){
                webview.launch(url,
                  rect: new Rect.fromLTWH(
                      0.0, 
                      400.0, 
                      MediaQuery.of(context).size.width, 
                      350.0));
              },
            ),
            RaisedButton(
              child: Text("Close web"),
              onPressed: ()=>webview.close(),
            )
          ],
        ),
      ),
    );
  }

}
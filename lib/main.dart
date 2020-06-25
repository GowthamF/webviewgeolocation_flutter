import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:permission_handler/permission_handler.dart';

String selectedUrl = 'https://visafindersdb.firebaseapp.com/';

const kAndroidUserAgent =
    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();

  @override
  Widget build(BuildContext context) {
    getPermissions();
    return MaterialApp(
      title: 'Flutter Web view Geo Location',
      home: WebviewScaffold(
        url: selectedUrl,
        appBar: AppBar(
          title: Text('Flutter Web view Geo Location'),
        ),
        withLocalStorage: true,
        geolocationEnabled: true,
        initialChild: Container(
          color: Colors.redAccent,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  flutterWebviewPlugin.goBack();
                },
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  flutterWebviewPlugin.goForward();
                },
              ),
              IconButton(
                icon: const Icon(Icons.autorenew),
                onPressed: () {
                  flutterWebviewPlugin.reload();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getPermissions() async {
    if (!await Permission.location.request().isGranted) {
      await Permission.location.request();
    }
  }
}

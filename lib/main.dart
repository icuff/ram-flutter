import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'RAM Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _btnVisible;
  bool _txtVisible;
  String _statusTxt = 'Processing...';
  // 1 billion throws out of memory error
  static final int _repetitions = 1000000;
  List array = [];

  void initState() {
    super.initState();
    _btnVisible = true;
    _txtVisible = false;
  }

  void start() {
    DateTime begin = DateTime.now();
    setState(() {
      _btnVisible = false;
      _txtVisible = true;
      _statusTxt = 'Processing...';
    });

    // Times that process of populating and cleaning array is repeated
    for(int i = 0; i < 10; i++) {
      // Populating array
      for(int j = 0; j < _repetitions; j++) {
        array.add(1);
      }

      array = [];
      setState(() {
        _statusTxt = 'Process: ' + i.toString();
      });
    }

    DateTime end = DateTime.now();
    String duration = end.difference(begin).inMilliseconds.toString();
    setState(() {
      _statusTxt = 'Finished in ' + duration + 'ms';
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Visibility(
              visible: _btnVisible,
              child: RaisedButton(
                onPressed: start,
                child: Text('Start'),
              ),
            ),
            Visibility(
              visible: _txtVisible,
              child: Text(_statusTxt)
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

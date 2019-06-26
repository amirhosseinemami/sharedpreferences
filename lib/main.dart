import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _number;
  bool _isPressed = true;
  Timer _timer;
  SharedPreferences prefs;
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    prefs = await SharedPreferences.getInstance();
    _number = (prefs.getInt('number') ?? 0);
    setState(() {
      _number;
    });
  }

  void increaseNumber() {
    _number++;
    prefs.setInt('number', _number);
    setState(() {
      _number;
    });
  }

  void decreaseNumber() {
    _number--;
    prefs.setInt('number', _number);
    setState(() {
      _number;
    });
  }

  void increasePerSecond() {
    switch (_isPressed) {
      case true:
        {
          setState(() {
            _isPressed = false;
          });
          _timer = Timer.periodic(
              Duration(seconds: 1), (Timer t) => this.increaseNumber());
          print(_isPressed.toString());
        }
        break;
      case false:
        {
          setState(() {
            _isPressed = true;
          });
          print(_isPressed.toString());
          _timer.cancel();
        }
        break;
      default:
        {
          print('error');
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'shared preferences',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Shared Preference'),
        ),
        floatingActionButton: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(5),
              child: FloatingActionButton(
                elevation: 0,
                onPressed: () => this.increasePerSecond(),
                child: _isPressed
                    ? new Icon(Icons.play_arrow)
                    : new Icon(Icons.pause),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: FloatingActionButton(
                elevation: 0,
                child: Icon(Icons.arrow_drop_up),
                onPressed: () => this.increaseNumber(),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: FloatingActionButton(
                elevation: 0,
                onPressed: () => this.decreaseNumber(),
                child: Icon(Icons.arrow_drop_down),
              ),
            ),
          ],
        ),
        body: Center(
          child: Text(
            _number.toString(),
            style: TextStyle(
              fontSize: 50,
            ),
          ),
        ),
      ),
    );
  }
}

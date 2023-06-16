import 'dart:async';

import 'package:flutter/material.dart';
import 'package:safarirally2023/widgets/map_selection_widget.dart';
import 'package:safarirally2023/widgets/schedule_widget.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List _colors = [
    Colors.lightBlueAccent,
    Colors.lightGreenAccent,
    Colors.deepPurple
  ];
  int _currentColorIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  // Start the timer
  void _startTimer() {
    // Set up a periodic timer that triggers the color change every 3 seconds
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _currentColorIndex = (_currentColorIndex + 1) % _colors.length;
      });
    });
  }

  // Cancel the timer when the widget is disposed
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: SizedBox(
                        height: 30,
                        child: Image.asset("images/map2.gif", fit: BoxFit.cover,)
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Stage Maps",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 18
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10,),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Pick the Stage to show the map and add toilet and litter area locations",
                  style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontFamily: "sans-serif-light",
                      fontSize: 16
                  ),
                ),
              ),
              const SizedBox(
                  height: 250,
                  child: MapSelectionWidget()
              ),
              const SizedBox(height: 50,),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: SizedBox(
                        height: 30,
                        child: Image.asset("images/giphy.gif")
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Safari Rally 2023 Schedule",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 18
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10,),
              AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          _colors[_currentColorIndex], // Use the current color
                          _colors[(_currentColorIndex + 1) % _colors.length], // Use the next color in the list
                        ],
                      )
                  ),
                  height: 500,
                  child: const RallySchedule()
              )
            ],
          ),
        ),
      ),
    );
  }
}

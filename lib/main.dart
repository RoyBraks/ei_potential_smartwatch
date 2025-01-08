import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  bool showNotification = false;  

  int timerTime = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      timerTime++;
      if (timerTime % 60 == 0) {
        setState(() {
          showNotification = true;
        });
        Timer(const Duration(seconds: 10), () => setState(() {
            showNotification = false;
        }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp (
      title: 'eiSmartWatch',
      home: Scaffold(
        backgroundColor: Color.fromRGBO(0, 21, 44, 1),
        body: Padding(
          padding: EdgeInsets.fromLTRB(6.3, 16.6, 6.3, 16.6),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8),
              child: Builder(
                builder: (context) {
                  if(!showNotification) {
                    return Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                            MetricsSection(),
                            TimerSection()
                        ],
                      ),
                    );
                  } else {
                    return Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Warning', 
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              height: 1,
                            ),
                          ),
                          Icon(
                            Icons.back_hand,
                            color: Colors.red,
                            size: 30,
                          ),
                          Text('Intensity too high', 
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              height: 1,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }
              )

            ),
          )
        ),
      ),
    );
  }
}

class TimerSection extends StatefulWidget {
  const TimerSection({
    super.key,
  });

  @override
  State<TimerSection> createState() => _TimerSectionState();
}

class _TimerSectionState extends State<TimerSection> {

  String formattedDate = "00:00:00";

  @override
  void initState() {
    super.initState();
    startStopTimer();
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (mounted) {
        setState(() {
          formattedDate = DateFormat('HH:mm:ss').format(DateTime.now());
        });    
      }
    });
  }

  int stopwatchTime = 0;
  int minutes = 0;
  int seconds = 0;

  String minutesConvert = "00";
  String secondsConvert = "00";

  bool timerStarted = false;

  Timer? _stopwatch;
  void startStopTimer() {
    if (timerStarted == true) {
      stopwatchTime = 0;
      seconds = 0;
      minutes = 0;
      _stopwatch = Timer.periodic(const Duration(seconds: 1), (Timer timer){
        stopwatchTime++;
        seconds++;
        if (seconds == 60) {
          minutes++;
          seconds = 0;
        }
        if (mounted) {
          setState(() {
            minutesConvert = minutes.toString().padLeft(2, '0');
          });

          setState(() {    
            secondsConvert = seconds.toString().padLeft(2, '0');  
          });       
        }
      });
      
    } else {
      if (_stopwatch == null) {
        
      } else {
        _stopwatch!.cancel();
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if (timerStarted == false) {
          timerStarted = true;
        } else {
          timerStarted = false;
        }
        startStopTimer();
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('$minutesConvert', 
                style: TextStyle(
                  color: Color.fromRGBO(41, 230, 223, 1),
                  fontSize: 20,
                  height: 1,
                ),
              ),
              Text('min', 
                style: TextStyle(
                  color: Color.fromRGBO(41, 230, 223, 1),
                  fontSize: 10,
                ),
              ),
              Text('$secondsConvert', 
                style: TextStyle(
                  color: Color.fromRGBO(41, 230, 223, 1),
                  fontSize: 20,
                  height: 1,
                ),
              ),
              Text('sec', 
                style: TextStyle(
                  color: Color.fromRGBO(41, 230, 223, 1),
                  fontSize: 10,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('$formattedDate', 
                  style: TextStyle(
                    color: Color.fromRGBO(41, 230, 223, 1),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MetricsSection extends StatefulWidget {
  const MetricsSection({
    super.key,
  });
  @override

  @override
  State<MetricsSection> createState() => _MetricsSectionState();
}

class _MetricsSectionState extends State<MetricsSection> {
  int _heartrate = 90;

  late Timer _timer;

  int timerTime = 0;

  @override
  void initState() {
    super.initState();
    startNumberUpdater();
  }


  void startNumberUpdater() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      timerTime++;
      var rnd = Random().nextInt(10);
      if (timerTime <= 20) {
          if (rnd < 5) {
            if (mounted) {
              setState(() {
                _heartrate++;
              });      
            }
        } 
      } else {

        if (rnd < 5 || _heartrate <= 100) {
          if (mounted) {
            setState(() {
              _heartrate++;
            });       
          }
        } else {
          if (mounted) {
            setState(() {
              _heartrate--;
            });        
          }
        }

      }
    });
  }

  int speedNotation = 1;
  String speedNotationString = "km/h";
  String speedValue = "60";

  void changeSpeednotation() {
    if (speedNotation == 1 && mounted) {
      setState(() {
        speedNotationString = "km/h";
      });
      setState(() {
        speedValue = "60";
      });
    } else if (speedNotation == 2 && mounted) {
      setState(() {
        speedNotationString = "mph";
      });
      setState(() {
        speedValue = "45";
      });
    } else if (mounted) {
      setState(() {
        speedNotationString = "m/min";
      });
      setState(() {
        speedValue = "200";
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25, right: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: 
              GestureDetector(
                onTap: () {
                  if (speedNotation < 3) {
                    speedNotation++;
                    changeSpeednotation();
                  } else {
                    speedNotation = 1;
                    changeSpeednotation();
                  }
                },
                child: Column(
                  children: [
                    Icon(Icons.speed, 
                      color: Colors.yellowAccent,
                    ),
                    Text('$speedValue', 
                      style: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 28,
                        height: 1.2,
                      ),
                    ),
                    Text('$speedNotationString',
                      style: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
          ),
          Expanded(
            child: 
              Column(
                children: [
                  Icon(Icons.favorite,
                    color: Colors.red,
                  ),
                  Text('$_heartrate', 
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 28,
                      height: 1.2,
                    ),
                  ),
                  Text('bpm',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 12
                    ),
                  ),
                ],
              ),
          )
        ],
      ),
    );
  }
}
 
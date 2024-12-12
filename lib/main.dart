import 'package:flutter/material.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp (
      title: 'eiSmartWatch',
      home: Scaffold(
        backgroundColor: Color.fromRGBO(0, 21, 44, 1),
        body: Padding(
          padding: EdgeInsets.fromLTRB(6.3, 16.6, 6.3, 16.6),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MetricsSection(),
                  TimerSection()
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}

class TimerSection extends StatelessWidget {
  const TimerSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text('03', 
          style: TextStyle(
            color: Color.fromRGBO(41, 230, 223, 1),
            fontSize: 18,
            height: 1,
          ),
        ),
        Text('min', 
          style: TextStyle(
            color: Color.fromRGBO(41, 230, 223, 1),
            fontSize: 6,
          ),
        ),
        Text('23', 
          style: TextStyle(
            color: Color.fromRGBO(41, 230, 223, 1),
            fontSize: 18,
            height: 1,
          ),
        ),
        Text('sec', 
          style: TextStyle(
            color: Color.fromRGBO(41, 230, 223, 1),
            fontSize: 6,
          ),
        ),
      ],
    );
  }
}

class MetricsSection extends StatelessWidget {
  const MetricsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 25, right: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: 
              Column(
                children: [
                  Icon(Icons.speed, 
                    color: Colors.yellowAccent,
                  ),
                  Text('23', 
                    style: TextStyle(
                      color: Colors.yellowAccent,
                      fontSize: 34,
                      height: 1.2,
                    ),
                  ),
                  Text('km/h',
                    style: TextStyle(
                      color: Colors.yellowAccent,
                    ),
                  ),
                ],
              ),
          ),
          Expanded(
            child: 
              Column(
                children: [
                  Icon(Icons.favorite,
                    color: Colors.red,
                  ),
                  Text('77', 
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 34,
                      height: 1.2,
                    ),
                  ),
                  Text('bpm',
                    style: TextStyle(
                      color: Colors.red
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
 
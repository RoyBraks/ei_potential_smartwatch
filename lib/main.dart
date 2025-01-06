import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

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

class MetricsSection extends StatefulWidget {
  const MetricsSection({
    super.key,
  });

  @override
  State<MetricsSection> createState() => _MetricsSectionState();
}

class _MetricsSectionState extends State<MetricsSection> {
  Future<void> installHealthConnect() async => await Health().installHealthConnect();

  @override
  void initState() {
    super.initState();
    fetchHeartRate();
  }
  
  int? heartrate = 0;

  Future<void> fetchHeartRate() async {    
    bool? hasPermissions =
        await Health().hasPermissions([HealthDataType.HEART_RATE], permissions: [HealthDataAccess.READ_WRITE]);

    hasPermissions = false;

    bool isAuthorized = false;
    if (!hasPermissions) {
      // requesting access to the data types before reading them
      try {
       isAuthorized = await Health()
            .requestAuthorization([HealthDataType.HEART_RATE], permissions: [HealthDataAccess.READ_WRITE]);
      } catch (error) {
        debugPrint("Exception in authorize: $error");
      }
    }

    if (isAuthorized) {
      try {
        DateTime now = DateTime.now();
        DateTime startTime = now.subtract(Duration(hours: 1));

        // Ophalen van hartslaggegevens
        List<HealthDataPoint> healthData = await Health().getHealthDataFromTypes(
          startTime: startTime,
          endTime: now,
          types: [HealthDataType.HEART_RATE]
        );

        if (healthData.isNotEmpty) {
          // Neem de laatste beschikbare waarde
          setState(() {
            heartrate = (healthData.last.value as num).round();
          });
        } else {
          setState(() {
            heartrate = 0;
          });
        }
      } catch (e) {
        print("Fout bij het ophalen van hartslaggegevens: $e");
      }
    } else {
      print("Geen toestemming om gezondheidsgegevens te lezen.");
    }
  }

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
                  Text('$heartrate', 
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
 
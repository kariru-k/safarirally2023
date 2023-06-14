import 'package:flutter/material.dart';
import 'package:safarirally2023/services/timer_services.dart';
import 'package:safarirally2023/widgets/map_selection_widget.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TimerServices timerServices = TimerServices();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: const Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
                height: 300,
                child: MapSelectionWidget()
            )
          ],
        ),
      ),
    );
  }
}

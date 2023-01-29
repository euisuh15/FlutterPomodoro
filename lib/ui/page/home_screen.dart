import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pomodoro/ui/widgets/ProgressFraction.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMin = 1500;
  int currSeconds = twentyFiveMin, currPomodoro = 0;
  bool isActive = false;
  late Timer timer;

  void onTick(Timer timer) {
    if (currSeconds == 0) {
      setState(() {
        isActive = false;
        currPomodoro += 1;
        currSeconds = twentyFiveMin;
      });
      timer.cancel();
    } else {
      setState(() {
        currSeconds -= 1;
      });
    }
  }

  String formatSeconds(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().substring(2, 7);
  }

  void onStartPressed() {
    setState(() {
      isActive = true;
    });
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isActive = false;
    });
  }

  void onStopPressed() {
    timer.cancel();
    setState(() {
      isActive = false;
      currPomodoro = 0;
      currSeconds = twentyFiveMin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isActive
          ? Theme.of(context).primaryColor
          : Theme.of(context).disabledColor,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.only(
                top: 80,
              ),
              alignment: Alignment.bottomCenter,
              child: Text(
                formatSeconds(currSeconds),
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 75,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 50,
              vertical: 25,
            ),
            width: MediaQuery.of(context).size.width,
            child: LinearProgressIndicator(
              value: currSeconds / twentyFiveMin,
              backgroundColor: Theme.of(context).backgroundColor,
              color: isActive
                  ? Theme.of(context).disabledColor
                  : Theme.of(context).primaryColor,
            ),
          ),
          Flexible(
            flex: 3,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 120,
                    color: Theme.of(context).cardColor,
                    onPressed: isActive ? onPausePressed : onStartPressed,
                    icon: Icon(isActive
                        ? Icons.pause_circle_outlined
                        : Icons.play_circle_outline),
                  ),
                  IconButton(
                    iconSize: 120,
                    color: Theme.of(context).cardColor,
                    onPressed: onStopPressed,
                    icon: const Icon(Icons.stop_circle_outlined),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(50),
                          topLeft: Radius.circular(50)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ProgressFraction(
                            title: 'ROUND',
                            numer: currPomodoro,
                            denom: 4,
                          ),
                          VerticalDivider(
                            width: 10,
                            thickness: 2,
                            indent: 20,
                            endIndent: 20,
                            color: Theme.of(context).disabledColor,
                          ),
                          ProgressFraction(
                            title: 'GOAL',
                            numer: currPomodoro,
                            denom: 4,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

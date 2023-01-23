import 'dart:async';

import 'package:flutter/material.dart';

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
    return duration.toString().split(".").first.substring(2, 7);
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
              alignment: Alignment.bottomCenter,
              child: Text(
                formatSeconds(currSeconds),
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 80,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 100,
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pomodoros',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).textTheme.headline1!.color,
                          ),
                        ),
                        Text(
                          '$currPomodoro',
                          style: TextStyle(
                            fontSize: 58,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).textTheme.headline1!.color,
                          ),
                        ),
                      ],
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

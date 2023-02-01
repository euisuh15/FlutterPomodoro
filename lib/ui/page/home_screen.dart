import 'dart:async';
import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pomodoro/data/models/quote_model.dart';
import 'package:pomodoro/data/provider/apiService.dart';
import 'package:pomodoro/ui/widgets/ProgressFraction.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMin = 1500;
  int currSeconds = twentyFiveMin, currPomodoro = 0;
  bool isActive = false, start = false;
  late Timer timer;
  List<QuoteModel> workHardQuotes = [];

  void loadQuotes() async {
    workHardQuotes = await ApiService.getWorkHardQuote();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadQuotes();
  }

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
      start = true;
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
      workHardQuotes.shuffle();
    });
  }

  void onStopPressed() {
    timer.cancel();
    setState(() {
      isActive = false;
      start = false;
      currPomodoro = 0;
      currSeconds = twentyFiveMin;
      workHardQuotes.shuffle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 2,
        width: min(MediaQuery.of(context).size.width * 0.75, 250),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.horizontal(
            end: Radius.circular(50),
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.symmetric(
            vertical: 100,
            horizontal: 20,
          ),
          children: [
            ListTile(
              title: Text(
                'SETTINGS',
                style: TextStyle(
                  color: Theme.of(context).disabledColor,
                  fontWeight: FontWeight.w800,
                ),
              ),
              onTap: () {},
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              title: Text(
                'STATS',
                style: TextStyle(
                  color: Theme.of(context).disabledColor,
                  fontWeight: FontWeight.w800,
                ),
              ),
              onTap: () {},
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              title: Text(
                'ONBOARDING',
                style: TextStyle(
                  color: Theme.of(context).disabledColor,
                  fontWeight: FontWeight.w800,
                ),
              ),
              onTap: () {
                context.go('/onboarding');
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              title: Text(
                'CONTACT US',
                style: TextStyle(
                  color: Theme.of(context).disabledColor,
                  fontWeight: FontWeight.w800,
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0x00ffffff),
        elevation: 0,
        title: const Text(
          'POMODORO',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
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
                  fontSize: 75,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 4,
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 5,
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
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                      ),
                      child: Center(
                        child: isActive
                            ? AnimatedTextKit(
                                pause: const Duration(milliseconds: 5000),
                                animatedTexts: [
                                  for (var workHardQuote in workHardQuotes)
                                    TypewriterAnimatedText(
                                      workHardQuote.quote,
                                      textAlign: TextAlign.center,
                                      textStyle: TextStyle(
                                        color: Theme.of(context).disabledColor,
                                      ),
                                      speed: const Duration(milliseconds: 30),
                                    )
                                ],
                                repeatForever: true,
                              )
                            : Text(
                                start ? 'PAUSED' : 'START',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
                Center(
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
              ],
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
                      padding: const EdgeInsets.all(15),
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
                            indent: 15,
                            endIndent: 15,
                            color: Theme.of(context).disabledColor,
                          ),
                          ProgressFraction(
                            title: 'GOAL',
                            numer: currPomodoro,
                            denom: 15,
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

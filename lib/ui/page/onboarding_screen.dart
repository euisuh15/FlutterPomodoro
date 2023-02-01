import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IntroductionScreen(
            globalBackgroundColor: Theme.of(context).dividerColor,
            pages: [
              PageViewModel(
                titleWidget: Container(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Center(
                    child: Text(
                      "HOW TO USE",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 30,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                bodyWidget: SizedBox(
                  width: 250,
                  child: Center(
                    child: Text(
                      "Choose a task that you need to complete",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Theme.of(context).disabledColor,
                      ),
                    ),
                  ),
                ),
                image: Transform.translate(
                  offset: const Offset(0, -100),
                  child: SizedBox(
                    width: 350,
                    child: Image.asset('assets/UnboxingDoodle.png'),
                  ),
                ),
                reverse: true,
              ),
              PageViewModel(
                titleWidget: Container(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Center(
                    child: Text(
                      "JUST FOCUS",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 30,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                bodyWidget: SizedBox(
                  width: 250,
                  child: Center(
                    child: Text(
                      "Concentrate fully on your work",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Theme.of(context).disabledColor,
                      ),
                    ),
                  ),
                ),
                image: Transform.translate(
                  offset: const Offset(0, -100),
                  child: SizedBox(
                    width: 350,
                    child: Image.asset('assets/ReadingDoodle.png'),
                  ),
                ),
                reverse: true,
              ),
              PageViewModel(
                titleWidget: Container(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Center(
                    child: Text(
                      "TAKE A BREAK",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 30,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                bodyWidget: SizedBox(
                  width: 250,
                  child: Center(
                    child: Text(
                      "Regain your energy and take a short break",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Theme.of(context).disabledColor,
                      ),
                    ),
                  ),
                ),
                image: Transform.translate(
                  offset: const Offset(0, -100),
                  child: SizedBox(
                    width: 350,
                    child: Image.asset('assets/DancingDoodle.png'),
                  ),
                ),
                reverse: true,
              ),
            ],
            onDone: () {
              context.go('/');
            },
            showDoneButton: true,
            showNextButton: true,
            showSkipButton: true,
            done: Text(
              "Done",
              style: TextStyle(
                color: Theme.of(context).disabledColor,
              ),
            ),
            skip: Text(
              "Skip",
              style: TextStyle(
                color: Theme.of(context).disabledColor,
              ),
            ),
            next: Text(
              "Next",
              style: TextStyle(
                color: Theme.of(context).disabledColor,
              ),
            ),
            bodyPadding: const EdgeInsets.only(top: 120),
            controlsPosition: const Position(left: 0, right: 0, bottom: 160),
            dotsDecorator: DotsDecorator(
              size: const Size(10.0, 10.0),
              activeColor: Theme.of(context).primaryColor,
              color: Theme.of(context).disabledColor,
              activeSize: const Size(22.0, 10.0),
              activeShape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

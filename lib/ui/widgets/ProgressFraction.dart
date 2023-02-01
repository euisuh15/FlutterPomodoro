import 'package:flutter/material.dart';

class ProgressFraction extends StatelessWidget {
  const ProgressFraction({
    Key? key,
    required this.title,
    required this.numer,
    required this.denom,
  }) : super(key: key);

  final String title;
  final int numer, denom;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).disabledColor,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            '$numer',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).disabledColor,
            ),
          ),
          Transform.translate(
            offset: const Offset(30, -20),
            child: Text(
              '/  $denom',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).disabledColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

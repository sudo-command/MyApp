import 'dart:async';

import 'package:flutter/material.dart';

class ClockWidget extends StatefulWidget {
  @override
  _ClockWidgetState createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {
  String _currentTime = '';

  @override
  void initState() {
    super.initState();
    // Start the timer to update the current time every second
    _startTimer();
  }

  void _startTimer() {
    // Update the current time every second
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        final now = DateTime.now();
        final hour = _twoDigits(now.hour);
        final minute = _twoDigits(now.minute);
        final second = _twoDigits(now.second);

        _currentTime = '$hour:$minute:$second';
      });
    });
  }

  String _twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        _currentTime,
        style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

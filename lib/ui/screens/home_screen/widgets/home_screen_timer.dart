import 'dart:async';

import 'package:aether_project/core/theme/app_colors.dart';
import 'package:aether_project/model/world_boss_model/world_boss_model.dart';
import 'package:flutter/material.dart';

class HomeScreenTimer extends StatefulWidget {
  final WorldBossModel model;
  const HomeScreenTimer({super.key, required this.model});

  @override
  State<HomeScreenTimer> createState() => _HomeScreenTimerState();
}

class _HomeScreenTimerState extends State<HomeScreenTimer> {
  late Timer timer;
  late DateTime arrivalTime;
  late Duration difference;
  int _days = 0;
  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;

  int _lastSecond = -1;

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void didUpdateWidget(covariant HomeScreenTimer oldWidget) {
    timer.cancel();
    init();
    super.didUpdateWidget(oldWidget);
  }

  void init() {
    arrivalTime = widget.model.bossStartAt;
    final DateTime now = DateTime.now();
    difference = arrivalTime.difference(now);
    timer = Timer.periodic(const Duration(milliseconds: 100), _updateTime);
  }

  void _updateTime(Timer timer) {
    final DateTime now = DateTime.now();
    final Duration difference = arrivalTime.difference(now);
    if (_lastSecond == (difference.inSeconds % 60)) return;
    if (difference.isNegative) {
      _days = 0;
      _hours = 0;
      _minutes = 0;
      _seconds = 0;
      setState(() {});
      timer.cancel();
    } else {
      _days = difference.inDays;
      _hours = difference.inHours % 24;
      _minutes = difference.inMinutes % 60;
      _seconds = difference.inSeconds % 60;

      _lastSecond = difference.inSeconds % 60;

      setState(() {});
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints size) {
        final double width = (size.maxWidth / 4) - 30;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildTimeUnit(_days.toString(), 'DAYS', width),
            dot(),
            _buildTimeUnit(_hours.toString(), 'HRS', width),
            dot(),
            _buildTimeUnit(_minutes.toString(), 'MINS', width),
            dot(),
            _buildTimeUnit(_seconds.toString(), 'SECS', width),
          ],
        );
      },
    );
  }

  Widget dot() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15).copyWith(bottom: 20),
      child: const Column(
        spacing: 10,
        children: <Widget>[CircleAvatar(radius: 3), CircleAvatar(radius: 3)],
      ),
    );
  }

  Widget _buildTimeUnit(String time, String lablel, double width) {
    return Container(
      width: width,
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Text(
            time.padLeft(2, '0'),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.primaryColor,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),

          Text(
            lablel,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.primaryColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

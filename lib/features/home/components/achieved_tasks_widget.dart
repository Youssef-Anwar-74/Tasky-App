import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AchievedTasksWidget extends StatelessWidget {
  AchievedTasksWidget({
    super.key,
    required this.totalTasks,
    required this.totalDoneTasks,
    required this.percent,
  });

  int totalTasks = 0;

  int totalDoneTasks = 0;

  double percent = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Achieved Tasks",
                style: Theme.of(context).textTheme.titleMedium
              ),
              SizedBox(height: 4),
              Text(
                "$totalDoneTasks Out of $totalTasks Done",
                style: Theme.of(context).textTheme.titleSmall
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Transform.rotate(
                angle: -pi / 2,
                child: SizedBox(
                  height: 53,
                  width: 53,
                  child: CircularProgressIndicator(
                    value: percent,
                    backgroundColor: Color(0xFF6D6D6D),
                    valueColor: AlwaysStoppedAnimation(Color(0xFF15B86C)),
                    strokeWidth: 4,
                  ),
                ),
              ),
              Text(
                "${(percent * 100).toInt()}%",
                style: Theme.of(context).textTheme.titleMedium
                ),
            ],
          ),
        ],
      ),
    );
  }
}

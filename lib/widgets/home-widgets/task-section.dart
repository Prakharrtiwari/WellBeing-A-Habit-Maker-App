import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habitapp/widgets/home-widgets/task-card.dart';

import '../../core/themes/themes.dart';


class TaskSection extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  final VoidCallback onTaskComplete;

  const TaskSection({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.onTaskComplete,
  });

  @override
  State<TaskSection> createState() => _TaskSectionState();
}

class _TaskSectionState extends State<TaskSection> {
  final List<Map<String, dynamic>> tasks = [
    {
      'title': 'Morning Check-in',
      'completed': false,
      'icon': Icons.wb_sunny,
    },
    {
      'title': 'Evening Check-in',
      'completed': false,
      'icon': Icons.nightlight_round,
    },
    {
      'title': 'Morning Coaching Audio',
      'completed': false,
      'icon': Icons.headset,
    },
    {
      'title': 'Evening Coaching Audio',
      'completed': false,
      'icon': Icons.headset,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Daily Tasks',
          style: GoogleFonts.poppins(
            fontSize: widget.screenWidth * 0.05,
            fontWeight: FontWeight.w700,
            color: AppColors.charcoal,
            letterSpacing: 0.8,
          ),
        ),
        SizedBox(height: widget.screenHeight * 0.02),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: tasks.length,
          separatorBuilder: (context, index) => SizedBox(height: widget.screenHeight * 0.02),
          itemBuilder: (context, index) {
            final task = tasks[index];
            return TaskCard(
              screenWidth: widget.screenWidth,
              screenHeight: widget.screenHeight,
              title: task['title'],
              icon: task['icon'],
              completed: task['completed'],
              onTap: () {
                setState(() {
                  tasks[index]['completed'] = true;
                });
                widget.onTaskComplete();
              },
            );
          },
        ),
      ],
    );
  }
}
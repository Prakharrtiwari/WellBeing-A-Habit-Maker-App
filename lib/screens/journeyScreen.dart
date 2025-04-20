import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:confetti/confetti.dart';
import '../core/themes/themes.dart';
import '../widgets/journey-widgets/optioncard.dart';
import '../widgets/journey-widgets/stagecasd.dart';


class JourneyScreen extends StatefulWidget {
  const JourneyScreen({super.key});

  @override
  State<JourneyScreen> createState() => _JourneyScreenState();
}

class _JourneyScreenState extends State<JourneyScreen> {
  late ConfettiController _confettiController;

  // Define stages with explicit types
  final List<Map<String, dynamic>> stages = [
    {
      'title': 'Stage 1: Foundation',
      'timeline': '1 Week',
      'tasks': <Map<String, dynamic>>[
        {'title': 'Morning Meditation', 'subtitle': 'Practice 5-min meditation daily', 'icon': Icons.self_improvement, 'completed': false},
        {'title': 'Gratitude Journal', 'subtitle': 'Write 3 things you’re grateful for', 'icon': Icons.book, 'completed': false},
        {'title': 'Set Daily Goals', 'subtitle': 'Plan your day each morning', 'icon': Icons.checklist, 'completed': false},
        {'title': 'Hydration Check', 'subtitle': 'Drink 8 glasses of water daily', 'icon': Icons.local_drink, 'completed': false},
        {'title': 'Evening Reflection', 'subtitle': 'Reflect on your day’s achievements', 'icon': Icons.nightlight_round, 'completed': false},
      ],
      'isExpanded': true,
    },
    {
      'title': 'Stage 2: Growth',
      'timeline': '1 Month',
      'tasks': <Map<String, dynamic>>[
        {'title': 'Weekly Workout', 'subtitle': 'Exercise 3 times a week', 'icon': Icons.fitness_center, 'completed': false},
        {'title': 'Read a Book', 'subtitle': 'Read 1 self-help book', 'icon': Icons.book, 'completed': false},
        {'title': 'Mindfulness Practice', 'subtitle': '10-min mindfulness daily', 'icon': Icons.spa, 'completed': false},
        {'title': 'Connect with Friends', 'subtitle': 'Meet a friend weekly', 'icon': Icons.group, 'completed': false},
        {'title': 'Skill Development', 'subtitle': 'Learn a new skill', 'icon': Icons.school, 'completed': false},
        {'title': 'Sleep Routine', 'subtitle': 'Maintain 7-8 hours sleep', 'icon': Icons.bed, 'completed': false},
      ],
      'isExpanded': false,
    },
    {
      'title': 'Stage 3: Transformation',
      'timeline': '3 Months',
      'tasks': <Map<String, dynamic>>[
        {'title': 'Advanced Meditation', 'subtitle': '15-min meditation daily', 'icon': Icons.self_improvement, 'completed': false},
        {'title': 'Career Goal', 'subtitle': 'Set and track a career goal', 'icon': Icons.work, 'completed': false},
        {'title': 'Healthy Diet', 'subtitle': 'Follow a balanced diet plan', 'icon': Icons.restaurant, 'completed': false},
        {'title': 'Community Service', 'subtitle': 'Volunteer once a month', 'icon': Icons.volunteer_activism, 'completed': false},
        {'title': 'Financial Plan', 'subtitle': 'Create a savings plan', 'icon': Icons.account_balance, 'completed': false},
        {'title': 'Digital Detox', 'subtitle': '1 hour daily without screens', 'icon': Icons.phonelink_off, 'completed': false},
        {'title': 'Creative Hobby', 'subtitle': 'Start a creative project', 'icon': Icons.brush, 'completed': false},
      ],
      'isExpanded': false,
    },
    {
      'title': 'Stage 4: Mastery',
      'timeline': '6 Months',
      'tasks': <Map<String, dynamic>>[
        {'title': 'Leadership Skill', 'subtitle': 'Take a leadership course', 'icon': Icons.leaderboard, 'completed': false},
        {'title': 'Marathon Training', 'subtitle': 'Train for a 5K run', 'icon': Icons.directions_run, 'completed': false},
        {'title': 'Mentorship', 'subtitle': 'Mentor someone in your field', 'icon': Icons.people, 'completed': false},
        {'title': 'Advanced Journaling', 'subtitle': 'Write detailed reflections weekly', 'icon': Icons.book, 'completed': false},
        {'title': 'Networking', 'subtitle': 'Attend 2 networking events', 'icon': Icons.connect_without_contact, 'completed': false},
        {'title': 'Minimalism', 'subtitle': 'Declutter your space', 'icon': Icons.delete_sweep, 'completed': false},
        {'title': 'Public Speaking', 'subtitle': 'Give a public talk', 'icon': Icons.mic, 'completed': false},
        {'title': 'Yoga Practice', 'subtitle': 'Practice yoga twice weekly', 'icon': Icons.self_improvement, 'completed': false},
      ],
      'isExpanded': false,
    },
    {
      'title': 'Stage 5: Legacy',
      'timeline': '12 Months',
      'tasks': <Map<String, dynamic>>[
        {'title': 'Life Vision', 'subtitle': 'Create a 5-year life plan', 'icon': Icons.map, 'completed': false},
        {'title': 'Charity Project', 'subtitle': 'Start a charity initiative', 'icon': Icons.favorite, 'completed': false},
        {'title': 'Master Skill', 'subtitle': 'Achieve mastery in a skill', 'icon': Icons.star, 'completed': false},
        {'title': 'Family Time', 'subtitle': 'Plan monthly family activities', 'icon': Icons.family_restroom, 'completed': false},
        {'title': 'Travel Adventure', 'subtitle': 'Plan a meaningful trip', 'icon': Icons.flight, 'completed': false},
        {'title': 'Teach Others', 'subtitle': 'Share your knowledge', 'icon': Icons.school, 'completed': false},
        {'title': 'Legacy Project', 'subtitle': 'Start a legacy project', 'icon': Icons.lightbulb, 'completed': false},
        {'title': 'Financial Freedom', 'subtitle': 'Achieve a financial goal', 'icon': Icons.account_balance_wallet, 'completed': false},
        {'title': 'Wellness Routine', 'subtitle': 'Maintain a holistic routine', 'icon': Icons.health_and_safety, 'completed': false},
      ],
      'isExpanded': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  bool _isStageLocked(int stageIndex) {
    if (stageIndex == 0) return false; // Stage 1 is always unlocked
    final previousTasks = stages[stageIndex - 1]['tasks'] as List<Map<String, dynamic>>;
    return !previousTasks.every((task) => task['completed'] as bool);
  }

  double _getStageProgress(int stageIndex) {
    final tasks = stages[stageIndex]['tasks'] as List<Map<String, dynamic>>;
    final completedTasks = tasks.where((task) => task['completed'] as bool).length;
    return completedTasks / tasks.length;
  }

  bool _isStageCompleted(int stageIndex) {
    final tasks = stages[stageIndex]['tasks'] as List<Map<String, dynamic>>;
    return tasks.every((task) => task['completed'] as bool);
  }

  void _onTaskComplete(int stageIndex, int taskIndex) {
    setState(() {
      stages[stageIndex]['tasks'][taskIndex]['completed'] = true;
    });
    _confettiController.play();
    if (_isStageCompleted(stageIndex)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${stages[stageIndex]['title']} Completed! 🎉',
            style: GoogleFonts.poppins(color: AppColors.white),
          ),
          backgroundColor: AppColors.oliveGreen,
        ),
      );
    }
  }

  @override
  Widget build(context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.12),
        child: Container(
          width: screenWidth,
          height: screenHeight * 0.20,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: const Offset(0, 6),
                blurRadius: 10,
              ),
            ],
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.charcoal,
                AppColors.oliveGreen,
              ],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: -screenWidth * 0.3,
                top: -screenHeight * 0.1,
                child: Container(
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.3,
                  decoration: BoxDecoration(
                    color: AppColors.glassWhite,
                    borderRadius: const BorderRadius.all(Radius.elliptical(300, 200)),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                ),
              ),
              Positioned(
                left: screenWidth * 0.06,
                top: screenHeight * 0.08,
                child: Row(
                  children: [
                    Container(
                      width: screenWidth * 0.12,
                      height: screenWidth * 0.12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.explore,
                        color: AppColors.charcoal,
                        size: 28,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.03),
                    Text(
                      'Journey',
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    'Your Journey',
                    style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.w700,
                      color: AppColors.charcoal,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: stages.length,
                    itemBuilder: (context, stageIndex) {
                      final stage = stages[stageIndex];
                      final isLocked = _isStageLocked(stageIndex);
                      final isCompleted = _isStageCompleted(stageIndex);
                      final progress = _getStageProgress(stageIndex);

                      return Column(
                        children: [
                          StageCard(
                            screenWidth: screenWidth,
                            screenHeight: screenHeight,
                            title: stage['title'] as String,
                            timeline: stage['timeline'] as String,
                            isExpanded: stage['isExpanded'] as bool,
                            isLocked: isLocked,
                            isCompleted: isCompleted,
                            progress: progress,
                            onToggle: () {
                              if (!isLocked) {
                                setState(() {
                                  stage['isExpanded'] = !(stage['isExpanded'] as bool);
                                });
                              }
                            },
                          ),
                          if (stage['isExpanded'] as bool && !isLocked)
                            Column(
                              children: [
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: (stage['tasks'] as List).length,
                                  separatorBuilder: (context, index) => SizedBox(height: screenHeight * 0.02),
                                  itemBuilder: (context, taskIndex) {
                                    final task = (stage['tasks'] as List<Map<String, dynamic>>)[taskIndex];
                                    return OptionCard(
                                      screenWidth: screenWidth,
                                      screenHeight: screenHeight,
                                      title: task['title'] as String,
                                      subtitle: task['subtitle'] as String,
                                      icon: task['icon'] as IconData,
                                      gradientColors: [
                                        AppColors.oliveGreen,
                                        AppColors.lightOliveee,
                                      ],
                                      isCompleted: task['completed'] as bool,
                                      onTap: task['completed'] as bool
                                          ? () {}
                                          : () => _onTaskComplete(stageIndex, taskIndex),
                                    );
                                  },
                                ),
                                SizedBox(height: screenHeight * 0.05), // Added spacing after task cards
                              ],
                            ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              particleDrag: 0.05,
              emissionFrequency: 0.05,
              numberOfParticles: 50,
              gravity: 0.05,
              colors: const [
                Colors.red,
                Colors.blue,
                Colors.yellow,
                Colors.green,
                Colors.purple,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
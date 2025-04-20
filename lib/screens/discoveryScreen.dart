import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/themes/themes.dart';
import '../widgets/discovery-widget/custom-dialog.dart';

class DiscoveryScreen extends StatelessWidget {
  const DiscoveryScreen({super.key});

  // Mock leaderboard data
  final List<Map<String, dynamic>> leaderboard = const [
    {'name': 'Amit Sharma', 'points': 1200, 'rank': 1},
    {'name': 'Priya Singh', 'points': 1100, 'rank': 2},
    {'name': 'Rahul Patel', 'points': 1000, 'rank': 3},
    {'name': 'Sneha Verma', 'points': 900, 'rank': 4},
    {'name': 'Vikram Rao', 'points': 850, 'rank': 5},
  ];

  @override
  Widget build(BuildContext context) {
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
                        Icons.search,
                        color: AppColors.charcoal,
                        size: 28,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.03),
                    Text(
                      'Discovery',
                      style: AppTheme.theme.textTheme.headlineSmall?.copyWith(
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.02),
              _buildShareAppCard(context, screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.03),
              _buildRedeemPointsCard(context, screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.03),
              _buildSubscriptionStatusCard(context, screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.03),
              _buildUpgradePlanCard(context, screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.035),
              _buildLeaderboardSection(context, screenWidth, screenHeight),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShareAppCard(
      BuildContext context, double screenWidth, double screenHeight) {
    return _OptionCard(
      screenWidth: screenWidth,
      screenHeight: screenHeight,
      title: 'Share the App',
      subtitle: 'Invite friends and earn 50 reward points per referral',
      icon: Icons.share,
      gradientColors: [
        AppColors.goldenYellow,
        AppColors.lightGolden,
      ],
      onTap: () {
        Share.share(
          'Check out WellBeing! A great app for personal growth and emotional well-being. Download now: [Your App Link]',
          subject: 'Join WellBeing Today!',
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Shared! 50 points earned!')),
        );
      },
    );
  }

  Widget _buildRedeemPointsCard(
      BuildContext context, double screenWidth, double screenHeight) {
    return _OptionCard(
      screenWidth: screenWidth,
      screenHeight: screenHeight,
      title: 'Redeem Points',
      subtitle: 'Use 500 points to get 20% off on subscription renewal',
      icon: Icons.redeem,
      gradientColors: [
        AppColors.oliveGreen,
        AppColors.lightOlive,
      ],
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CustomDialog(
            screenWidth: screenWidth,
            title: 'Redeem Points',
            content: Text(
              'Would you like to redeem 500 points for a 20% discount on your next renewal?',
              style: AppTheme.theme.textTheme.bodyMedium?.copyWith(
                fontSize: screenWidth * 0.04,
                color: AppColors.grey,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: AppTheme.theme.textTheme.labelMedium?.copyWith(
                    fontSize: screenWidth * 0.04,
                    color: AppColors.grey,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Points redeemed! 20% discount applied!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.oliveGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                ),
                child: Text(
                  'Redeem',
                  style: AppTheme.theme.textTheme.labelMedium?.copyWith(
                    fontSize: screenWidth * 0.04,
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  Widget _buildSubscriptionStatusCard(
      BuildContext context, double screenWidth, double screenHeight) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Subscription details opened!')),
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(screenWidth * 0.045),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.white.withOpacity(0.95),
              AppColors.glassWhite.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
          border: Border.all(color: AppColors.glassWhite, width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Subscription Status',
              style: AppTheme.theme.textTheme.titleLarge?.copyWith(
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.w700,
                color: AppColors.charcoal,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.subscriptions,
                    color: Colors.black,
                    size: screenWidth * 0.06,
                  ),
                ),
                SizedBox(width: screenWidth * 0.04),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Basic Plan',
                        style: AppTheme.theme.textTheme.labelMedium?.copyWith(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.w600,
                          color: AppColors.charcoal,
                        ),
                      ),
                      Text(
                        'Expires: 2025-12-31',
                        style: AppTheme.theme.textTheme.bodySmall?.copyWith(
                          fontSize: screenWidth * 0.035,
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpgradePlanCard(
      BuildContext context, double screenWidth, double screenHeight) {
    return _OptionCard(
      screenWidth: screenWidth,
      screenHeight: screenHeight,
      title: 'Upgrade to Premium',
      subtitle: 'Unlock exclusive features with a paid plan',
      icon: Icons.upgrade,
      gradientColors: [
        AppColors.charcoal,
        AppColors.lightCharcoal,
      ],
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CustomDialog(
            screenWidth: screenWidth,
            title: 'Upgrade Plan',
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choose payment method:',
                  style: AppTheme.theme.textTheme.labelMedium?.copyWith(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w600,
                    color: AppColors.charcoal,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                ListTile(
                  leading: Icon(Icons.payment, color: AppColors.oliveGreen),
                  title: Text(
                    'Razorpay',
                    style: AppTheme.theme.textTheme.bodyMedium?.copyWith(
                      fontSize: screenWidth * 0.04,
                      color: AppColors.charcoal,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _simulatePayment(context, 'Razorpay', screenWidth);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.account_balance_wallet, color: AppColors.oliveGreen),
                  title: Text(
                    'UPI',
                    style: AppTheme.theme.textTheme.bodyMedium?.copyWith(
                      fontSize: screenWidth * 0.04,
                      color: AppColors.charcoal,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _simulatePayment(context, 'UPI', screenWidth);
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: AppTheme.theme.textTheme.labelMedium?.copyWith(
                    fontSize: screenWidth * 0.04,
                    color: AppColors.grey,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  void _simulatePayment(BuildContext context, String method, double screenWidth) {
    showDialog(
      context: context,
      builder: (context) => CustomDialog(
        screenWidth: screenWidth,
        title: 'Processing Payment',
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: AppColors.oliveGreen),
            SizedBox(height: screenWidth * 0.04),
            Text(
              'Simulating $method payment...',
              style: AppTheme.theme.textTheme.bodyMedium?.copyWith(
                fontSize: screenWidth * 0.04,
                color: AppColors.grey,
              ),
            ),
          ],
        ),
      ),
    );

    // Simulate payment processing
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context); // Close processing dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Payment successful via $method! Plan upgraded to Premium!',
            style: AppTheme.theme.textTheme.bodyMedium?.copyWith(
              fontSize: screenWidth * 0.04,
              color: AppColors.white,
            ),
          ),
          backgroundColor: AppColors.oliveGreen,
        ),
      );
    });
  }
  Widget _buildLeaderboardSection(
      BuildContext context, double screenWidth, double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Leaderboard',
          style: AppTheme.theme.textTheme.titleLarge?.copyWith(
            fontSize: screenWidth * 0.05,
            fontWeight: FontWeight.w700,
            color: AppColors.charcoal,
            letterSpacing: 0.8,
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        Container(
          padding: EdgeInsets.all(screenWidth * 0.045),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.white.withOpacity(0.95),
                AppColors.glassWhite.withOpacity(0.9),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
            border: Border.all(color: AppColors.glassWhite, width: 1.5),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: leaderboard.length,
            separatorBuilder: (context, index) => SizedBox(height: screenHeight * 0.02),
            itemBuilder: (context, index) {
              final entry = leaderboard[index];
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                child: Row(
                  children: [
                    Container(
                      width: screenWidth * 0.1,
                      height: screenWidth * 0.1,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: entry['rank'] == 1
                              ? [AppColors.goldenYellow, AppColors.lightGolden]
                              : entry['rank'] == 2
                              ? [AppColors.lightOlive, AppColors.oliveGreen]
                              : [AppColors.lightCharcoal, AppColors.charcoal],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          '${entry['rank']}',
                          style: AppTheme.theme.textTheme.labelMedium?.copyWith(
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.04),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry['name'],
                            style: AppTheme.theme.textTheme.labelMedium?.copyWith(
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.w600,
                              color: AppColors.charcoal,
                            ),
                          ),
                          Text(
                            '${entry['points']} Points',
                            style: AppTheme.theme.textTheme.bodySmall?.copyWith(
                              fontSize: screenWidth * 0.035,
                              color: AppColors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _OptionCard extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color> gradientColors;
  final VoidCallback onTap;

  const _OptionCard({
    required this.screenWidth,
    required this.screenHeight,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.gradientColors,
    required this.onTap,
  });

  @override
  _OptionCardState createState() => _OptionCardState();
}

class _OptionCardState extends State<_OptionCard> with SingleTickerProviderStateMixin {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
        HapticFeedback.lightImpact();
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
        widget.onTap();
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      borderRadius: BorderRadius.circular(20),
      child: AnimatedScale(
        scale: _isPressed ? 0.98 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          padding: EdgeInsets.all(widget.screenWidth * 0.045),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: widget.gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: widget.gradientColors[0].withOpacity(0.4),
                blurRadius: 14,
                offset: const Offset(0, 8),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
            border: Border.all(color: AppColors.glassWhite, width: 1.5),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(widget.screenWidth * 0.03),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Icon(
                  widget.icon,
                  color: Colors.black,
                  size: widget.screenWidth * 0.06,
                ),
              ),
              SizedBox(width: widget.screenWidth * 0.04),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: AppTheme.theme.textTheme.labelMedium?.copyWith(
                        fontSize: widget.screenWidth * 0.042,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: widget.screenHeight * 0.005),
                    Text(
                      widget.subtitle,
                      style: AppTheme.theme.textTheme.bodySmall?.copyWith(
                        fontSize: widget.screenWidth * 0.032,
                        fontWeight: FontWeight.w400,
                        color: AppColors.white.withOpacity(0.9),
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Icon(
                  Icons.arrow_forward_ios,
                  key: ValueKey(widget.title),
                  color: AppColors.white.withOpacity(0.9),
                  size: widget.screenWidth * 0.045,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
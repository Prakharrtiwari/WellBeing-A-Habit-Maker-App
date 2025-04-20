import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../core/themes/themes.dart';
import '../../modal/userModel.dart';
import '../../widgets/home-widgets/highlited_icon.dart';
import 'homeContentBody.dart';
import '../journeyScreen.dart';
import '../discoveryScreen.dart';
import '../alertsScreen.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeContent extends StatefulWidget {
  final User? user; // Custom User model
  const HomeContent({super.key, required this.user});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  int _selectedIndex = 0;

  // List of screens for each tab
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutQuad,
      ),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutQuad,
      ),
    );
    _animationController.forward();

    // Initialize screens for each tab
    _screens = [
      HomeContentBody(
        fadeAnimation: _fadeAnimation,
        animationController: _animationController,
        user: widget.user,
      ),
      const JourneyScreen(),
      const DiscoveryScreen(),
      const AlertsScreen(),
    ];
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: IndexedStack(
            index: _selectedIndex,
            children: _screens,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, -2),
              blurRadius: 8,
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
            child: GNav(
              backgroundColor: AppColors.white,
              color: AppColors.grey,
              activeColor: AppColors.charcoal,
              tabBackgroundColor: Colors.transparent,
              tabBorderRadius: 16,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              tabMargin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              gap: 6,
              selectedIndex: _selectedIndex,
              onTabChange: _onItemTapped,
              textStyle: GoogleFonts.poppins(
                fontSize: screenWidth * 0.035,
                fontWeight: FontWeight.w600,
                color: AppColors.charcoal,
              ),
              tabs: [
                GButton(
                  icon: Icons.home_outlined,
                  text: 'Home',
                  iconSize: _selectedIndex == 0 ? 28 : 26,
                  iconActiveColor: AppColors.charcoal,
                  iconColor: AppColors.grey,
                  leading: HighlightedIcon(
                    icon: Icons.home_outlined,
                    isSelected: _selectedIndex == 0,
                  ),
                ),
                GButton(
                  icon: Icons.explore_outlined,
                  text: 'Journey',
                  iconSize: _selectedIndex == 1 ? 28 : 26,
                  iconActiveColor: AppColors.charcoal,
                  iconColor: AppColors.grey,
                  leading: HighlightedIcon(
                    icon: Icons.explore_outlined,
                    isSelected: _selectedIndex == 1,
                  ),
                ),
                GButton(
                  icon: Icons.search_outlined,
                  text: 'Discovery',
                  iconSize: _selectedIndex == 2 ? 28 : 26,
                  iconActiveColor: AppColors.charcoal,
                  iconColor: AppColors.grey,
                  leading: HighlightedIcon(
                    icon: Icons.search_outlined,
                    isSelected: _selectedIndex == 2,
                  ),
                ),
                GButton(
                  icon: Icons.notifications_outlined,
                  text: 'Alerts',
                  iconSize: _selectedIndex == 3 ? 28 : 26,
                  iconActiveColor: AppColors.charcoal,
                  iconColor: AppColors.grey,
                  leading: HighlightedIcon(
                    icon: Icons.notifications_outlined,
                    isSelected: _selectedIndex == 3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../core/themes/themes.dart';
import '../widgets/onboardingScreen/textfield.dart';
import '../widgets/onboardingScreen/dropdown.dart';
import '../widgets/onboardingScreen/gradientButton.dart';
import '../widgets/discovery-widget/custom-dialog.dart';
import '../modal/userModel.dart'; // Custom User model

class OnboardingScreen extends StatefulWidget {
  final User? user; // Custom User model
  const OnboardingScreen({super.key, this.user});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with SingleTickerProviderStateMixin {
  final _formKeyPersonal = GlobalKey<FormState>();
  final _formKeyAcademic = GlobalKey<FormState>();
  final _formKeyCoaching = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _instituteController = TextEditingController();
  String? _examType;
  String? _nextAttempt;
  String? _classLevel;
  String? _coachingMode;
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // Helper function to validate dropdown values
  String? _getValidDropdownValue(String? value, List<String> items) {
    return value != null && items.contains(value) ? value : null;
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();

    // Pre-fill fields if user data exists
    if (widget.user != null) {
      _nameController.text = widget.user!.displayName ?? '';
      _mobileController.text = widget.user!.mobile ?? '';
      _instituteController.text = widget.user!.institute ?? '';
      // Validate dropdown values against their respective items
      _examType = _getValidDropdownValue(widget.user!.examType, ['NEET', 'JEE']);
      _nextAttempt = _getValidDropdownValue(widget.user!.nextAttempt, ['2026', '2027']);
      _classLevel = _getValidDropdownValue(widget.user!.classLevel, ['10', '11', '12', 'Repeater']);
      _coachingMode = _getValidDropdownValue(widget.user!.coachingMode, ['Online', 'Offline']);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _instituteController.dispose();
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage == 0 && _formKeyPersonal.currentState!.validate()) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentPage = 1;
      });
      _animationController.reset();
      _animationController.forward();
    } else if (_currentPage == 1 && _formKeyAcademic.currentState!.validate()) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentPage = 2;
      });
      _animationController.reset();
      _animationController.forward();
    }
  }

  Future<void> _storeUserData(User user) async {
    try {
      await _secureStorage.write(key: 'uid', value: user.uid ?? '');
      await _secureStorage.write(key: 'email', value: user.email ?? '');
      await _secureStorage.write(key: 'displayName', value: user.displayName ?? '');
      await _secureStorage.write(key: 'photoURL', value: user.photoURL ?? '');
      await _secureStorage.write(key: 'mobile', value: user.mobile ?? '');
      await _secureStorage.write(key: 'examType', value: user.examType ?? '');
      await _secureStorage.write(key: 'nextAttempt', value: user.nextAttempt ?? '');
      await _secureStorage.write(key: 'classLevel', value: user.classLevel ?? '');
      await _secureStorage.write(key: 'institute', value: user.institute ?? '');
      await _secureStorage.write(key: 'coachingMode', value: user.coachingMode ?? '');
    } catch (e) {
      print('❌ Error storing user data: $e');
    }
  }

  Future<void> _submitForm(BuildContext context, double screenWidth) async {
    if (_formKeyCoaching.currentState!.validate()) {
      final formData = {
        'name': _nameController.text,
        'mobile': _mobileController.text,
        'examType': _examType,
        'nextAttempt': _nextAttempt,
        'class': _classLevel,
        'institute': _instituteController.text,
        'coachingMode': _coachingMode,
      };

      // Combine existing user data with form data
      final combinedData = {
        'uid': widget.user?.uid,
        'email': widget.user?.email,
        'displayName': formData['name'],
        'mobile': formData['mobile'],
        'examType': formData['examType'],
        'nextAttempt': formData['nextAttempt'],
        'class': formData['class'],
        'institute': formData['institute'],
        'coachingMode': formData['coachingMode'],
        'photoURL': widget.user?.photoURL,
      };

      final user = User.fromMap(combinedData);
      print('Combined User Data: ${user.toMap()}');

      // Store user data in secure storage
      await _storeUserData(user);

      showDialog(
        context: context,
        builder: (context) => CustomDialog(
          screenWidth: screenWidth,
          title: 'Success',
          content: Text(
            'Your details have been submitted successfully!',
            style: AppTheme.theme.textTheme.bodyMedium?.copyWith(
              fontSize: screenWidth * 0.035,
              color: AppColors.grey,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                try {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/home',
                        (route) => false,
                    arguments: {'user': user},
                  );
                } catch (e) {
                  print('Navigation error: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Navigation error: $e')),
                  );
                }
              },
              child: Text(
                'OK',
                style: AppTheme.theme.textTheme.labelMedium?.copyWith(
                  fontSize: screenWidth * 0.035,
                  color: AppColors.grey,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all required fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.charcoal, AppColors.oliveGreen],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.06),
              Text(
                'Complete Your Profile',
                textAlign: TextAlign.center,
                style: AppTheme.theme.textTheme.headlineLarge?.copyWith(
                  fontSize: screenWidth * 0.06,
                  color: AppColors.white,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                'Tell us about yourself',
                textAlign: TextAlign.center,
                style: AppTheme.theme.textTheme.bodyMedium?.copyWith(
                  fontSize: screenWidth * 0.035,
                  color: AppColors.white.withOpacity(0.8),
                ),
              ),
              Expanded(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                      _animationController.reset();
                      _animationController.forward();
                    },
                    children: [
                      _buildPersonalInfoForm(screenWidth, screenHeight),
                      _buildAcademicInfoForm(screenWidth, screenHeight),
                      _buildCoachingInfoForm(screenWidth, screenHeight),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                      (index) => Container(
                    width: screenWidth * 0.02,
                    height: screenWidth * 0.02,
                    margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPage == index
                          ? AppColors.goldenYellow
                          : AppColors.white.withOpacity(0.4),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalInfoForm(double screenWidth, double screenHeight) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Container(
          padding: EdgeInsets.all(screenWidth * 0.05),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.white,
                AppColors.glassWhite.withOpacity(0.9),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: AppColors.charcoal.withOpacity(0.2),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Form(
            key: _formKeyPersonal,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  label: 'Full Name',
                  icon: Icons.person,
                  controller: _nameController,
                  validator: (value) => value!.isEmpty ? 'Full Name is required' : null,
                ),
                SizedBox(height: screenHeight * 0.015),
                CustomTextField(
                  label: 'Mobile Number',
                  icon: Icons.phone,
                  controller: _mobileController,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  validator: (value) {
                    if (value!.isEmpty) return 'Mobile Number is required';
                    if (value.length != 10) return 'Mobile Number must be 10 digits';
                    return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.02),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  transform: Matrix4.identity()..scale(1.0),
                  child: GradientButton(
                    label: 'Next',
                    onPressed: _nextPage,
                    gradientColors: [AppColors.oliveGreen, AppColors.goldenYellow],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAcademicInfoForm(double screenWidth, double screenHeight) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Container(
          padding: EdgeInsets.all(screenWidth * 0.05),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.white,
                AppColors.glassWhite.withOpacity(0.9),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: AppColors.charcoal.withOpacity(0.2),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Form(
            key: _formKeyAcademic,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomDropdown(
                  label: 'Exam Type',
                  icon: Icons.school,
                  value: _examType,
                  items: ['NEET', 'JEE'],
                  onChanged: (value) => setState(() => _examType = value),
                  validator: (value) => value == null ? 'Exam Type is required' : null,
                ),
                SizedBox(height: screenHeight * 0.015),
                CustomDropdown(
                  label: 'Next Attempt',
                  icon: Icons.calendar_today,
                  value: _nextAttempt,
                  items: ['2026', '2027'],
                  onChanged: (value) => setState(() => _nextAttempt = value),
                  validator: (value) => value == null ? 'Next Attempt is required' : null,
                ),
                SizedBox(height: screenHeight * 0.015),
                CustomDropdown(
                  label: 'Class',
                  icon: Icons.class_,
                  value: _classLevel,
                  items: ['10', '11', '12', 'Repeater'],
                  onChanged: (value) => setState(() => _classLevel = value),
                  validator: (value) => value == null ? 'Class is required' : null,
                ),
                SizedBox(height: screenHeight * 0.02),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  transform: Matrix4.identity()..scale(1.0),
                  child: GradientButton(
                    label: 'Next',
                    onPressed: _nextPage,
                    gradientColors: [AppColors.oliveGreen, AppColors.goldenYellow],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCoachingInfoForm(double screenWidth, double screenHeight) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Container(
          padding: EdgeInsets.all(screenWidth * 0.05),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.white,
                AppColors.glassWhite.withOpacity(0.9),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: AppColors.charcoal.withOpacity(0.2),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Form(
            key: _formKeyCoaching,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomDropdown(
                  label: 'Coaching Mode',
                  icon: Icons.computer,
                  value: _coachingMode,
                  items: ['Online', 'Offline'],
                  onChanged: (value) => setState(() => _coachingMode = value),
                  validator: (value) => value == null ? 'Coaching Mode is required' : null,
                ),
                SizedBox(height: screenHeight * 0.015),
                CustomTextField(
                  label: 'Coaching Institute Name',
                  icon: Icons.apartment,
                  controller: _instituteController,
                  validator: (value) => value!.isEmpty ? 'Coaching Institute Name is required' : null,
                ),
                SizedBox(height: screenHeight * 0.02),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  transform: Matrix4.identity()..scale(1.0),
                  child: GradientButton(
                    label: 'Submit',
                    onPressed: () => _submitForm(context, screenWidth),
                    gradientColors: [AppColors.oliveGreen, AppColors.goldenYellow],
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
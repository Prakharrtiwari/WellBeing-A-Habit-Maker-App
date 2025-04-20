# WellBeing: NEET/JEE Prep App

## Overview

WellBeing is a habit-forming mobile application designed for NEET and JEE aspirants to foster emotional and learning discipline through structured routines, gamified tracking, and positive reinforcement. Built using Flutter, the app integrates Firebase for authentication and secure storage, ensuring a seamless and personalized user experience. The app is locked to portrait mode to maintain a consistent UI across devices.

## Features

### (A) Onboarding Screen

- **Loading Screen**: Displays an motivational oath: *"I will be truthful to myself throughout journey and believe I am on right path and success is already on the way."*
- **Google Sign-In**: Users authenticate via Google Sign-In using Firebase Authentication.
- **User Profile Setup**: After sign-in, users provide:
  - Full Name
  - Mobile Number
  - Exam Type (NEET/JEE)
  - Next Attempt (2026/2027)
  - Class (10/11/12/Repeater)
  - Coaching Institute Name
  - Coaching Mode (Online/Offline)
- The onboarding process is split into three forms (Personal, Academic, Coaching) with a smooth page-view navigation and validation.

### (B) Homepage Tab

- **Components**:
  - **Current Stage**: Displays the user's current stage (e.g., Beginner) with a zap icon.
  - **Reward Points**: Shows total points earned with a coin icon (mock data: 250 points).
  - **Daily Streak**: Tracks consecutive active days with a fire icon (mock data: 7 days).
  - **Task Cards**: Includes:
    - Daily Morning and Evening Check-ins
    - Morning and Evening Coaching Audio (simulated)
    - Party popper animation (confetti) on task completion.
  - **Emotional Well-being**:
    - **Mood Meter**: Placeholder for tracking emotional state.
    - **EQ Lessons**: Placeholder for short emotional intelligence videos.

### (C) Journey Tab

- **Five Stages**: Structured with timelines and collapsible task cards:
  - **Stage 1: Foundation** (1 week, 5 tasks)
  - **Stage 2: Growth** (1 month, 6 tasks)
  - **Stage 3: Transformation** (3 months, 7 tasks)
  - **Stage 4: Mastery** (6 months, 8 tasks)
  - **Stage 5: Legacy** (12 months, 9 tasks)
- **Progress Tracking**: Each stage has a progress bar and tasks with toggleable completion status.
- **Gamification**:
  - Next stage is locked until the current stage is completed.
  - Confetti animation on task and stage completion.
  - Visual indicators for locked, completed, and in-progress stages.

### (D) Discovery Tab

- **Features**:
  - **Share the App**: Users can share a referral link and earn 50 mock reward points.
  - **Redeem Points**: Redeem 500 points for a 20% discount on subscription renewal (simulated).
  - **Subscription Status**: Displays mock plan details (e.g., Basic Plan, expires 2025-12-31).
  - **Upgrade Plan**: Simulated payment flow with dummy Razorpay and UPI options.
  - **Leaderboard**: Displays mock data with top 5 users, their points, and ranks.

### (E) Additional Features

- **Navigation**: Bottom navigation bar with Home, Journey, Discovery, and Alerts tabs (Alerts tab is a placeholder).
- **UI/UX**:
  - Responsive design with gradient backgrounds, glassmorphism effects, and Google Fonts (Poppins).
  - Smooth animations for transitions, confetti effects, and button interactions.
  - Haptic feedback on interactive elements for enhanced user experience.
- **Portrait Lock**: Ensures consistent UI by restricting orientation to portrait mode.

## Architecture

- **Framework**: Flutter (Dart)
- **State Management**: Stateful widgets with minimal reliance on external state management for simplicity.
- **Design Pattern**: Follows a modular structure inspired by MVVM principles:
  - **Models**: `User` model for handling user data.
  - **Views**: Widgets and screens for UI components.
  - **ViewModels/Services**: `AuthService` for authentication and secure storage operations.
- **Routing**: Custom `RouteGenerator` for dynamic route generation with slide transitions.
- **Data Storage**:
  - **Firebase Authentication**: For Google Sign-In.
  - **Flutter Secure Storage**: Stores user data locally for offline access.
- **Dependencies**:
  - `firebase_core`, `firebase_auth`: Firebase integration.
  - `google_sign_in`: Google Sign-In functionality.
  - `flutter_secure_storage`: Secure local storage.
  - `google_fonts`: For Poppins font.
  - `confetti`: For gamified animations.
  - `share_plus`: For app sharing.
  - `google_nav_bar`: For bottom navigation.

## Setup Instructions

1. **Prerequisites**:

   - Flutter SDK (version 3.16 or later)
   - Dart (version 3.2 or later)
   - Firebase project with Authentication enabled
   - Android/iOS emulator or physical device

2. **Clone the Repository**:

   ```bash
   git clone <repository-url>
   cd wellbeing
   ```

3. **Install Dependencies**:

   ```bash
   flutter pub get
   ```

4. **Configure Firebase**:

   - Create a Firebase project at Firebase Console.
   - Enable Google Sign-In in the Authentication section.
   - Download `google-services.json` (Android) or `GoogleService-Info.plist` (iOS) and place them in the respective platform directories.
   - Update `android/build.gradle` and `android/app/build.gradle` with Firebase dependencies as per the Firebase setup guide.

5. **Add Assets**:

   - Place the background image (`bg10.jpg`) and Google logo (`google.png`) in `lib/assets/images/`.

   - Update `pubspec.yaml` to include assets:

     ```yaml
     assets:
       - lib/assets/images/bg10.jpg
       - lib/assets/images/google.png
     ```

6. **Run the App**:

   ```bash
   flutter run
   ```

## Assumptions and Notes

- **Mock Data**: Reward points, daily streak, leaderboard, and subscription status use static mock data due to the absence of a backend.
- **Placeholder Screens**:
  - Alerts tab is a placeholder with minimal UI.
  - Mood Meter and EQ Lessons are implemented as tappable cards with snackbar feedback.
- **Simulated Features**:
  - Payment flows (Razorpay, UPI) are simulated with a 2-second delay and success feedback.
  - Coaching audio tasks are represented as tappable cards without actual audio integration.
- **Firebase Integration**: Assumes a Firebase project is set up with Google Sign-In enabled. No Firestore or Realtime Database is used; user data is stored locally.
- **Gamification**: Confetti animations and progress bars enhance the habit-forming experience, with locked stages to encourage sequential completion.
- **UI Design**: Emphasizes a modern, vibrant aesthetic with gradients, shadows, and glassmorphism for an engaging user experience.

## Code Quality

- **Clean Code**: Modularized widgets and services with clear naming conventions.
- **Comments**: Key functions and widgets include inline comments for clarity.
- **Error Handling**: Authentication and storage operations include try-catch blocks with user feedback via snackbars.
- **Scalability**: The app structure supports future additions like backend integration or additional tabs.

## Creativity and Product Thinking

- **Habit-Forming Design**: Gamified elements (confetti, progress bars, locked stages) motivate users to maintain daily engagement.
- **User-First Approach**: Intuitive onboarding, responsive UI, and haptic feedback prioritize user experience.
- **Emotional Well-being Focus**: Dedicated section for mood tracking and EQ lessons aligns with the app’s goal of fostering discipline and positivity.

## Known Limitations

- **Backend Absence**: No real-time data storage or user progress syncing due to reliance on local storage.
- **Placeholder Features**: Alerts tab, Mood Meter, and EQ Lessons are not fully functional.
- **Mock Payments**: Payment flows are simulated without actual payment gateway integration.
- **Single Platform**: Currently optimized for Android; iOS testing is pending.

## Future Enhancements

- Integrate Firestore for real-time user data and progress tracking.
- Implement actual audio playback for coaching tasks.
- Expand the Alerts tab with notifications and reminders.
- Add backend support for leaderboard and subscription management.
- Enhance Mood Meter and EQ Lessons with interactive UI and video content.
  
## Video(ScreenRecording)





https://github.com/user-attachments/assets/28a66329-1a55-434c-bbc5-16f427418367



---

*Built with passion for empowering NEET/JEE aspirants! 🚀*

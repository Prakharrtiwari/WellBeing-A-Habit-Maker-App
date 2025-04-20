WellBeing: NEET/JEE Prep App
Overview
WellBeing is a habit-forming mobile application designed for NEET and JEE aspirants to foster emotional and learning discipline through structured routines, gamified tracking, and positive reinforcement. Built using Flutter, the app integrates Firebase for authentication and secure storage, ensuring a seamless and personalized user experience. The app is locked to portrait mode for a consistent UI across devices.
Assumptions
The development of WellBeing is based on the following key assumptions to align with the provided requirements and constraints:

Authentication Flow:

Login vs. Register:
If a user selects the Login option and signs in with Google, the app assumes they have previously registered and completed the onboarding process. In this case, the onboarding screen (form for collecting user details) is skipped, and the user is directed to the HomeScreen after authentication.
If a user selects the Register option and signs up with Google, the app assumes they are a new user. After successful sign-up, the onboarding screen is displayed to collect user details (Full Name, Mobile Number, Exam Type, Next Attempt, Class, Coaching Institute Name, Coaching Mode).


Google Sign-In is the only authentication method, and Firebase Authentication handles user sessions securely.


Data Storage:

User data collected during onboarding is stored locally using flutter_secure_storage due to the absence of a backend. The app assumes local storage is sufficient for the assignment scope.
No real-time data syncing or backend database (e.g., Firestore) is implemented, as the assignment does not specify server-side requirements.


Mock Data:

Features like reward points (e.g., 250 points), daily streak (e.g., 7 days), leaderboard rankings, and subscription status (e.g., Basic Plan, expires 2025-12-31) use static mock data, assuming a backend is not required.
The leaderboard displays mock data for five users with predefined names, points, and ranks.


Feature Simulation:

Payment flows for upgrading to a premium plan (Razorpay, UPI) are simulated with a 2-second delay and a success message, assuming actual payment gateway integration is out of scope.
Coaching audio tasks (Morning and Evening) are represented as tappable cards without actual audio playback, assuming audio integration is not required.
Mood Meter and EQ Lessons in the Emotional Well-being section are implemented as placeholders with snackbar feedback on tap, assuming full functionality is not needed.


Gamification:

The app assumes that gamified elements like confetti animations, progress bars, and locked stages are sufficient to create a habit-forming experience.
Stages in the Journey tab are locked until the previous stage is fully completed, assuming this encourages sequential progress.


UI/UX:

The app assumes a modern, vibrant design with gradients, glassmorphism, and Google Fonts (Poppins) aligns with the goal of an intuitive and engaging user experience.
The Alerts tab is a placeholder with minimal UI, assuming it is not a core feature for the assignment.
Haptic feedback on interactive elements (e.g., buttons, task cards) is included to enhance user interaction, assuming it improves the user-first approach.


Platform:

The app is primarily optimized for Android, assuming iOS testing is not required for the assignment.
Portrait mode is enforced using SystemChrome.setPreferredOrientations to ensure a consistent UI, assuming landscape orientation is unnecessary.



Setup Instructions

Prerequisites:

Flutter SDK (version 3.16 or later)
Dart (version 3.2 or later)
Firebase project with Authentication enabled
Android emulator or physical device


Clone the Repository:
git clone <repository-url>
cd wellbeing


Install Dependencies:
flutter pub get


Configure Firebase:

Create a Firebase project at Firebase Console.
Enable Google Sign-In in the Authentication section.
Download google-services.json and place it in android/app/.
Update android/build.gradle and android/app/build.gradle with Firebase dependencies.


Add Assets:

Place bg10.jpg and google.png in lib/assets/images/.
Update pubspec.yaml:assets:
- lib/assets/images/bg10.jpg
- lib/assets/images/google.png




Run the App:
flutter run



Notes

The app skips the onboarding screen for logged-in users to streamline the experience for returning users, while new users (via Register) are prompted to complete the onboarding form to ensure all required data is collected.
The codebase is modular, with clear separation of concerns (widgets, services, models) to support future scalability.
Error handling is implemented for authentication and storage operations, with user feedback via snackbars.
The app prioritizes a user-first approach with gamified elements and responsive design to foster habit formation.


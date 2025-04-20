class User {
  final String? uid;
  final String? email;
  final String? displayName;
  final String? mobile;
  final String? examType;
  final String? nextAttempt;
  final String? classLevel;
  final String? institute;
  final String? coachingMode;
  final String? photoURL;

  User({
    this.uid,
    this.email,
    this.displayName,
    this.mobile,
    this.examType,
    this.nextAttempt,
    this.classLevel,
    this.institute,
    this.coachingMode,
    this.photoURL,
  });

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      uid: data['uid'],
      email: data['email'],
      displayName: data['displayName'],
      mobile: data['mobile'],
      examType: data['examType'],
      nextAttempt: data['nextAttempt'],
      classLevel: data['class'],
      institute: data['institute'],
      coachingMode: data['coachingMode'],
      photoURL: data['photoURL'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'mobile': mobile,
      'examType': examType,
      'nextAttempt': nextAttempt,
      'class': classLevel,
      'institute': institute,
      'coachingMode': coachingMode,
      'photoURL': photoURL,
    };
  }
}
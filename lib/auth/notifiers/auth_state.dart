import '../models/models.dart';

abstract class AuthState {
  AuthState copyWith();
}

class Authenticated extends AuthState {
  final User user;
  Authenticated(
    this.user,
  );

  @override
  AuthState copyWith({User? user}) {
    return Authenticated(user ?? this.user);
  }
}

class UnAuthenticated extends AuthState {
  @override
  AuthState copyWith() {
    return UnAuthenticated();
  }
}

class SignIn extends AuthState {
  @override
  AuthState copyWith() {
    return SignIn();
  }
}

class Registration extends AuthState {
  int? age;
  String? qualification;
  String? country;
  String? gender;
  String? discipline;
  Registration({
    String? qualification,
    String? country,
    String? gender,
    String? discipline,
  });
  @override
  AuthState copyWith({
    String? qualification,
    String? country,
    String? gender,
    String? discipline,
  }) {
    return Registration(
      qualification: qualification,
      country: country,
      gender: gender,
      discipline: discipline,
    );
  }
}

import '../models/scholarship.dart';

abstract class HomeState {
  HomeState copyWith();
}

class LoadingHome extends HomeState {
  @override
  HomeState copyWith() {
    return LoadingHome();
  }
}

class ReadyHome extends HomeState {
  final List<Scholarship> scholarships;

  ReadyHome(this.scholarships);

  @override
  HomeState copyWith({List<Scholarship>? scholarships}) {
    return ReadyHome(scholarships ?? this.scholarships);
  }
}

class ErrorHome extends HomeState {
  final String message;

  ErrorHome(this.message);
  @override
  HomeState copyWith({String? message}) {
    return ErrorHome(message ?? this.message);
  }
}

class Application extends HomeState {
  final Scholarship scholarship;

  Application(this.scholarship);
  @override
  HomeState copyWith({Scholarship? scholarship}) {
    return Application(scholarship ?? this.scholarship);
  }
}

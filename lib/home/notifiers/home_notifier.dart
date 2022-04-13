import 'dart:developer';
import 'package:dbms_project/home/models/models.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../auth/notifiers/notifiers.dart';
import '../repository/repository.dart';
import '../notifiers/notifiers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final homeStateNotifier = StateNotifierProvider<AuthHomeNotifier, HomeState>(
  (ref) => AuthHomeNotifier(ref),
);

class AuthHomeNotifier extends StateNotifier<HomeState> {
  AuthHomeNotifier(this.ref) : super(LoadingHome());
  final StateNotifierProviderRef ref;
  List<Scholarship> alreadyFetched = [];
  final _homeRepository = HomeRepository();
  Future<void> fetchData() async {
    try {
      final _authState = ref.read(authStateNotifier.notifier).state;
      if (_authState is Authenticated) {
        final query =
            await _homeRepository.fetchAllScholarships(_authState.user);
        final applied = await _homeRepository.alreadyApplied(_authState.user);
        for (int i = 0; i < query.length; i++) {
          bool got = false;
          for (Scholarship element in applied) {
            if (element.schid == query[i].schid) {
              got = true;
              break;
            }
          }
          if (got) {
            print("Changes");
            query[i].applied = true;
          }
        }
        log(query.length.toString());
        state = ReadyHome(query);
        return;
      }
      state = ErrorHome("Error in fetching data");
    } catch (e) {
      state = ErrorHome("Error in fetching data");
    }
  }

  void applyFilters() {
    final currState = state as ReadyHome;
    state = currState.copyWith();
  }

  void retry() async {
    log("Retrying");
    state = LoadingHome();
  }

  void goToApply(Scholarship scholarship) {
    alreadyFetched = (state as ReadyHome).scholarships;
    state = Application(scholarship);
  }

  void backToHome() {
    state = ReadyHome(alreadyFetched);
  }

  void apply(int index) async {
    final currState = state as ReadyHome;

    final res = await _homeRepository.apply(
      (ref.read(authStateNotifier) as Authenticated).user.sid,
      currState.scholarships[index].schid,
    );
    if (res) {
      state = ReadyHome(currState.scholarships);
      currState.scholarships[index].applied = true;
      return;
    }
    Fluttertoast.showToast(msg: "Some error occured");
  }
}

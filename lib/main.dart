import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'auth/notifiers/notifiers.dart';
import 'auth/pages/pages.dart';
import 'home/pages/pages.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Main(),
      ),
    ),
  );
}


class Main extends ConsumerWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authStateNotifier);
    log(state.runtimeType.toString());
    if (state is Authenticated) {
      return const HomePage();
    } else if (state is SignIn || state is UnAuthenticated) {
      return const SignInPage();
    } else if (state is Registration) {
      return const Register();
    } else {
      throw Error();
    }
  }
}

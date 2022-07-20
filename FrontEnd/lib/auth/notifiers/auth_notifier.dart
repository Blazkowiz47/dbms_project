import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/models.dart';
import '../notifiers/notifiers.dart';
import '../repository/repository.dart';

final authStateNotifier = StateNotifierProvider<AuthHomeNotifier, AuthState>(
  (ref) => AuthHomeNotifier(ref),
);

class AuthHomeNotifier extends StateNotifier<AuthState> {
  AuthHomeNotifier(this.read) : super(UnAuthenticated());
  final StateNotifierProviderRef read;
  final _authRepository = AuthRepository();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final discController = TextEditingController();
  final qualController = TextEditingController();
  final genController = TextEditingController();
  final countryController = TextEditingController();

  void setUserDetails({
    String? qualification,
    String? country,
    String? gender,
    String? discipline,
  }) {
    final currState = (state as Registration);
    print(currState.qualification);
    print(currState.country);
    print(currState.gender);
    print(currState.discipline);
    print("Setting state");
    state = currState.copyWith(
      qualification: qualification,
      country: country,
      gender: gender,
      discipline: discipline,
    );
  }

  Future<bool> login() async {
    final email = emailController.text;
    final password = passController.text;
    if (!email.contains("@") || !email.contains(".")) {
      return false;
    }
    if (password.length < 6) {
      return false;
    }
    try {
      final user = await _authRepository.login(email, password);
      state = Authenticated(user);

      return true;
    } catch (e) {
      log("Error in log in");
    }
    return false;
  }

  Future<bool> register() async {
    if (phoneController.text.trim().length != 10) {
      Fluttertoast.showToast(msg: "Enter valid phone number");
      return false;
    }
    if (passController.text.trim().length < 6) {
      Fluttertoast.showToast(msg: "Enter valid password");
      return false;
    }
    if (nameController.text.trim().isEmpty) {
      Fluttertoast.showToast(msg: "Enter valid name");
      return false;
    }

    if (!emailController.text.contains('@') ||
        !emailController.text.contains('.')) {
      Fluttertoast.showToast(msg: "Enter valid email");
      return false;
    }
    final currState = state as Registration;
    if (qualController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter qualification");
      return false;
    }
    if (countryController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter country");
      return false;
    }
    if (discController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter discipline");
      return false;
    }
    if (genController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter gender");
      return false;
    }

    try {
      User user = User(
        sid: -1,
        email: emailController.text
            .trim()
            .substring(0, (emailController.text.trim().length % 255)),
        gender: genController.text.trim(),
        discipline: discController.text.trim(),
        nationality: countryController.text.trim(),
        qualification: qualController.text.trim(),
        name: nameController.text
            .trim()
            .substring(0, (nameController.text.trim().length % 255)),
        address: addressController.text
            .trim()
            .substring(0, (addressController.text.trim().length % 255)),
        phone: phoneController.text.trim(),
        age: int.parse(ageController.text.trim()),
      );
      final response =
          await _authRepository.register(user, passController.text.trim());
      user.sid = response;
      state = Authenticated(user);
    } catch (e) {
      log("Error in registering");
    }
    Fluttertoast.showToast(msg: "Some Error occured");
    return false;
  }

  void gotoRegister() {
    state = Registration();
  }

  void gotoSignIn() {
    state = SignIn();
  }
}

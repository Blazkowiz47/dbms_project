import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '/utils/utils.dart';

import '../models/models.dart';

class AuthRepository extends NetworkService {
  Future<User> login(String email, String password) async {
    log("Trying to log in : $email $password");
    Response response = await dio.get(
      url + '/checkUser',
      queryParameters: {
        'email': email.trim(),
        'pass': password.trim(),
      },
    );

    if (response.data == null) {
      Fluttertoast.showToast(msg: "User Not Registered");
      throw Exception("User Not Registered");
    }

    response = await dio.get(
      url + '/login',
      queryParameters: {
        'sid': response.data['sid'],
      },
    );
    // log(response.data.toString());
    final Map data = response.data;
    // return User();
    // return response.data;
    return User(
      sid: data['sid'],
      email: email,
      gender: data['gender'],
      discipline: data['discipline'],
      nationality: data['nationality'],
      qualification: data['qualification'],
      name: data['name'],
      address: data['address'],
      phone: data['phone'],
      age: data['age'] as int,
    );
  }

  Future<int> register(User user, String password) async {
    Response response = await dio.get(
      url + '/checkEmail',
      queryParameters: {
        'email': user.email,
      },
    );
    log("hfiuklwe");
    log(response.data.runtimeType.toString());

    if (response.data.toString().isNotEmpty) {
      Fluttertoast.showToast(msg: "User Already Exist");
      throw Exception("User Already Exist");
    }

    response = await dio.post(
      url + '/register',
      queryParameters: {
        'email': user.email,
        'pass': password,
        'name': user.name,
        'addr': user.address,
        'phone': user.phone,
        'gen': user.gender,
        'disc': user.discipline,
        'qual': user.qualification,
        'country': user.nationality,
        'age': user.age,
      },
    );

    if (response.statusMessage != 'OK') {
      throw Error();
    }

    response = await dio.get(
      url + '/checkUser',
      queryParameters: {
        'email': user.email,
        'pass': password,
      },
    );

    if (response.data == null) {
      throw Error();
    }
    log(response.data.toString());
    return response.data['sid'] as int;
  }
}

import 'dart:developer';

import 'package:dbms_project/utils/utils.dart';
import 'package:dio/dio.dart';

import '../models/models.dart';
import '../../auth/models/models.dart';

class HomeRepository extends NetworkService {
  Future<List<Scholarship>> fetchAllScholarships(User user) async {
    Response response = await dio.get(
      url + '/scholarships',
      queryParameters: {'sid': user.sid},
    );
    if (response.data.length == 0) return [];
    List<Scholarship> result = [];
     print(response.data);
    for (var e in response.data) {
      result.add(Scholarship(
        schid: e['schid'],
        uniId: e['uniID'],
        schDuration: e['schDuration'],
        season: e['season'],
        funding: e['Funding'],
        gender: e['Gender'],
        maxAge: e['maxAge'],
        eligibility: e['Eligibility'],
        country: e['country'],
        discipline: e['discipline'],
        applied: false,
      ));
    }
    return result;
  }

  Future<List<Scholarship>> alreadyApplied(User user) async {
    Response response = await dio.get(
      url + '/getAppliedScholarships',
      queryParameters: {'sid': user.sid},
    );

    if (response.data.length == 0) return [];
    List<Scholarship> result = [];
   
    for (var e in response.data) {
      result.add(Scholarship(
        schid: e['schID'],
        uniId: e['uniId'],
        schDuration: e['schDuration'],
        season: e['season'],
        funding: e['funding'],
        gender: e['gender'],
        maxAge: e['maxAge'],
        eligibility: e['Eligibility'],
        country: e['country'],
        discipline: e['discipline'],
        applied: false,
      ));
    }
    return result;
  }

  Future<bool> apply(int sid, int schid) async {
    Response response = await dio.post(
      url + '/apply',
      queryParameters: {'sid': sid, 'schid': schid},
    );

    if (response.data != null && response.data['success']) return true;
    return false;
  }
}

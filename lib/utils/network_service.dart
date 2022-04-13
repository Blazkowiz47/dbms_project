import 'package:dio/dio.dart';

abstract class NetworkService {
  final dio = Dio();
  final String url = "https://scholarship-dbs.herokuapp.com";
}

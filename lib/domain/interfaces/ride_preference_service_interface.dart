import 'package:dio/dio.dart';

abstract class IRidePreferenceService {
  Future<Response> getPreference();
}

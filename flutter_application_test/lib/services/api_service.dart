import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  static const String baseUrl = 'https://api.example.com';

  Future<dynamic> fetchData() async {
    try {
      final response = await _dio.get('$baseUrl/data');
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('API request failed with status code ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to fetch data: $error');
    }
  }

  Future<void> sendData(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('$baseUrl/data', data: data);
      if (response.statusCode == 201) {

      } else {
        throw Exception('API request failed with status code ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to send data: $error');
    }
  }
}

abstract class BaseService {
  final String baseUrl = "http://10.0.2.2:8000";

  Future<dynamic> getResponse(String url);
  Future<dynamic> postRequest(String url, Map<String, dynamic> body);
}
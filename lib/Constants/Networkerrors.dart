import 'dart:convert';

NetworkError(dynamic response) {
  switch (response.statusCode) {
    case 404:
      throw Exception(jsonDecode(response.body)['message']);
    case 500:
      throw Exception("internal errors");
    default:
      throw Exception(" something went wrong");
  }
}

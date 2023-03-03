import 'dart:convert';
import 'package:first_project_fetch_api/models/Operation.dart';
import 'package:first_project_fetch_api/models/response_dto.dart';
import 'package:http/http.dart' as http;

Future<ResponseDto> fetchOperation(String walletRef) async {
  final response = await http
      .get(Uri.parse('http://172.16.11.216:8090/api/v1/operation/operation-of-client/p1234/wallet-ref/'+walletRef));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return ResponseDto.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Operation');
  }
}

Future<ResponseDto> addOperation(Operation operation) async {
  Map data = {
    'amount': operation.amount,
    'walletRef': operation.walletRef,
    'operationType': operation.operationType,
  };
  final response = await http
      .post(Uri.parse('http://172.16.11.216:8090/api/v1/operation/add/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return ResponseDto.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Operation');
  }
}


import 'dart:convert';
import '../models/wallet.dart';
import 'package:http/http.dart' as http;

Future<List<Wallet>> fetchWallet() async {
  final response = await http
      .get(Uri.parse('http://172.16.11.216:8088/api/v1/wallet/wallet-client/p1234'));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    Iterable l = json.decode(response.body);
    List<Wallet> wallets = List<Wallet>.from(l.map((model)=> Wallet.fromJson(model)));
    return wallets;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }

}
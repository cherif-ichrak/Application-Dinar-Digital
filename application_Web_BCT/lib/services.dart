import 'dart:convert';

import 'package:bct_web/walletResponse.dart';
import 'package:http/http.dart' as http;

abstract class RepostiroyApi {
  static Future<void> mint(String id, int amount) async {
    var uri = Uri.parse("http://3.67.91.37:3000/api/mint/admin_BCT");
    var response = await http.post(uri,
        body: jsonEncode({'amount': amount}),
        headers: {'Content-Type': 'application/json'});
    print(response.body);
    return Future.value();
  }

  static Future<String> register(String id) async {
    var uri = Uri.parse('http://3.67.91.37:3000/api/clients/register');

    var response = await http.post(uri,
        body: jsonEncode({"userId": id}),
        headers: {"Content-Type": "application/json"});
    print(response.body);
    return jsonDecode(response.body)["status"];
  }

  // static Future<String> login(String id) async {
  //   // Future.delayed(Duration(seconds: 1));
  //   return id;
  // }
  static Future<String> verifyLogin(String id) async {
    var uri = Uri.parse('http://3.67.91.37:3000/api/soldeWallet/$id');

    var response =
        await http.get(uri, headers: {"Content-Type": "application/json"});
    print(response.body);
    return jsonDecode(response.body)["message"].toString();
  }

  static Future<String> getSolde(String id) async {
    var uri = Uri.parse('http://3.67.91.37:3000/api/soldeWallet/$id');

    var response =
        await http.get(uri, headers: {"Content-Type": "application/json"});
    print(response.body);
    return jsonDecode(response.body)["SoldeWallet"].toString();
  }

  static Future<WalletResponse> getUtxo(String id) async {
    var uri = Uri.parse('http://3.67.91.37:3000/api/trieUtxo/$id');

    var response =
        await http.get(uri, headers: {"Content-Type": "application/json"});
    print(response.body);

    return WalletResponse.fromJson(jsonDecode(response.body));
  }

  static Future<String> transferUtxo(
      String id_s, String id_r, int amount) async {
    var uri = Uri.parse('http://3.67.91.37:3000/api/clients/transfer');

    var response = await http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"sender": id_s, "receiver": id_r, "amount": amount}));
    print(response.body);
    return response.body;
  }
}

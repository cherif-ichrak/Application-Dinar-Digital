import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pfe_wallet/walletResponse.dart';

abstract class RepostiroyApi {
  static Future<String> register(String id) async {
    print("++++++++++ register" + id);

    var suffixStart = id.indexOf('_');
    var bankName = id.substring(suffixStart + 1, id.length);

    var uri = Uri.parse('http://3.67.91.37:3000/api/clients/register');
    if (bankName == "STB")
      uri = Uri.parse('http://3.67.91.37:3000/api/clients/register');
    else
      uri = Uri.parse('http://3.67.91.37:4000/api/clients/register');

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
    print("++++++++++ verifyLogin" + id);

    var suffixStart = id.indexOf('_');
    var bankName = id.substring(suffixStart + 1, id.length);

    var uri = Uri.parse('http://3.67.91.37:3000/api/soldeWallet/$id');
    if (bankName == "STB")
      uri = Uri.parse('http://3.67.91.37:3000/api/soldeWallet/$id');
    else
      uri = Uri.parse('http://3.67.91.37:4000/api/soldeWallet/$id');

    var response =
        await http.get(uri, headers: {"Content-Type": "application/json"});
    print(response.body);
    return jsonDecode(response.body)["message"].toString();
  }

  static Future<String> getSolde(String id) async {
    print("++++++++++ getSolde" + id);

    var suffixStart = id.indexOf('_');
    var bankName = id.substring(suffixStart + 1, id.length);

    var uri = Uri.parse('http://3.67.91.37:3000/api/soldeWallet/$id');
    if (bankName == "STB")
      uri = Uri.parse('http://3.67.91.37:3000/api/soldeWallet/$id');
    else
      uri = Uri.parse('http://3.67.91.37:4000/api/soldeWallet/$id');

    var response =
        await http.get(uri, headers: {"Content-Type": "application/json"});
    print(response.body);
    return jsonDecode(response.body)["SoldeWallet"].toString();
  }

  static Future<String> getWalletAdress(String id) async {
    print("++++++++++ getWalletAdress" + id);

    var suffixStart = id.indexOf('_');
    var bankName = id.substring(suffixStart + 1, id.length);

    var uri = Uri.parse('http://3.67.91.37:3000/api/clients/$id');
    if (bankName == "STB")
      uri = Uri.parse('http://3.67.91.37:3000/api/clients/$id');
    else
      uri = Uri.parse('http://3.67.91.37:4000/api/clients/$id');

    var response =
        await http.get(uri, headers: {"Content-Type": "application/json"});
    print(response.body);
    return jsonDecode(response.body)["message"].toString();
  }

  static Future<WalletResponse> getUtxo(String id) async {
    print("++++++++++ getUtxo" + id);

    var suffixStart = id.indexOf('_');
    var bankName = id.substring(suffixStart + 1, id.length);

    var uri = Uri.parse('http://3.67.91.37:3000/api/trieUtxo/$id');
    if (bankName == "STB")
      uri = Uri.parse('http://3.67.91.37:3000/api/trieUtxo/$id');
    else
      uri = Uri.parse('http://3.67.91.37:4000/api/trieUtxo/$id');

    var response =
        await http.get(uri, headers: {"Content-Type": "application/json"});
    print(response.body);

    return WalletResponse.fromJson(jsonDecode(response.body));
  }

  static Future<String> transferUtxo(String id, String id_r, int amount) async {
    var suffixStart = id.indexOf('_');
    var bankName = id.substring(suffixStart + 1, id.length);

    print("++++++++++ transferUtxo" + id);

    var uri = Uri.parse('http://3.67.91.37:3000/api/clients/transfer');
    if (bankName == "STB")
      uri = Uri.parse('http://3.67.91.37:3000/api/clients/transfer');
    else
      uri = Uri.parse('http://3.67.91.37:4000/api/clients/transfer');

    var response = await http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"sender": id, "receiver": id_r, "amount": amount}));

    return response.body;
  }
}

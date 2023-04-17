// To parse this JSON data, do
//
//     final walletResponse = walletResponseFromJson(jsonString);

import 'dart:convert';

WalletResponse walletResponseFromJson(String str) =>
    WalletResponse.fromJson(json.decode(str));

String walletResponseToJson(WalletResponse data) => json.encode(data.toJson());

class WalletResponse {
  WalletResponse({
    this.status,
    this.message,
  });

  String? status;
  List<Message>? message;

  factory WalletResponse.fromJson(Map<String, dynamic> json) => WalletResponse(
        status: json["status"],
        message: json["message"] == "Unexpected end of JSON input"
            ? []
            : List<Message>.from(
                json["message"].map((x) => Message.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": List<dynamic>.from(message!.map((x) => x.toJson())),
      };
}

class Message {
  Message({
    this.utxoKey,
    this.owner,
    this.amount,
  });

  String? utxoKey;
  String? owner;
  int? amount;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        utxoKey: json["utxo_key"],
        owner: json["owner"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "utxo_key": utxoKey,
        "owner": owner,
        "amount": amount,
      };
}

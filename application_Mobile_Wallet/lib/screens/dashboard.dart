//import 'dart:ffi';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfe_wallet/main.dart';
import 'package:pfe_wallet/screens/values.dart';
import 'package:pfe_wallet/walletResponse.dart';

import '../services.dart';
import 'constants.dart';

class Dashboard extends StatefulWidget {
  final String? userId;

  const Dashboard({Key? key, this.userId}) : super(key: key);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String? solde = "";
  String? walletAddress = "";

  WalletResponse? utxos = new WalletResponse();

  FocusNode _moneyNode = new FocusNode();

  TextEditingController _moneyController = TextEditingController();

  PageController _pageController = PageController();

  bool loading = false;

  TextEditingController _receiverController = TextEditingController();
  @override
  void initState() {
    setState(() {});
    fetchSolde();
    fetchUtxos();
    print("debug dashboard");

    // TODO: implement initState
    super.initState();
  }

  fetchSolde() async {
    solde = await RepostiroyApi.getSolde(widget.userId!);
    walletAddress = await RepostiroyApi.getWalletAdress(widget.userId!);
  }

  fetchUtxos() async {
    loading = true;
    utxos = await RepostiroyApi.getUtxo(widget.userId!);
    loading = false;

    setState(() {});
  }

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0, 35, 100],
            colors: [Color(0xff020024), Color(0xff090979), Color(0xff0029ff)]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: buildBoxDecoration(),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              children: [
                AppBar(
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  actions: [
                    IconButton(
                        onPressed: () => Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) =>
                                    MyHomePage(title: "test"))),
                        icon: Icon(Icons.exit_to_app_rounded))
                  ],
                  leading: Container(),
                  title: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: "Welcome ",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      TextSpan(
                        text: "${widget.userId} \t👋",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )
                    ]),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  height: 80,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(colors: [
                        Color(0xffa000ff),
                        Color(0xff0099ff),
                        Color(0xffa000ff),
                      ], stops: [
                        0.00,
                        20.00,
                        70.00
                      ])),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                          text: "Balance ",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      TextSpan(
                        text: "${solde == 'null' ? '0' : solde} DD\n",
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: "DD = Dinar Digital\n",
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.w300),
                      ),
                      /*TextSpan(
                        text: "DD = Dinar Digital",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w300),
                      ), */
                      TextSpan(
                        text: "Your Id  ${walletAddress}",
                        style: TextStyle(
                            fontSize: 6,
                            color: Colors.white,
                            fontWeight: FontWeight.w300),
                      )
                    ]),
                  ),
                ),
                (loading == true)
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Expanded(
                        child: RefreshIndicator(
                          onRefresh: () {
                            fetchSolde();
                            fetchUtxos();
                            return Future.value(true);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 78.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10),
                                  child: Text(
                                    "tokens DD",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: utxos?.message?.length ?? 0,
                                      itemBuilder: (context, i) {
                                        return (utxos == null)
                                            ? CircularProgressIndicator()
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      boxShadow: [],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16)),
                                                  child: ListTile(
                                                    trailing: Text(
                                                      utxos!.message![i].amount
                                                              .toString() +
                                                          '\tDD',
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          color: Colors.white
                                                              .withOpacity(0.8),
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    leading: CircleAvatar(
                                                      backgroundColor:
                                                          Colors.white24,
                                                      child: Image.asset(
                                                        'assets/coin.png',
                                                        width: 150,
                                                        height: 150,
                                                        fit: BoxFit.contain,
                                                      ),
                                                      // backgroundImage:
                                                      //     Image.asset(
                                                      //   'assets/coin.png',
                                                      //   fit: BoxFit.fill,
                                                      // ).image,
                                                    ),
                                                    title: Text(
                                                      "@${widget.userId}",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    subtitle: Text(
                                                      "${utxos!.message![i].utxoKey!.substring(0, 20).toString()}",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              );
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
              ],
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.black45,
                    gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        stops: [0, 100],
                        colors: [Color(0xff092a79), Color(0xff5700ff)])),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MaterialButton(
                        height: 40,
                        elevation: 10,
                        shape: StadiumBorder(),
                        color: Colors.blueAccent,
                        onPressed: () => print("test"),
                        child: Text(
                          "To receive",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                    // Spacer(),
                    MaterialButton(
                        height: 40,
                        elevation: 10,
                        shape: StadiumBorder(),
                        color: Colors.blueAccent,
                        onPressed: () async {
                          var result = await showModalBottomSheet(
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              context: context,
                              builder: (context) {
                                return SafeArea(
                                  child: Scaffold(
                                    extendBodyBehindAppBar: true,
                                    extendBody: true,
                                    body: Container(
                                      alignment: Alignment.center,
                                      padding:
                                          MediaQuery.of(context).viewInsets,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                            Color(0xff092a79),
                                            Color(0xff5700ff)
                                          ]),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15),
                                          )),
                                      child: Column(
                                        children: [
                                          AppBar(
                                            elevation: 0,
                                            backgroundColor: Colors.transparent,
                                          ),
                                          Expanded(
                                            child: PageView.builder(
                                                controller: _pageController,
                                                itemBuilder: (context, i) {
                                                  return i == 0
                                                      ? Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(16.0),
                                                          child:
                                                              SingleChildScrollView(
                                                            child: Column(
                                                              children: [
                                                                Text(
                                                                  "Enter the amount",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          32,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top:
                                                                          18.0),
                                                                  child:
                                                                      TextField(
                                                                    controller:
                                                                        _moneyController,
                                                                    focusNode:
                                                                        _moneyNode,
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .number,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            30,
                                                                        color: Colors
                                                                            .white),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    decoration: InputDecoration(
                                                                        hintStyle: TextStyle(
                                                                            fontSize:
                                                                                20,
                                                                            color: Colors
                                                                                .white),
                                                                        border: InputBorder
                                                                            .none,
                                                                        hintText: !_moneyNode.hasFocus
                                                                            ? "0\tDD"
                                                                            : ""),
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .bottomCenter,
                                                                  child:
                                                                      IconButton(
                                                                    disabledColor:
                                                                        Colors
                                                                            .grey,
                                                                    color: Colors
                                                                        .white,
                                                                    icon: Icon(
                                                                      Icons
                                                                          .arrow_right_alt_rounded,
                                                                      size: 30,
                                                                    ),
                                                                    onPressed: _moneyController
                                                                            .text
                                                                            .isEmpty
                                                                        ? null
                                                                        : () =>
                                                                            {
                                                                              _pageController.nextPage(duration: Duration(milliseconds: 200), curve: Curves.ease)
                                                                            },
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      : Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(16.0),
                                                          child:
                                                              SingleChildScrollView(
                                                            child: Column(
                                                              children: [
                                                                Text(
                                                                  "Enter the recepient id",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          32,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top:
                                                                          28.0),
                                                                  child:
                                                                      TextField(
                                                                    controller:
                                                                        _receiverController,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                        color: Colors
                                                                            .white),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      hintStyle: TextStyle(
                                                                          fontSize:
                                                                              20,
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top:
                                                                          38.0),
                                                                  child:
                                                                      MaterialButton(
                                                                    shape:
                                                                        StadiumBorder(),
                                                                    color: Colors
                                                                        .blueAccent,
                                                                    onPressed:
                                                                        () {
                                                                      if (_receiverController
                                                                              .text
                                                                              .toLowerCase()
                                                                              .contains(
                                                                                  'atb') ||
                                                                          _receiverController
                                                                              .text
                                                                              .toLowerCase()
                                                                              .contains('stb')) {
                                                                        print(
                                                                            "it does contain");
                                                                        if (widget.userId.toString().toLowerCase().contains("atb") && _receiverController.text.toLowerCase().contains("stb") ||
                                                                            widget.userId.toString().toLowerCase().contains("stb") &&
                                                                                _receiverController.text.toLowerCase().contains("atb")) {
                                                                          print(
                                                                              "should show scaffold");

                                                                          ScaffoldMessenger.of(context)
                                                                              .showSnackBar(SnackBar(
                                                                            behavior:
                                                                                SnackBarBehavior.floating,
                                                                            content:
                                                                                Text("User does not belong to the organization ${widget.userId?.split('_')[1].toString()} "),
                                                                          ));
                                                                          return;
                                                                        } else {
                                                                          RepostiroyApi.transferUtxo(widget.userId.toString(), _receiverController.text, int.parse(_moneyController.text))
                                                                              .then((value) {
                                                                            print(value);
                                                                            if (jsonDecode(value)["status"] ==
                                                                                "success") {
                                                                              Navigator.of(context).pop(_moneyController.text);
                                                                              showDialog(
                                                                                  context: context,
                                                                                  builder: (context) {
                                                                                    return Dialog(
                                                                                      shape: RoundedRectangleBorder(
                                                                                        borderRadius: BorderRadius.circular(20),
                                                                                      ),
                                                                                      elevation: 0,
                                                                                      backgroundColor: Colors.transparent,
                                                                                      child: contentBox(context),
                                                                                    );
                                                                                  });
                                                                            }
                                                                          });
                                                                        }
                                                                      } else {
                                                                        RepostiroyApi.transferUtxo(
                                                                                widget.userId.toString(),
                                                                                _receiverController.text,
                                                                                int.parse(_moneyController.text))
                                                                            .then((value) {
                                                                          print(
                                                                              value);
                                                                          if (jsonDecode(value)["status"] ==
                                                                              "success") {
                                                                            Navigator.of(context).pop(_moneyController.text);
                                                                            showDialog(
                                                                                context: context,
                                                                                builder: (context) {
                                                                                  return Dialog(
                                                                                    shape: RoundedRectangleBorder(
                                                                                      borderRadius: BorderRadius.circular(20),
                                                                                    ),
                                                                                    elevation: 0,
                                                                                    backgroundColor: Colors.transparent,
                                                                                    child: contentBox(context),
                                                                                  );
                                                                                });
                                                                          }
                                                                        });
                                                                      }
                                                                    },
                                                                    child: Text(
                                                                      'To send',
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                }),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                          if (result != null) {
                            setState(() {
                              solde = (int.parse(solde!) - int.parse(result))
                                  .toString();
                            });
                          }
                        },
                        child: Text(
                          "To send",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: Constants.padding,
              top: Constants.avatarRadius + Constants.padding,
              right: Constants.padding,
              bottom: Constants.padding),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Money sent successfully",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "successful transaction",
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 22,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: TextButton(
                      child: Text("To confirm"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )),
              ),
            ],
          ),
        ),
        Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Constants.avatarRadius,
            child: ClipRRect(
                borderRadius:
                    BorderRadius.all(Radius.circular(Constants.avatarRadius)),
                child: Image.asset("assets/coin.png")),
          ),
        ),
      ],
    );
  }
}

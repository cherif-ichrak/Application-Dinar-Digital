import 'package:bct_web/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeDetails extends StatefulWidget {
  HomeDetails({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomeDetailsState createState() => _HomeDetailsState();
}

class _HomeDetailsState extends State<HomeDetails> {
  int _counter = 0;

  int solde = 0;

  TextEditingController _amount = TextEditingController();

  TextEditingController _amountStb = TextEditingController();
  TextEditingController _amountAtb = TextEditingController();

  var soldeStb = 0;

  var soldeATB = 0;

  bool loading = false;
  bool loading_STB = false;
  bool loading_ATB = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    fetchSolde();
    // TODO: implement initState
    super.initState();
  }

  fetchSolde() async {
    print("here");
    try {
      solde = int.parse(await RepostiroyApi.getSolde('admin_BCT'));
      soldeATB = int.parse(await RepostiroyApi.getSolde('admin_ATB'));
      soldeStb = int.parse(await RepostiroyApi.getSolde('admin_STB'));
    } catch (e) {
      solde = 0;
    }
    setState(() {});
  }

  mint() async {
    print(_amount.text);
    await RepostiroyApi.mint('', int.parse(_amount.text));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Scrollbar(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset('assets/logo.png'),
            Expanded(
              child: Row(
                children: [
                  buildSection1(),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.amber,
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(32.0),
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                        text: "Solde STB\n",
                                        style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold),
                                        children: [
                                          TextSpan(text: "$soldeStb")
                                        ]),
                                  ),
                                ),
                                CircleAvatar(
                                    radius: 80,
                                    backgroundImage: Image.asset(
                                            "assets/stb.png",
                                            width: 80,
                                            fit: BoxFit.cover,
                                            height: 80)
                                        .image),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "admin_STB",
                                    style: TextStyle(fontSize: 32),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(32.0),
                                  child: TextField(
                                    controller: _amountStb,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        hintText: 0.toString() + 'DD'),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 72),
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),
                                    ],
                                  ),
                                ),
                                MaterialButton(
                                  minWidth: 150,
                                  color: Colors.green,
                                  onPressed: () async {
                                    print("call transfer stb api");
                                    print(_amountStb.text);
                                    // solde = double.parse(_amount.text);
                                    setState(() {
                                      loading_STB = true;
                                    });
                                    await RepostiroyApi.transferUtxo(
                                            'admin_BCT',
                                            'admin_STB',
                                            int.parse(_amountStb.text))
                                        .whenComplete(() {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(buildSnackBar());
                                    });
                                    fetchSolde();
                                    loading_STB = false;

                                    setState(() {});
                                  },
                                  child: loading_STB
                                      ? Center(
                                          child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ))
                                      : Text(
                                          "Transférer",
                                          style: TextStyle(
                                              fontSize: 36,
                                              color: Colors.white),
                                        ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: VerticalDivider(),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(32.0),
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                        text: "Solde ATB\n",
                                        style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold),
                                        children: [
                                          TextSpan(text: "$soldeATB")
                                        ]),
                                  ),
                                ),
                                CircleAvatar(
                                    radius: 80,
                                    backgroundImage: Image.asset(
                                            "assets/atb.jpg",
                                            width: 80,
                                            fit: BoxFit.cover,
                                            height: 80)
                                        .image),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "admin_ATB",
                                    style: TextStyle(fontSize: 32),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(32.0),
                                  child: TextField(
                                    controller: _amountAtb,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          gapPadding: 5,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        hintText: 0.toString() + 'DD'),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 72),
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),
                                    ],
                                  ),
                                ),
                                MaterialButton(
                                  minWidth: 150,
                                  color: Colors.green,
                                  onPressed: () async {
                                    print("call transferer atb");
                                    setState(() {
                                      loading_ATB = true;
                                    });
                                    await RepostiroyApi.transferUtxo(
                                            'admin_BCT',
                                            'admin_ATB',
                                            int.parse(_amountAtb.text))
                                        .whenComplete(() {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(buildSnackBar());
                                    });
                                    loading_ATB = false;
                                    fetchSolde();

                                    setState(() {});
                                  },
                                  child: loading_ATB
                                      ? Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        )
                                      : Text(
                                          "Transférer",
                                          style: TextStyle(
                                              fontSize: 36,
                                              color: Colors.white),
                                        ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  SnackBar buildSnackBar() {
    return SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          "Transfer effectué avec succées",
          style: TextStyle(color: Colors.white),
        ));
  }

  Expanded buildSection1() {
    return Expanded(
      child: Container(
        color: Colors.blue,
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                      text: "Ressources disponibles\n",
                      style: TextStyle(fontSize: 72),
                    ),
                    TextSpan(
                      text: "DD = Dinar Digital\n\n",
                      style: TextStyle(fontSize: 36),
                    ),
                    TextSpan(
                      text: "$solde DD",
                      style: TextStyle(fontSize: 56),
                    )
                  ]),
                )),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: TextField(
                      controller: _amount,
                      decoration:
                          InputDecoration(hintText: 0.toString() + 'DD'),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 72),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 150,
                    color: Colors.green,
                    onPressed: () async {
                      print("call mint api");
                      setState(() {
                        loading = true;
                      });
                      await mint();
                      solde += int.parse(_amount.text);
                      loading = false;
                      setState(() {});
                    },
                    child: loading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            "Mint",
                            style: TextStyle(fontSize: 36, color: Colors.white),
                          ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

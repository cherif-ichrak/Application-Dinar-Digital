import 'package:flutter/material.dart';
import 'package:pfe_wallet/screens/dashboard.dart';

import '../services.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  Shader linearGradient = LinearGradient(
    colors: <Color>[Color(0xff3f5efb), Color(0xfffc466b)],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  TextEditingController textController = new TextEditingController();

  String? _banque;
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
        child: Column(
          children: [
            AppBar(
              elevation: 0,
              foregroundColor: Colors.transparent,
              backgroundColor: Color(0xff020024),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 80),
              child: Text(
                "\nDigital Wallet",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  foreground: Paint()..shader = linearGradient,
                  fontSize: 45,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 32.0,
                  right: 32,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Create Wallet",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      DropdownButton(
                          underline: Container(),
                          isExpanded: true,
                          focusColor: Colors.white,
                          dropdownColor: Color(0xff0029ff),
                          iconEnabledColor: Colors.white,
                          value: _banque,
                          onChanged: (val) {
                            print(val);
                            _banque = val!.toString();
                            setState(() {});
                          },
                          hint: Text(
                            "Enter your bank",
                            style: TextStyle(color: Colors.white),
                          ),
                          items: [
                            DropdownMenuItem<String>(
                              value: "ATB",
                              child: Row(
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceEvenly,
                                children: [
                                  CircleAvatar(
                                      radius: 20,
                                      backgroundImage: Image.network(
                                              "http://tunisieguide.com/images/logos/1149/img_atb-arab-tunisian-bank.jpg",
                                              width: 50,
                                              fit: BoxFit.contain,
                                              height: 50)
                                          .image),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  Text(
                                    "ATB",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            DropdownMenuItem<String>(
                              value: "STB",
                              child: Row(
                                children: [
                                  CircleAvatar(
                                      radius: 20,
                                      backgroundImage: Image.network(
                                              "https://alwatan.com.tn/wp-content/uploads/2020/11/%D8%A7%D9%84%D8%B4%D8%B1%D9%83%D8%A9-%D8%A7%D9%84%D8%AA%D9%88%D9%86%D8%B3%D9%8A%D8%A9-%D9%84%D9%84%D8%A8%D9%86%D9%83.png",
                                              width: 50,
                                              fit: BoxFit.cover,
                                              height: 50)
                                          .image),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  Text(
                                    "STB",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: TextField(
                          controller: textController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true,
                            hintText:
                                "Enter your username with _${_banque ?? "banque"}",
                            // border: InputBorder
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      MaterialButton(
                        height: 50,
                        minWidth: MediaQuery.of(context).size.width,
                        shape: StadiumBorder(),
                        child: Text(
                          "Validate",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        color: Colors.blueAccent,
                        onPressed: () async {
                          print("debug");
                          if (!textController.text.contains(_banque!)) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Your username is wrong")));
                            return;
                          }
                          var message = await RepostiroyApi.register(
                              textController.text.toString());

                          if (message == "error") {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              duration: Duration(milliseconds: 1000),
                              content: Text("The following id does not exist"),
                              backgroundColor: Colors.red.shade600,
                            ));
                          } else {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Dashboard(
                                      userId: textController.text,
                                    )));
                          }
                          // var response = await RepostiroyApi.login(textController.text);
                        },
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

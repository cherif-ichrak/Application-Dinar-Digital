import 'package:flutter/material.dart';
import 'package:pfe_wallet/screens/dashboard.dart';

import '../services.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Shader linearGradient = LinearGradient(
    colors: <Color>[Color(0xff3f5efb), Color(0xfffc466b)],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  TextEditingController textController = new TextEditingController();
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
                        "Login \n",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                          fontSize: 30,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        child: TextField(
                          controller: textController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Enter your Username",
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
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        color: Colors.blue,
                        onPressed: () async {
                          print("");
                          var message = await RepostiroyApi.verifyLogin(
                              textController.text);
                          if (message.startsWith("Identity")) {
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

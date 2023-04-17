import 'package:flutter/material.dart';
import 'package:pfe_wallet/screens/login.dart';
import 'package:pfe_wallet/screens/register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Shader linearGradient = LinearGradient(
    colors: <Color>[Color(0xff3f5efb), Color(0xfffc466b)],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  int _counter = 0;

  TextEditingController textController = new TextEditingController();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
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
      body: Container(
        decoration: buildBoxDecoration(),
        child: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "\nDigital \n\t\t\tWallet \n\n",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    foreground: Paint()..shader = linearGradient,
                    fontSize: 72,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 32.0, right: 32, top: 0, bottom: 20),
                  child: Column(
                    children: [
                      MaterialButton(
                        height: 50,
                        minWidth: MediaQuery.of(context).size.width,
                        shape: StadiumBorder(),
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => RegisterScreen()));
                        },
                        child: Text(
                          "Create Wallet",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      MaterialButton(
                        height: 50,
                        minWidth: MediaQuery.of(context).size.width,
                        shape: StadiumBorder(),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                        },
                        color: Colors.blue,
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0, 35, 100],
            colors: [Color(0xff020024), Color(0xff090979), Color(0xff0029ff)]));
  }
}

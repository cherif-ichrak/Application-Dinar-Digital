import 'package:bct_web/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BCT Mint',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => MyHomePage(
              title: "",
            ),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/home': (context) => HomeDetails(
              title: "",
            ),
      },
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  GlobalKey<FormState>? _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset('assets/logo.png'),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(50),
                // decoration: BoxDecoration(border: Border.all(width: 20)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 88.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Text(
                              "Admin Authentification",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 64),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                padding: EdgeInsets.all(32),
                                decoration: BoxDecoration(border: Border.all()),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextFormField(
                                      validator: (val) {
                                        if (val != "admin_BCT")
                                          return "Vous n'etes pas autorisé";
                                      },
                                      onFieldSubmitted: (val) {
                                        if (val != "admin_BCT") {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  backgroundColor:
                                                      Colors.redAccent,
                                                  content: Text(
                                                    "Vous n'etes pas autorisé",
                                                  )));
                                          return;
                                        }
                                        Navigator.of(context).pushNamed(
                                          "/home",
                                        );
                                      },
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        hintText: "Votre ID",
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    TextButton(
                                      child: Text("Se Connecter"),
                                      onPressed: () {
                                        if (_formKey!.currentState!
                                            .validate()) {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomeDetails(
                                                          title: "title")));
                                        }
                                      },
                                    ),
                                    // TextFormField(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

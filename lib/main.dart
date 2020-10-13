import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construction_procurement_app/Screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Providers/RequisitionProvider.dart';
import 'Services/FirestoreService.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => RequisitionProvider()),
          StreamProvider(create: (context) => firestoreService.getProducts()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.red,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide.none,
                //borderSide: const BorderSide(),
              ),
              hintStyle: TextStyle(color: Colors.blueGrey),
              filled: true,
              fillColor: Colors.white70,
            ),
          ),
          home: HomeScreen(),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final databaseReference = Firestore.instance;

  void createRecord() async {
    await databaseReference.collection("books").document("1").setData({
      'title': 'Mastering Flutter',
      'description': 'Programming Guide for Dart'
    });

    DocumentReference ref = await databaseReference.collection("books").add({
      'title': 'Flutter in Action',
      'description': 'Complete Programming Guide to learn Flutter'
    });
    print(ref.documentID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            FlatButton(
              onPressed: () {
                createRecord();
              },
              child: Text(
                'Click',
              ),
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

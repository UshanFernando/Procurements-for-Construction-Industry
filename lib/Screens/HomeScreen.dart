import 'package:construction_procurement_app/Widgets/RaisedGredientBtn.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(children: <Widget>[
      Image.asset(
        "Assets/bg.jpg",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Home"),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Container(
            height: height * 0.5,
            width: double.infinity,
            padding: EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.white54,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedGradientButton(
                    child: Text(
                      'Purchase Requsition',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    gradient: LinearGradient(
                      colors: <Color>[Colors.red, Colors.orange[700]],
                    ),
                    onPressed: () {
                      print('button clicked');
                    }),
                SizedBox(
                  height: 10,
                ),
                RaisedGradientButton(
                    child: Text(
                      'View Requsition List',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    gradient: LinearGradient(
                      colors: <Color>[Colors.red, Colors.orange[700]],
                    ),
                    onPressed: () {
                      print('button clicked');
                    }),
                SizedBox(
                  height: 10,
                ),
                RaisedGradientButton(
                    child: Text(
                      'View Purchase Order',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    gradient: LinearGradient(
                      colors: <Color>[Colors.red, Colors.orange[700]],
                    ),
                    onPressed: () {
                      print('button clicked');
                    }),
              ],
            ),
          ),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      )
    ]);
    ;
  }
}

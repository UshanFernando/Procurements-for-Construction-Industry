import 'package:construction_procurement_app/Screens/HomeScreen.dart';
import 'package:construction_procurement_app/Screens/PurchaseRequisition.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter App",
      home: LoginPage(),
      theme: new ThemeData(
          brightness: Brightness.light,
          primaryColor: Theme.of(context).primaryColor,
          primaryColorDark: Theme.of(context).primaryColor),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    final txtUserName = Container(
        height: 45.0,
        child: TextField(
            controller: usernameController,
            style: TextStyle(color: Theme.of(context).primaryColor),
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.person,
                color: Colors.red,
              ),
              hintText: 'Username',
              hintStyle: TextStyle(
                  fontSize: 15.0, color: Theme.of(context).primaryColor),
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  width: 1,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            )));

    final txtPassword = Container(
        height: 45.0,
        child: TextField(
            controller: passwordController,
            style: TextStyle(color: Theme.of(context).primaryColor),
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.vpn_key,
                color: Colors.red,
              ),
              hintText: 'Password',
              hintStyle: TextStyle(
                  fontSize: 15.0, color: Theme.of(context).primaryColor),
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  width: 1,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            )));

    final btnLogin = Container(
        height: 45.0,
        child: RaisedButton(
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          disabledColor: Colors.grey,
          disabledTextColor: Colors.black,
          padding: EdgeInsets.all(8.0),
          splashColor: Colors.blueAccent,
          child: Text('Login'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
            side: BorderSide(color: Theme.of(context).primaryColor),
          ),
          onPressed: () {
            if (usernameController != null &&
                usernameController.text == "store" &&
                passwordController != null &&
                passwordController.text == "123") {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
              usernameController.clear();
              passwordController.clear();
            } else if (usernameController != null &&
                usernameController.text == "site" &&
                passwordController != null &&
                passwordController.text == "123") {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
              usernameController.clear();
              passwordController.clear();
            } else {
              // Widget okButton = FlatButton(
              //   child: Text("OK"),
              //   onPressed: () {
              //     Navigator.push(context,
              //         MaterialPageRoute(builder: (context) => Login()));
              //   },
              // );

              AlertDialog alert = AlertDialog(
                title: Text("Error !"),
                titleTextStyle: TextStyle(
                    color: Colors.red[900], fontWeight: FontWeight.bold),
                content: Text(
                  "Please Enter Correct Username and Password",
                ),
                contentTextStyle: TextStyle(
                  color: Colors.red,
                ),
                // actions: [
                //   okButton,
                // ],
              );

              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alert;
                },
              );
            }
          },
        ));

    return Stack(children: <Widget>[
      Image.asset(
        "Assets/bg.jpg",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
          backgroundColor: Colors.transparent,
          body: new Center(
            child: new ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 25, right: 25),
              children: <Widget>[
                getImageAsset(),
                SizedBox(
                  height: 20.0,
                ),
                txtUserName,
                SizedBox(
                  height: 20.0,
                ),
                txtPassword,
                SizedBox(
                  height: 8.0,
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: 10.0, left: 20.0, bottom: 10.0, right: 20.0),
                  child: new RichText(
                    text: new TextSpan(
                      children: [
                        new TextSpan(
                          text: 'Forgot Password?',
                          style: new TextStyle(
                              color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                  ),
                ),
                btnLogin,
                Container(
                  height: 45,
                  margin: EdgeInsets.only(
                      top: 10.0, left: 20.0, bottom: 10.0, right: 20.0),
                  child: Row(
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      FlatButton(
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => StepOne()),
                          // );
                        },
                        child: Text(
                          "SignUp ",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ))
    ]);
  }

  Widget getImageAsset() {
    AssetImage assImg = AssetImage('Assets/avt.png');
    Image img = Image(
      image: assImg,
      width: 80.0,
      height: 80.0,
    );
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
      child: img,
    );
  }
}

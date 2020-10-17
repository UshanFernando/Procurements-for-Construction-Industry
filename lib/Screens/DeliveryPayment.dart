import 'package:construction_procurement_app/Screens/DeliveryHome.dart';
import 'package:construction_procurement_app/Providers/DeliveryManagerProvider.dart';
import 'package:construction_procurement_app/Widgets/RaisedGredientBtn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeliveryPayment extends StatefulWidget {
  @override
  _DeliveryPaymentState createState() => _DeliveryPaymentState();
}

class _DeliveryPaymentState extends State<DeliveryPayment> {
  String _invoiceNo;
  double _invoiceAmt;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final delProvider =
        Provider.of<DeliveryManagerProvider>(context, listen: false);
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
          title: Text("Payment Management"),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(15),
                  width: double.infinity,
                  padding: EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
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
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: SizedBox(
                          height: 50,
                          child: TextField(
                            onChanged: (value) => {
                              setState(() {
                                _invoiceNo = value;
                              })
                            },
                            //controller: qtyController,
                            keyboardType: TextInputType.datetime,
                            decoration: new InputDecoration(
                              hintText: "Enter Invoice",
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: SizedBox(
                          height: 50,
                          child: TextField(
                            onChanged: (value) => {
                              setState(() {
                                _invoiceAmt = double.parse(value);
                              })
                            },
                            //controller: qtyController,
                            keyboardType: TextInputType.number,
                            decoration: new InputDecoration(
                              hintText: "Enter Amount",
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text(
                          "Scanned Invoice",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(
                        height: height * (1.5 / 4),
                        child: Expanded(
                          child: Container(
                            //height: double.infinity,
                            margin: const EdgeInsets.only(
                                left: 10.0, right: 10.0, top: 10.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: delProvider.imageUrl != null
                                  ? Image.network(delProvider.imageUrl)
                                  : Text("Loading..."),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      RaisedGradientButton(
                          child: Text(
                            'Verify',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            if (_invoiceAmt == null || _invoiceNo == null) {
                              _showMyDialog(context, "error", false,
                                  "Please enter the details!");
                            } else {
                              delProvider.changePaymentID(_invoiceNo);
                              delProvider.changeAmount(_invoiceAmt);
                              delProvider.saveToDbDelivery();
                              _showMyDialog(context, "success", true,
                                  "Payment Successfull!");
                            }
                          })
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      )
    ]);
  }

  Future<void> _showMyDialog(context, type, isDisable, message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Icon(
              type == "success" ? Icons.done_rounded : Icons.error,
              color: Colors.black45,
              size: 50,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Center(child: Text(message)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Ok"),
              onPressed: () {
                if (!isDisable) {
                  Navigator.of(context).pop();
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DeliveryHome()),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}

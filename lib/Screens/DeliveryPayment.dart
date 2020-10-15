import 'dart:io';

import 'package:construction_procurement_app/Widgets/RaisedGredientBtn.dart';
import 'package:flutter/material.dart';

class DeliveryPayment extends StatefulWidget {
  @override
  _DeliveryPaymentState createState() => _DeliveryPaymentState();
}

class _DeliveryPaymentState extends State<DeliveryPayment> {
  File _imageFile;
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
          title: Text("Payment Management"),
        ),
        body: Center(
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
                          //onChanged: (value) => reqProvider.changeQty(value),
                          //controller: qtyController,
                          keyboardType: TextInputType.number,
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
                          //onChanged: (value) => reqProvider.changeQty(value),
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
                        "Scan Invoice",
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
                            child: _imageFile != null
                                ? Image.file(_imageFile)
                                : Text("Add a photo"),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(height: 20),
                    RaisedGradientButton(
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          // reqProvider.saveProduct();
                          // if (reqProvider.reqNo == null) {
                          //   reqProvider.changeReqNo(reqNoController.text);
                          //   reqProvider.changeDate(dateController.text);
                          //   reqProvider.changeLocation(locationController.text);
                          // }

                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => RequsitionDetails()),
                          // );
                        })
                  ],
                ),
              ),
            ],
          ),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      )
    ]);
    ;
  }
}

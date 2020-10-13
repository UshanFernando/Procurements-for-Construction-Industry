import 'package:construction_procurement_app/Widgets/RaisedGredientBtn.dart';
import 'package:flutter/material.dart';

class PurchaseRequisition extends StatefulWidget {
  @override
  _PurchaseRequisitionState createState() => _PurchaseRequisitionState();
}

class _PurchaseRequisitionState extends State<PurchaseRequisition> {
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
          title: Text("Purchase Requisition"),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50,
                margin: EdgeInsets.only(
                  top: 30,
                  left: 25,
                  right: 25,
                ),
                child: TextField(
                  decoration: new InputDecoration(
                      hintText: "Requsition No", fillColor: Colors.white),
                ),
              ),
              Container(
                height: 50,
                margin: EdgeInsets.only(
                  top: 10,
                  left: 25,
                  right: 25,
                ),
                child: TextField(
                  keyboardType: TextInputType.datetime,
                  decoration: new InputDecoration(
                      hintText: "Dilivery Date", fillColor: Colors.white),
                ),
              ),
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
                    SizedBox(
                      height: 50,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                          hintText: "Quantity",
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 100,
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        minLines: 3,
                        decoration: new InputDecoration(
                          hintText: "Description",
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 50,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                          hintText: "Unit Price",
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 50,
                      child: TextField(
                        decoration: new InputDecoration(
                          hintText: "Location",
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    RaisedGradientButton(
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          print('button clicked');
                        }),
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

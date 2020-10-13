import 'package:construction_procurement_app/Models/Requistion.dart';
import 'package:construction_procurement_app/Providers/RequisitionProvider.dart';
import 'package:construction_procurement_app/Screens/RequisitionDetails.dart';
import 'package:construction_procurement_app/Widgets/RaisedGredientBtn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PurchaseRequisition extends StatefulWidget {
  @override
  _PurchaseRequisitionState createState() => _PurchaseRequisitionState();
}

class _PurchaseRequisitionState extends State<PurchaseRequisition> {
  final reqNoController = TextEditingController();
  final dateController = TextEditingController();
  final qtyController = TextEditingController();
  final descController = TextEditingController();
  final priceController = TextEditingController();
  final locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    dateController.dispose();
    reqNoController.dispose();
    qtyController.dispose();
    descController.dispose();
    priceController.dispose();
    locationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final reqProvider = Provider.of<RequisitionProvider>(context);

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
              if (reqProvider.reqNo == null)
                Container(
                  height: 50,
                  margin: EdgeInsets.only(
                    top: 30,
                    left: 25,
                    right: 25,
                  ),
                  child: TextField(
                    controller: reqNoController,
                    // onChanged: (value) => reqProvider.changeReqNo(value),
                    decoration: new InputDecoration(
                        hintText: "Requsition No", fillColor: Colors.white),
                  ),
                ),
              if (reqProvider.date == null)
                Container(
                  height: 50,
                  margin: EdgeInsets.only(
                    top: 10,
                    left: 25,
                    right: 25,
                  ),
                  child: TextField(
                    controller: dateController,
                    keyboardType: TextInputType.datetime,
                    // onChanged: (value) => reqProvider.changeDate(value),
                    decoration: new InputDecoration(
                        hintText: "Dilivery Date", fillColor: Colors.white),
                  ),
                ),
              if (reqProvider.location == null)
                Container(
                  height: 50,
                  margin: EdgeInsets.only(
                    top: 10,
                    left: 25,
                    right: 25,
                  ),
                  child: TextField(
                    // onChanged: (value) => reqProvider.changeLocation(value),
                    controller: locationController,
                    decoration: new InputDecoration(
                        hintText: "Location", fillColor: Colors.white),
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
                        onChanged: (value) => reqProvider.changeQty(value),
                        controller: qtyController,
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
                        onChanged: (value) =>
                            reqProvider.changeDescription(value),
                        controller: descController,
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
                        controller: priceController,
                        onChanged: (value) => reqProvider.changePrice(value),
                        keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                          hintText: "Unit Price",
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    RaisedGradientButton(
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          reqProvider.saveProduct();
                          if (reqProvider.reqNo == null) {
                            reqProvider.changeReqNo(reqNoController.text);
                            reqProvider.changeDate(dateController.text);
                            reqProvider.changeLocation(locationController.text);
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RequsitionDetails()),
                          );
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

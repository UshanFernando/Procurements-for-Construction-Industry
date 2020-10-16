import 'package:construction_procurement_app/Models/PurchaseOrder.dart';
import 'package:construction_procurement_app/Models/PurchaseOrderItem.dart';
import 'package:construction_procurement_app/Widgets/PurchaseOrderItemWidget.dart';
import 'package:construction_procurement_app/Providers/RequisitionProvider.dart';
import 'package:construction_procurement_app/Screens/PurchaseOrders.dart';
import 'package:construction_procurement_app/Screens/PurchaseRequisition.dart';
import 'package:construction_procurement_app/Screens/RequsitionsList.dart';
import 'package:construction_procurement_app/Services/FirestoreService.dart';
import 'package:construction_procurement_app/Widgets/RaisedGredientBtn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PurchaseOrderDetails extends StatelessWidget {
  final PurchaseOrder purchaseOrder;

  //requiring the list of todos
  PurchaseOrderDetails({Key key, @required this.purchaseOrder})
      : super(key: key);

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
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(15),
              width: double.infinity,
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Order NO : ${purchaseOrder.reqNo}',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ...purchaseOrder.poItems.map((e) {
                    return PurchaseOrderItemWidget(e);
                  }).toList(),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Text(
                        'Order Total = ${purchaseOrder.totPrice} LKR',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  // RaisedGradientButton(
                  //     child: Text(
                  //       'View Purchase Order',
                  //       style: TextStyle(
                  //           color: Colors.white, fontWeight: FontWeight.bold),
                  //     ),
                  //     onPressed: () {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => PurchaseOrders()),
                  //       );
                  //     }),
                ],
              ),
            ),
          ),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      )
    ]);
  }
}

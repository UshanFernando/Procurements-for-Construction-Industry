import 'package:construction_procurement_app/Models/Product.dart';
import 'package:construction_procurement_app/Models/Requistion.dart';
import 'package:construction_procurement_app/Providers/DeliveryManagerProvider.dart';
import 'package:construction_procurement_app/Screens/DeliveryPayment.dart';
import 'package:construction_procurement_app/Widgets/RaisedGredientBtn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:provider/provider.dart';

class DeliveryReconciliate extends StatefulWidget {
  @override
  _DeliveryReconciliateState createState() => _DeliveryReconciliateState();
}

class _DeliveryReconciliateState extends State<DeliveryReconciliate> {
  final qtyController = TextEditingController();
  final descController = TextEditingController();
  final reqController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    qtyController.dispose();
    descController.dispose();
    reqController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final delProvider = Provider.of<DeliveryManagerProvider>(context);

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
          title: Text("Delivery Management"),
        ),
        body: SingleChildScrollView(
          child: Center(
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
                        margin: EdgeInsets.only(bottom: 15),
                        child: Text(
                          "Accept Delivery",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        child: TextField(
                          onChanged: (value) => delProvider.changeReqNo(value),
                          controller: reqController,
                          keyboardType: TextInputType.number,
                          decoration: new InputDecoration(
                            hintText: "Enter Ref No",
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 15, top: 15),
                        child: Text(
                          "Enter Goods Received",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Row(children: <Widget>[
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(right: 2),
                            child: SizedBox(
                              height: 50,
                              child: TextField(
                                onChanged: (value) =>
                                    delProvider.changeDescription(value),
                                controller: descController,
                                keyboardType: TextInputType.text,
                                decoration: new InputDecoration(
                                  hintText: "Item code",
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 2),
                            child: SizedBox(
                              height: 50,
                              child: TextField(
                                onChanged: (value) =>
                                    delProvider.changeQty(value),
                                controller: qtyController,
                                keyboardType: TextInputType.number,
                                decoration: new InputDecoration(
                                  hintText: "Quantity",
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: IconButton(
                            icon: Icon(
                              Icons.add_circle,
                              size: 30,
                            ),
                            onPressed: () {
                              if (reqController.text == "") {
                                _showMyDialog(context, "error", false,
                                    "Please enter Ref No!");
                              } else if (qtyController.text == "" ||
                                  descController.text == "") {
                                _showMyDialog(context, "error", false,
                                    "Please enter Goods Received!");
                              } else {
                                delProvider.saveDeliveryItems();
                              }
                            },
                          ),
                          width: 30,
                          alignment: Alignment.center,
                        ),
                      ]),
                      SizedBox(height: 10),
                      Container(
                          margin: EdgeInsets.all(8),
                          //padding: EdgeInsets.all(8),
                          color: Colors.white,
                          child: Expanded(
                              child:
                                  _getTable(delProvider.deliveryItems, width))),
                      SizedBox(height: 10),
                      RaisedGradientButton(
                          child: Text(
                            'Submit',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            delProvider.deliveryReconciliation();
                            if (delProvider.deliveryItems.length > 0) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DeliveryPayment()),
                              );
                            } else {
                              _showMyDialog(context, "error", false,
                                  "Items in the list is empty!");
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
    ;
  }

  Widget _getTable(List<Product> items, width) {
    return Container(
      child: HorizontalDataTable(
        leftHandSideColumnWidth: width * (0.5 / 3),
        rightHandSideColumnWidth: width * (2.5 / 3),
        isFixedHeader: true,
        headerWidgets: _getTitleWidget(width),
        leftSideItemBuilder: _generateFirstColumnRow,
        rightSideItemBuilder: _generateRightHandSideColumnRow,
        itemCount: items.length,
        rowSeparatorWidget: const Divider(
          color: Colors.black54,
          height: 1.0,
          thickness: 0.0,
        ),
        leftHandSideColBackgroundColor: Color(0xFFFFFFFF),
        rightHandSideColBackgroundColor: Color(0xFFFFFFFF),
      ),
      height: MediaQuery.of(context).size.height * 0.4,
    );
  }

  List<Widget> _getTitleWidget(width) {
    return [
      _getTitleItemWidget('Req No', width * (0.5 / 3)),
      _getTitleItemWidget('Name', width * (1.1 / 3)),
      _getTitleItemWidget('Qty', width * (0.5 / 3)),
      _getTitleItemWidget('', width * (0.2 / 3)),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
      width: width,
      height: 56,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    final delProvider = Provider.of<DeliveryManagerProvider>(context);
    double width = MediaQuery.of(context).size.width;
    List<Product> items = delProvider.deliveryItems;
    return Container(
      child: Text(delProvider.reqNo),
      width: width * (0.5 / 3),
      height: 52,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    final delProvider = Provider.of<DeliveryManagerProvider>(context);
    double width = MediaQuery.of(context).size.width;
    List<Product> items = delProvider.deliveryItems;
    if (items[index] != null) {
      return Row(
        children: <Widget>[
          Container(
            child: Text(items[index].desc),
            width: width * (1.05 / 3),
            height: 52,
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
          ),
          Container(
            child: Text(items[index].qty.toString()),
            width: width * (0.4 / 3),
            height: 52,
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
          ),
          Container(
              child: IconButton(
            icon: Icon(
              Icons.remove_circle_outline,
              size: 20,
            ),
            onPressed: () {
              delProvider.removeDeliveryItems(items[index]);
            },
          )),
        ],
      );
    }
  }

  Future<void> _showMyDialog(context, type, isDisable, message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Icon(
              type == "succes" ? Icons.done_rounded : Icons.error,
              color: Colors.black45,
              size: 40,
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
              child: Text(isDisable ? "Please wait..." : "Ok"),
              onPressed: () {
                if (!isDisable) {
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}

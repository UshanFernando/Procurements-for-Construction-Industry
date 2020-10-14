import 'package:construction_procurement_app/Models/Product.dart';
import 'package:construction_procurement_app/Models/Requistion.dart';
import 'package:construction_procurement_app/Models/SupplierQuotation.dart';
import 'package:construction_procurement_app/Providers/RequisitionProvider.dart';
import 'package:construction_procurement_app/Providers/SupplierProvider.dart';
import 'package:construction_procurement_app/Widgets/RaisedGredientBtn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'RequisitionDetails.dart';

class SupplierList extends StatefulWidget {
  @override
  _SupplierListState createState() => _SupplierListState();
}

class _SupplierListState extends State<SupplierList> {
  final reqNoController = TextEditingController();
  final dateController = TextEditingController();
  final qtyController = TextEditingController();
  final descController = TextEditingController();
  final priceController = TextEditingController();
  final locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //final reqSupProvider = Provider.of<SupplierProvider>(context);
    final supQuotation = Provider.of<List<SupplierQuotation>>(context);
    print(supQuotation);
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
                margin: EdgeInsets.only(
                  top: 30,
                  left: 200,
                  right: 25,
                  bottom: 20,
                ),
                child: RaisedGradientButton(
                    child: Text(
                      'Categorize',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      // reqProvider.saveProduct();
                      // if (reqProvider.reqNo == null) {
                      //   reqProvider.changeReqNo(reqNoController.text);
                      //   reqProvider.changeDate(dateController.text);
                      // }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RequsitionDetails()),
                      );
                    }),
              ),
              Container(
                  padding: EdgeInsets.all(8),
                  color: Colors.white,
                  child: createTable(supQuotation)),
              Container(
                margin: EdgeInsets.only(
                  top: 30,
                  left: 200,
                  right: 25,
                  bottom: 20,
                ),
                child: RaisedGradientButton(
                    child: Text(
                      'Add details to Order',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      // reqProvider.saveProduct();
                      // if (reqProvider.reqNo == null) {
                      //   reqProvider.changeReqNo(reqNoController.text);
                      //   reqProvider.changeDate(dateController.text);
                      // }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RequsitionDetails()),
                      );
                    }),
              ),
            ],
          ),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      )
    ]);
    ;
  }

  bool _val = false;
  Widget createTable(List<SupplierQuotation> products) {
    List<TableRow> rows = [];
    rows.add(TableRow(children: [
      // Text("Name", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      Text("Detail",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      Text("Item", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      Text("Price",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      Text("Check", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
    ]));

    // rows.add(TableRow(children: [
    //   Text(
    //     "dfg",
    //   ),
    //   Text("dfg fgggggggggggggggggggggggggggggggggggggggggg"),
    //   Text("dfg"),
    //   Text("dfg"),
    //   Checkbox(
    //     onChanged: (bool value) {
    //       setState(() {
    //         _val = value;
    //       });
    //     },
    //     value: _val,
    //     activeColor: Color(0xFF6200EE),
    //   )
    // ]));

    for (SupplierQuotation p in products) {
      rows.add(TableRow(children: [
        // Text(
        //   p.supplier.suplierName.toString(),
        // ),
        Text(p.details.toString()),
        p.product != null
            ? Text(p.product.desc.toString())
            : Text('N/A'),
        Text(p.product.price.toString()),
        Checkbox(
          onChanged: (bool value) {
            setState(() {
              //checked= value;
            });
          },
          value: true,
          activeColor: Color(0xFF6200EE),
        )
      ]));
    }

    return Table(
      children: rows,
      border: TableBorder.all(width: 1),
    );
  }
}

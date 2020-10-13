import 'package:construction_procurement_app/Models/Product.dart';
import 'package:construction_procurement_app/Providers/RequisitionProvider.dart';
import 'package:construction_procurement_app/Screens/HomeScreen.dart';
import 'package:construction_procurement_app/Screens/PurchaseRequisition.dart';
import 'package:construction_procurement_app/Widgets/RaisedGredientBtn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequsitionDetails extends StatefulWidget {
  RequsitionDetails({Key key}) : super(key: key);

  @override
  _RequsitionDetailsState createState() => _RequsitionDetailsState();
}

class _RequsitionDetailsState extends State<RequsitionDetails> {
  @override
  Widget build(BuildContext context) {
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
          actions: [
            IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PurchaseRequisition()),
                  );
                })
          ],
        ),
        body: SingleChildScrollView(
            child: Container(
          margin: EdgeInsets.all(12),
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                  padding: EdgeInsets.all(8),
                  color: Colors.white,
                  child: createTable(reqProvider.products, reqProvider.total)),
              if (reqProvider.total != 0)
                Container(
                  width: 200,
                  padding: EdgeInsets.all(8),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Total",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(
                        width: 45,
                      ),
                      Text(reqProvider.total.toString(),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(
                        width: 47,
                      ),
                    ],
                  ),
                ),
              SizedBox(
                height: 25,
              ),
              RaisedGradientButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calculate,
                        color: Colors.white,
                        size: 28,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Genarate Total Price',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                    ],
                  ),
                  gradient: LinearGradient(
                    colors: <Color>[Colors.red, Colors.orange[700]],
                  ),
                  onPressed: () {
                    reqProvider.calcToatal();
                  }),
              SizedBox(
                height: 10,
              ),
              RaisedGradientButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 28,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Send Requsition      ',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                    ],
                  ),
                  gradient: LinearGradient(
                    colors: <Color>[Colors.red, Colors.orange[700]],
                  ),
                  onPressed: () {
                    reqProvider.sendRequsition();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  }),
            ],
          ),
        )),
      )
    ]);
  }

  Widget createTable(List<Product> products, double totPrice) {
    List<TableRow> rows = [];
    rows.add(TableRow(children: [
      Text("Quantity",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      Text("Description",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      Text("Unit Price",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      Text("Total",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    ]));
    for (Product p in products) {
      rows.add(TableRow(children: [
        Text(
          p.qty.toString(),
        ),
        Text(p.desc),
        Text(p.price.toString()),
        Text((p.price * p.qty).toString())
      ]));
    }

    return Table(
      children: rows,
      border: TableBorder.all(width: 1),
    );
  }
}

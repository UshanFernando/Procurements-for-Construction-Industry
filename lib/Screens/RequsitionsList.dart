import 'package:construction_procurement_app/Models/Product.dart';
import 'package:construction_procurement_app/Models/Requistion.dart';
import 'package:construction_procurement_app/Providers/RequisitionProvider.dart';
import 'package:construction_procurement_app/Screens/HomeScreen.dart';
import 'package:construction_procurement_app/Screens/PurchaseRequisition.dart';
import 'package:construction_procurement_app/Widgets/RaisedGredientBtn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequsitionsList extends StatefulWidget {
  RequsitionsList({Key key}) : super(key: key);

  @override
  _RequsitionsListState createState() => _RequsitionsListState();
}

class _RequsitionsListState extends State<RequsitionsList> {
  @override
  Widget build(BuildContext context) {
    final requsitions = Provider.of<List<Requisition>>(context);

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
          title: Text("Purchase Requisitions"),
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
                  child: createTable(requsitions)),
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
                    // reqProvider.sendRequsition();
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => HomeScreen()),
                    // );
                  }),
            ],
          ),
        )),
      )
    ]);
  }

  Widget createTable(List<Requisition> products) {
    List<TableRow> rows = [];
    rows.add(TableRow(children: [
      Text("Requsition No",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      Text("Requester",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      Text("Description",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      Text("Needed by date",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      Text("Status",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    ]));
    for (Requisition p in products) {
      rows.add(TableRow(children: [
        Text(
          p.reqNo,
        ),
        Text('Site Manager 101'),
        Text(p.location),
        Text(p.date),
        Text('Approved')
      ]));
    }

    return Table(
      children: rows,
      border: TableBorder.all(width: 1),
    );
  }
}

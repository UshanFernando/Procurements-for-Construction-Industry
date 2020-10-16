import 'package:construction_procurement_app/Models/Product.dart';
import 'package:construction_procurement_app/Models/PurchaseOrder.dart';
import 'package:construction_procurement_app/Models/Requistion.dart';
import 'package:construction_procurement_app/Providers/RequisitionProvider.dart';
import 'package:construction_procurement_app/Providers/SupplierProvider.dart';
import 'package:construction_procurement_app/Screens/HomeScreen.dart';
import 'package:construction_procurement_app/Screens/PurchaseOrderDetails.dart';
import 'package:construction_procurement_app/Screens/PurchaseRequisition.dart';
import 'package:construction_procurement_app/Screens/SupplierList.dart';
import 'package:construction_procurement_app/Widgets/RaisedGredientBtn.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:provider/provider.dart';

class PurchaseOrders extends StatefulWidget {
  PurchaseOrders({Key key}) : super(key: key);

  @override
  _PurchaseOrdersState createState() => _PurchaseOrdersState();
}

class _PurchaseOrdersState extends State<PurchaseOrders> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pOders = Provider.of<List<PurchaseOrder>>(context);
    final supProvider = Provider.of<SupplierProvider>(context);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
          title: Text("Purchase Orders"),
        ),
        body: SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              pOders != null
                  ? Container(
                      padding: EdgeInsets.all(8),
                      color: Colors.white,
                      child: _getTable(pOders))
                  : CircularProgressIndicator(),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        )),
      )
    ]);
  }

  Widget _getTable(List<PurchaseOrder> reqs) {
    return Container(
      child: HorizontalDataTable(
        leftHandSideColumnWidth: 70,
        rightHandSideColumnWidth: 600,
        isFixedHeader: true,
        headerWidgets: _getTitleWidget(),
        leftSideItemBuilder: _generateFirstColumnRow,
        rightSideItemBuilder: _generateRightHandSideColumnRow,
        itemCount: reqs.length,
        rowSeparatorWidget: const Divider(
          color: Colors.black54,
          height: 1.0,
          thickness: 0.0,
        ),
        leftHandSideColBackgroundColor: Color(0xFFFFFFFF),
        rightHandSideColBackgroundColor: Color(0xFFFFFFFF),
      ),
      height: MediaQuery.of(context).size.height * 0.7,
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget('Order No', 100),
      _getTitleItemWidget('Date', 100),
      _getTitleItemWidget('Total', 100),
      _getTitleItemWidget('Action', 100),
      // _getTitleItemWidget('Status', 70),
      // _getTitleItemWidget('Action', 80),
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
    final pOders = Provider.of<List<PurchaseOrder>>(context);

    return Container(
      child: Text(pOders[index].reqNo),
      width: 70,
      height: 52,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    final pOders = Provider.of<List<PurchaseOrder>>(context);
    return Row(
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[Text(pOders[index].date)],
          ),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(pOders[index].totPrice.toString()),
          width: 85,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: FlatButton(
            child: Row(
              children: [
                Text(
                  'View Order',
                  style: TextStyle(color: Colors.green),
                ),
                Icon(
                  Icons.article,
                  size: 28,
                  color: Colors.green,
                ),
              ],
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PurchaseOrderDetails(
                          purchaseOrder: pOders[index],
                        )),
              );
            },
          ),
          width: 150,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
      ],
    );
  }
}

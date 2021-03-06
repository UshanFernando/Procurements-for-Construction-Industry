import 'package:construction_procurement_app/Models/Requistion.dart';
import 'package:construction_procurement_app/Models/SupplierQuotation.dart';

import 'package:construction_procurement_app/Providers/SupplierProvider.dart';
import 'package:construction_procurement_app/Screens/PurchaseOrder.dart';
import 'package:construction_procurement_app/Widgets/RaisedGredientBtn.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:provider/provider.dart';

class SupplierList extends StatefulWidget {
  @override
  _SupplierListState createState() => _SupplierListState();
  final Requisition requisition;

  //requiring the list of todos
  SupplierList({Key key, @required this.requisition}) : super(key: key);
}

class _SupplierListState extends State<SupplierList> {
  final reqNoController = TextEditingController();
  final dateController = TextEditingController();
  final qtyController = TextEditingController();
  final descController = TextEditingController();
  final priceController = TextEditingController();
  final locationController = TextEditingController();
  bool sort = false;
  List<bool> checked = new List();
  @override
  Widget build(BuildContext context) {
    //final reqSupProvider = Provider.of<SupplierProvider>(context);
    final supQuotations = Provider.of<List<SupplierQuotation>>(context);
    final supProvider = Provider.of<SupplierProvider>(context);
    supProvider.getSupQ(widget.requisition.reqNo);
    int qCount = supProvider.supplierQuotationsOnly.length;
    for (int x = 0; x < qCount; x++) {
      checked.add(false);
    }

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
          title: Text("Select Supplier Quotations"),
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
                      if (sort) {
                        supProvider.sortName();
                        sort = false;
                      } else {
                        supProvider.sortProduct();
                        sort = true;
                      }
                    }),
              ),
              Container(
                  padding: EdgeInsets.all(8),
                  color: Colors.white,
                  child: _getTable(supProvider.supplierQuotationsOnly)),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PurchaseOrder()),
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

  Widget _getTable(List<SupplierQuotation> pos) {
    return Container(
      child: HorizontalDataTable(
        leftHandSideColumnWidth: 30,
        rightHandSideColumnWidth: 600,
        isFixedHeader: true,
        headerWidgets: _getTitleWidget(),
        leftSideItemBuilder: _generateFirstColumnRow,
        rightSideItemBuilder: _generateRightHandSideColumnRow,
        itemCount: pos.length,
        rowSeparatorWidget: const Divider(
          color: Colors.black54,
          height: 1.0,
          thickness: 0.0,
        ),
        leftHandSideColBackgroundColor: Color(0xFFFFFFFF),
        rightHandSideColBackgroundColor: Color(0xFFFFFFFF),
      ),
      height: MediaQuery.of(context).size.height * 0.5,
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget('', 20),
      _getTitleItemWidget('Supplier \nName', 80),
      _getTitleItemWidget('Detail', 80),
      _getTitleItemWidget('Product Code', 80),
      _getTitleItemWidget('QTY', 70),
      _getTitleItemWidget('Check', 50),
      // _getTitleItemWidget('Total', 100),
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
    return Container(
      child: Text((index + 1).toString()),
      width: 20,
      height: 52,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    final supProvider = Provider.of<SupplierProvider>(context);

    List<SupplierQuotation> sqList = supProvider.supplierQuotationsOnly;

    return Row(
      children: <Widget>[
        Container(
          child: Text(sqList[index].supplier.supplierName),
          width: 80,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(sqList[index].product.desc),
          width: 80,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(sqList[index].product.code),
          width: 80,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(sqList[index].product.price.toString()),
          width: 70,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Checkbox(
            onChanged: (bool value) {
              setState(() {
                checked[index] = value;
              });
              value
                  ? supProvider.addSQ(sqList[index])
                  : supProvider.deleteSQ(sqList[index]);
            },
            value: checked[index],
            activeColor: Color(0xFF6200EE),
          ),
          width: 50,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
      ],
    );
  }
}

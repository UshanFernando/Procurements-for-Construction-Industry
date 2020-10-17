import 'package:construction_procurement_app/Models/PurchaseOrderItem.dart';
import 'package:construction_procurement_app/Providers/SupplierProvider.dart';
import 'package:construction_procurement_app/Screens/HomeScreen.dart';
import 'package:construction_procurement_app/Widgets/RaisedGredientBtn.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:provider/provider.dart';

class PurchaseOrderComplete extends StatefulWidget {
  PurchaseOrderComplete({Key key}) : super(key: key);

  @override
  _PurchaseOrderCompleteState createState() => _PurchaseOrderCompleteState();
}

class _PurchaseOrderCompleteState extends State<PurchaseOrderComplete> {
  final totalController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final supProvider = Provider.of<SupplierProvider>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if (supProvider.poTotal != -1) {
      totalController.text = supProvider.poTotal.toString();
    } else {
      totalController.text = null;
    }
    return Stack(children: <Widget>[
      Image.asset(
        "Assets/bg.jpg",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              leading: new IconButton(
                  icon: new Icon(Icons.close),
                  onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen())),
                                supProvider.finishPO(),
                      }),
              // Here we take the value from the MyHomePage object that was created by
              // the App.build method, and use it to set our appbar title.
              title: Text("Purchase Order Complete"),
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
                  supProvider.poItems.length != 0
                      ? Container(
                          padding: EdgeInsets.all(8),
                          color: Colors.white,
                          child: _getTable(supProvider.poItems))
                      : CircularProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 50,
                        width: width * 0.5,
                        child: TextField(
                          controller: totalController,
                          decoration: new InputDecoration(
                            fillColor: Colors.white,
                            hintText: "Order Total",
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.4,
                        height: 50,
                        child: RaisedGradientButton(
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
                                  'Calculate',
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
                              supProvider.calcToatal();
                            }),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: width * 0.9,
                    height: 40,
                    child: RaisedGradientButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.send_and_archive,
                              color: Colors.white,
                              size: 28,
                            ),
                            SizedBox(width: 6),
                            Text(
                              'Confirm Order',
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
                          supProvider.sendOrder();
                          showDialog(
                              context: context,
                              child: new AlertDialog(
                                title: new Text(
                                  "Order Confirmed!",
                                  style: TextStyle(color: Colors.green),
                                ),
                                content: Image.asset(
                                  'Assets/success.png',
                                  height: 100,
                                ),
                                actions: [
                                  FlatButton(
                                    onPressed: () => Navigator.pop(
                                        context, true), // passing true
                                    child: Text('Ok'),
                                  ),
                                ],
                              )).whenComplete(() => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()),
                              ));
                        }),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      width: width * 0.9,
                      height: 40,
                      child: RaisedGradientButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.drafts,
                                color: Colors.white,
                                size: 28,
                              ),
                              SizedBox(width: 6),
                              Text(
                                'Save Draft      ',
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
                            supProvider.saveDraft();
                            showDialog(
                                context: context,
                                child: new AlertDialog(
                                  title: new Text(
                                    "Draft Saved!",
                                    style: TextStyle(color: Colors.green),
                                  ),
                                  content: Image.asset(
                                    'Assets/success.png',
                                    height: 100,
                                  ),
                                  actions: [
                                    FlatButton(
                                      onPressed: () => Navigator.pop(
                                          context, true), // passing true
                                      child: Text('Ok'),
                                    ),
                                  ],
                                ));
                          })),
                ],
              ),
            )),
          ))
    ]);
  }

  Widget _getTable(List<PurchaseOrderItem> pos) {
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
      _getTitleItemWidget('Product\nName', 100),
      _getTitleItemWidget('Product Code', 90),
      _getTitleItemWidget('QTY', 70),
      _getTitleItemWidget('Price', 68),
      _getTitleItemWidget('Discount', 70),
      _getTitleItemWidget('Total', 100),
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
    List<PurchaseOrderItem> items = supProvider.poItems;
    return Row(
      children: <Widget>[
        Container(
          child: Text(items[index].quotation.product.desc),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(items[index].quotation.product.code),
          width: 90,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(items[index].quotation.product.qty.toString()),
          width: 70,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(items[index].quotation.product.price.toString()),
          width: 70,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(items[index].quotation.product.discount.toString()),
          width: 70,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(((items[index].quotation.product.qty *
                      items[index].quotation.product.price) -
                  items[index].quotation.product.discount)
              .toString()),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
      ],
    );
  }
}

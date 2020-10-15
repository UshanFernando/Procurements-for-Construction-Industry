import 'package:construction_procurement_app/Models/Requistion.dart';
import 'package:construction_procurement_app/Widgets/RaisedGredientBtn.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:provider/provider.dart';

class DeliveryReconciliate extends StatefulWidget {
  @override
  _DeliveryReconciliateState createState() => _DeliveryReconciliateState();
}

class _DeliveryReconciliateState extends State<DeliveryReconciliate> {
  @override
  Widget build(BuildContext context) {
    final requsitions = Provider.of<List<Requisition>>(context);
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
        body: Center(
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
                        //onChanged: (value) => reqProvider.changeQty(value),
                        //controller: qtyController,
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
                              //onChanged: (value) => reqProvider.changeQty(value),
                              //controller: qtyController,
                              keyboardType: TextInputType.number,
                              decoration: new InputDecoration(
                                hintText: "Name",
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
                              //onChanged: (value) => reqProvider.changeQty(value),
                              //controller: qtyController,
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
                          onPressed: () {},
                        ),
                        width: 30,
                        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                        alignment: Alignment.centerLeft,
                      ),
                    ]),
                    SizedBox(height: 10),
                    Container(
                        margin: EdgeInsets.all(8),
                        //padding: EdgeInsets.all(8),
                        color: Colors.white,
                        child: Expanded(child: _getTable(requsitions))),
                    SizedBox(height: 10),
                    RaisedGradientButton(
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          // reqProvider.saveProduct();
                          // if (reqProvider.reqNo == null) {
                          //   reqProvider.changeReqNo(reqNoController.text);
                          //   reqProvider.changeDate(dateController.text);
                          //   reqProvider.changeLocation(locationController.text);
                          // }

                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => RequsitionDetails()),
                          // );
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

  Widget _getTable(List<Requisition> reqs) {
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
      height: MediaQuery.of(context).size.height * 0.4,
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget('Req No', 100),
      _getTitleItemWidget('Requester', 100),
      _getTitleItemWidget('Total', 70),
      _getTitleItemWidget('Needed by Date', 100),
      _getTitleItemWidget('Status', 70),
      _getTitleItemWidget('Action', 80),
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
    final requsitions = Provider.of<List<Requisition>>(context);
    return Container(
      child: Text(requsitions[index].reqNo),
      width: 70,
      height: 52,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    final requsitions = Provider.of<List<Requisition>>(context);
    return Row(
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              // Icon(
              //     user.userInfo[index].status
              //         ? Icons.notifications_off
              //         : Icons.notifications_active,
              //     color:
              //         user.userInfo[index].status ? Colors.red : Colors.green),
              Text('Nimal Lansa')
            ],
          ),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(requsitions[index].totPrice.toString()),
          width: 70,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(requsitions[index].date),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: requsitions[index].status != null
              ? Text(
                  requsitions[index].status,
                  style: TextStyle(
                      color: requsitions[index].status == 'Approved'
                          ? Colors.green
                          : requsitions[index].status == 'Declined'
                              ? Colors.red
                              : Colors.orange),
                )
              : Text('N/A'),
          width: 65,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        if (requsitions[index].status != null &&
            requsitions[index].status == 'Approved')
          Container(
            child: IconButton(
              icon: Icon(Icons.add_circle),
              onPressed: () {},
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

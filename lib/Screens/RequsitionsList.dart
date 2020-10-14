import 'package:construction_procurement_app/Models/Product.dart';
import 'package:construction_procurement_app/Models/Requistion.dart';
import 'package:construction_procurement_app/Providers/RequisitionProvider.dart';
import 'package:construction_procurement_app/Screens/HomeScreen.dart';
import 'package:construction_procurement_app/Screens/PurchaseRequisition.dart';
import 'package:construction_procurement_app/Widgets/RaisedGredientBtn.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:provider/provider.dart';

class RequsitionsList extends StatefulWidget {
  RequsitionsList({Key key}) : super(key: key);

  @override
  _RequsitionsListState createState() => _RequsitionsListState();
}

class _RequsitionsListState extends State<RequsitionsList> {
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    startDateController.dispose();
    endDateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final requsitions = Provider.of<List<Requisition>>(context);
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
          title: Text("Purchase Requisitions"),
        ),
        body: SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: width * 0.4,
                    height: 50,
                    child: TextField(
                      // onChanged: (value) => reqProvider.changeLocation(value),
                      // controller: startDateController,
                      decoration: new InputDecoration(
                          hintText: "Start Date", fillColor: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.4,
                    height: 50,
                    child: TextField(
                      // onChanged: (value) => reqProvider.changeLocation(value),
                      // controller: startDateController,
                      decoration: new InputDecoration(
                          hintText: "End Date", fillColor: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 200,
                height: 40,
                child: RaisedGradientButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.bar_chart,
                          color: Colors.white,
                          size: 28,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'View Report',
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
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  padding: EdgeInsets.all(8),
                  color: Colors.white,
                  child: _getTable(requsitions)),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        )),
      )
    ]);
  }

  // Widget createTable(List<Requisition> products) {
  //   List<TableRow> rows = [];
  //   rows.add(TableRow(children: [
  //     Text("Requsition No",
  //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
  //     Text("Requester",
  //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
  //     Text("Description",
  //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
  //     Text("Needed by date",
  //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
  //     Text("Status",
  //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
  //   ]));
  //   for (Requisition p in products) {
  //     rows.add(TableRow(children: [
  //       Text(
  //         p.reqNo,
  //       ),
  //       Text('Site Manager 101'),
  //       Text(p.location),
  //       Text(p.date),
  //       Text('Approved')
  //     ]));
  //   }
  //   // print(products);
  //   return Table(
  //     children: rows,
  //     border: TableBorder.all(width: 1),
  //   );
  // }

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
      height: MediaQuery.of(context).size.height * 0.7,
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

import 'dart:math';

import 'package:construction_procurement_app/Models/Requistion.dart';
import 'package:construction_procurement_app/Providers/RequisitionProvider.dart';
import 'package:construction_procurement_app/Screens/SupplierList.dart';
import 'package:construction_procurement_app/Widgets/RaisedGredientBtn.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RequsitionsList extends StatefulWidget {
  RequsitionsList({Key key}) : super(key: key);

  @override
  _RequsitionsListState createState() => _RequsitionsListState();
}

class _RequsitionsListState extends State<RequsitionsList> {
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  List<Requisition> reqs;
  @override
  void initState() {
    super.initState();
    reqs = new List();
  }

  @override
  void dispose() {
    super.dispose();
    startDateController.dispose();
    endDateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reqProvider = Provider.of<RequisitionProvider>(context);
    reqProvider.getReqs();
    var requsitions = reqProvider.reqsFiltered;
    if (reqs == null || reqs.length == 0) reqs = requsitions;

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
                    height: 45,
                    child: DateTimeField(
                      controller: startDateController,
                      decoration: new InputDecoration(
                        fillColor: Colors.white,
                        hintText: "Start Date",
                      ),
                      format: DateFormat("dd-MM-yyyy"),
                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                            context: context,
                            fieldHintText: 'Start Date',
                            helpText: 'Start Date',
                            firstDate: DateTime(2020),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                      },
                    ),
                  ),
                  SizedBox(
                    width: width * 0.4,
                    height: 45,
                    child: DateTimeField(
                      controller: endDateController,
                      decoration: new InputDecoration(
                        fillColor: Colors.white,
                        hintText: "End Date",
                      ),
                      format: DateFormat("dd-MM-yyyy"),
                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                            context: context,
                            fieldHintText: 'End Date',
                            helpText: 'End Date',
                            firstDate: DateTime(2020),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                      },
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
                      if (startDateController.text.trim() == '' ||
                          endDateController.text.trim() == '') {
                        print('empty');
                        reqProvider.getReqs();
                        setState(() {
                          reqs = null;
                          requsitions.clear();
                          reqProvider.getReqs();
                          requsitions = reqProvider.reqsFiltered;
                        });
                      } else {
                        filterReqs();
                      }
                    }),
              ),
              SizedBox(
                height: 10,
              ),
              requsitions != null
                  ? Container(
                      padding: EdgeInsets.all(8),
                      color: Colors.white,
                      child: _getTable(reqs == null ? requsitions : reqs))
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

  void filterReqs() {
    DateFormat format = DateFormat("dd-MM-yyyy");
    DateTime startDate = format.parse(startDateController.text);
    DateTime endDate = format.parse(endDateController.text);
    setState(() {
      reqs.removeWhere((e) => !(format.parse(e.date).isAfter(startDate) &&
          format.parse(e.date).isBefore(endDate)));
    });
    print('filter state');
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
      height: MediaQuery.of(context).size.height * 0.7,
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget('Req No', 100),
      _getTitleItemWidget('Requester', 100),
      _getTitleItemWidget('Total', 85),
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
    return Container(
      child: Text(reqs[index].reqNo),
      width: 70,
      height: 52,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {

    return Row(
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[Text('Site Manager')],
          ),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(reqs[index].totPrice.toString()),
          width: 85,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(reqs[index].date),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: reqs[index].status != null
              ? Text(
                  reqs[index].status,
                  style: TextStyle(
                      color: reqs[index].status == 'Approved'
                          ? Colors.green
                          : reqs[index].status == 'Rejected'
                              ? Colors.red
                              : Colors.orange),
                )
              : Text('N/A'),
          width: 65,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        if (reqs[index].status != null &&
            reqs[index].status == 'Approved')
          Container(
            child: IconButton(
              icon: Icon(Icons.add_circle),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SupplierList(
                            requisition: reqs[index],
                          )),
                );
              },
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

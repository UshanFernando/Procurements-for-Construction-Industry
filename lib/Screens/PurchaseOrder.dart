import 'package:construction_procurement_app/Models/PurchaseOrderItem.dart';
import 'package:construction_procurement_app/Models/Requistion.dart';
import 'package:construction_procurement_app/Models/SupplierQuotation.dart';
import 'package:construction_procurement_app/Providers/RequisitionProvider.dart';
import 'package:construction_procurement_app/Providers/SupplierProvider.dart';
import 'package:construction_procurement_app/Screens/HomeScreen.dart';
import 'package:construction_procurement_app/Screens/PurchaseOrderComplete.dart';
import 'package:construction_procurement_app/Screens/RequisitionDetails.dart';
import 'package:construction_procurement_app/Widgets/RaisedGredientBtn.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class PurchaseOrder extends StatefulWidget {
  @override
  _PurchaseOrderState createState() => _PurchaseOrderState();
}

class _PurchaseOrderState extends State<PurchaseOrder> {
  final supNameController = TextEditingController();
  final itemQuantityController = TextEditingController();
  final itemNameController = TextEditingController();
  final itemPriceController = TextEditingController();
  final itemDiscountController = TextEditingController();
  final itemCodeController = TextEditingController();
  final itemTotalController = TextEditingController();
  final locationController = TextEditingController();
  final supplierTermController = TextEditingController();
  final supplierPhoneController = TextEditingController();
  final supplierEmailController = TextEditingController();
  final diliveryAddressController = TextEditingController();
  final diliveryPhoneController = TextEditingController();
  final diliveryDateController = TextEditingController();
  final requestedByController = TextEditingController();
  final approvedByController = TextEditingController();
  final departmentController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    supNameController.dispose();
    itemQuantityController.dispose();
    itemNameController.dispose();
    itemPriceController.dispose();
    itemDiscountController.dispose();
    itemTotalController.dispose();
    itemCodeController.dispose();
    locationController.dispose();
    supplierTermController.dispose();
    supplierPhoneController.dispose();
    supplierEmailController.dispose();
    diliveryDateController.dispose();
    requestedByController.dispose();
    approvedByController.dispose();
    departmentController.dispose();
    diliveryAddressController.dispose();
    diliveryPhoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final supProvider = Provider.of<SupplierProvider>(context);
    final reqProvider = Provider.of<RequisitionProvider>(context);

    SupplierQuotation supplierQuotation = supProvider.getSelectedQ();
    if (supplierQuotation != null) {
      supNameController.text = supplierQuotation.supplier.supplierName;
      itemNameController.text = supplierQuotation.product.desc;
      itemPriceController.text = supplierQuotation.product.price.toString();
      itemQuantityController.text = supplierQuotation.product.qty.toString();
      itemCodeController.text = supplierQuotation.product.code.toString();
      itemDiscountController.text =
          supplierQuotation.product.discount.toString();
      itemTotalController.text =
          ((supplierQuotation.product.price * supplierQuotation.product.qty) -
                  supplierQuotation.product.discount)
              .toString();
      locationController.text =
          supplierQuotation.requisition.location.toString();
      supplierTermController.text =
          supplierQuotation.supplier.supplierTerm.toString();
      supplierPhoneController.text =
          supplierQuotation.supplier.phoneNo.toString();
      supplierEmailController.text =
          supplierQuotation.supplier.email.toString();
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
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Purchase Order"),
        ),
        body: supProvider.supplierQuotations.length != 0
            ? SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.only(
                          top: 30,
                          left: 25,
                          right: 25,
                        ),
                        child: labelText('Purchase Order Address')),
                    Container(
                      height: 50,
                      margin: EdgeInsets.only(
                        left: 25,
                        right: 25,
                      ),
                      child: TextField(
                        controller: locationController,
                        // onChanged: (value) => reqProvider.changeReqNo(value),
                        decoration: new InputDecoration(
                          hintText: "Purchase Order Address",
                        ),
                      ),
                    ),
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
                          labelText('Supplier Name'),
                          SizedBox(
                            height: 50,
                            child: TextField(
                              onChanged: (value) =>
                                  reqProvider.changeQty(value),
                              controller: supNameController,
                              keyboardType: TextInputType.number,
                              enabled: false,
                              decoration: new InputDecoration(
                                hintText: "Supplier",
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          labelText('Supplier Term'),
                          SizedBox(
                            height: 50,
                            child: TextField(
                              controller: supplierTermController,
                              decoration: new InputDecoration(
                                hintText: "Term",
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          labelText('Supplier Phone Number'),
                          SizedBox(
                            height: 50,
                            child: TextField(
                              controller: supplierPhoneController,
                              decoration: new InputDecoration(
                                hintText: "Phone Number",
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          labelText('Supplier Email'),
                          SizedBox(
                            height: 50,
                            child: TextField(
                              controller: supplierEmailController,
                              keyboardType: TextInputType.number,
                              decoration: new InputDecoration(
                                hintText: "Email",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                    width: width * 0.38,
                                    child: labelText('Product Name')),
                                SizedBox(
                                    width: width * 0.38,
                                    child: labelText('Product Qty')),
                              ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 50,
                                width: width * 0.38,
                                child: TextField(
                                  onChanged: (value) =>
                                      reqProvider.changeDescription(value),
                                  controller: itemNameController,
                                  decoration: new InputDecoration(
                                    hintText: "Item Name",
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              SizedBox(
                                height: 50,
                                width: width * 0.38,
                                child: TextField(
                                  controller: itemQuantityController,
                                  onChanged: (value) =>
                                      reqProvider.changePrice(value),
                                  keyboardType: TextInputType.number,
                                  decoration: new InputDecoration(
                                    hintText: "Quantity",
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                    width: width * 0.38,
                                    child: labelText('Product Code')),
                                SizedBox(
                                    width: width * 0.38,
                                    child: labelText('Product Price')),
                              ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 50,
                                width: width * 0.38,
                                child: TextField(
                                  onChanged: (value) =>
                                      reqProvider.changeDescription(value),
                                  controller: itemCodeController,
                                  decoration: new InputDecoration(
                                    hintText: "Item Code",
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              SizedBox(
                                height: 50,
                                width: width * 0.38,
                                child: TextField(
                                  controller: itemPriceController,
                                  onChanged: (value) =>
                                      reqProvider.changePrice(value),
                                  keyboardType: TextInputType.number,
                                  decoration: new InputDecoration(
                                    hintText: "Price",
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                    width: width * 0.38,
                                    child: labelText('Discount')),
                                SizedBox(
                                    width: width * 0.38,
                                    child: labelText('Total')),
                              ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 50,
                                width: width * 0.38,
                                child: TextField(
                                  controller: itemDiscountController,
                                  decoration: new InputDecoration(
                                    hintText: "Discount",
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              SizedBox(
                                height: 50,
                                width: width * 0.38,
                                child: TextField(
                                  controller: itemTotalController,
                                  keyboardType: TextInputType.number,
                                  decoration: new InputDecoration(
                                    hintText: "Total",
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
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
                          TextField(
                            controller: diliveryAddressController,
                            maxLines: 3,
                            keyboardType: TextInputType.multiline,
                            decoration: new InputDecoration(
                              fillColor: Colors.white,
                              hintText: "Dilivery Address",
                            ),
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            height: 50,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: diliveryPhoneController,
                              decoration: new InputDecoration(
                                hintText: "Phone",
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 50,
                                width: width * 0.38,
                                child: DateTimeField(
                                  controller: diliveryDateController,
                                  decoration: new InputDecoration(
                                    fillColor: Colors.white,
                                    hintText: "Dilivery Date",
                                  ),
                                  format: DateFormat("yyyy-MM-dd"),
                                  onShowPicker: (context, currentValue) {
                                    return showDatePicker(
                                        context: context,
                                        fieldHintText: 'Dilivery Date',
                                        helpText: 'Dilivery Date',
                                        firstDate: DateTime(2020),
                                        initialDate:
                                            currentValue ?? DateTime.now(),
                                        lastDate: DateTime(2100));
                                  },
                                ),
                              ),
                              SizedBox(height: 10),
                              SizedBox(
                                height: 50,
                                width: width * 0.38,
                                child: TextField(
                                  controller: requestedByController,
                                  onChanged: (value) =>
                                      reqProvider.changePrice(value),
                                  decoration: new InputDecoration(
                                    fillColor: Colors.white,
                                    hintText: "Requested By",
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 50,
                                width: width * 0.38,
                                child: TextField(
                                  controller: approvedByController,
                                  decoration: new InputDecoration(
                                    fillColor: Colors.white,
                                    hintText: "Approved By",
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              SizedBox(
                                height: 50,
                                width: width * 0.38,
                                child: TextField(
                                  controller: departmentController,
                                  decoration: new InputDecoration(
                                    fillColor: Colors.white,
                                    hintText: "Department",
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 50),
                      child: supProvider.supplierQuotations.length - 1 ==
                              supProvider.selectdQIndex
                          ? RaisedGradientButton(
                              child: Text(
                                'Finish',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                if (validate()) {
                                  supProvider.addPO(PurchaseOrderItem(
                                      quotation: supplierQuotation,
                                      diliveryAddress:
                                          diliveryAddressController.text,
                                      diliveryDate: diliveryDateController.text,
                                      department: departmentController.text,
                                      approvedBy: approvedByController.text,
                                      phone: supplierPhoneController.text,
                                      requestedBy: requestedByController.text));
                                  supProvider.finish();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PurchaseOrderComplete()),
                                  );
                                } else {
                                  showDialog(
                                      context: context,
                                      child: new AlertDialog(
                                        title: new Text(
                                          "Incomplete Dilivery Info",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        content: new Text(
                                            "Please Complete Dilivery Information!"),
                                        actions: [
                                          FlatButton(
                                            onPressed: () => Navigator.pop(
                                                context, true), // passing true
                                            child: Text('Ok'),
                                          ),
                                        ],
                                      ));
                                }
                              })
                          : RaisedGradientButton(
                              child: Text(
                                'Next',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                validate()
                                    ? supProvider.addPO(PurchaseOrderItem(
                                        quotation: supplierQuotation,
                                        diliveryAddress:
                                            diliveryAddressController.text,
                                        diliveryDate:
                                            diliveryDateController.text,
                                        department: departmentController.text,
                                        approvedBy: approvedByController.text,
                                        phone: supplierPhoneController.text,
                                        requestedBy:
                                            requestedByController.text))
                                    : showDialog(
                                        context: context,
                                        child: new AlertDialog(
                                          title: new Text(
                                            "Incomplete Dilivery Info",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          content: new Text(
                                              "Please Complete Dilivery Information!"),
                                          actions: [
                                            FlatButton(
                                              onPressed: () => Navigator.pop(
                                                  context,
                                                  true), // passing true
                                              child: Text('Ok'),
                                            ),
                                          ],
                                        ));
                              }),
                    ),
                  ],
                ),
              )
            : Container(
                width: width,
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(8),
                color: Colors.red,
                child: Text(
                  'No Quatations Selected! \nCan\'t Continue!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
        // This trailing comma makes auto-formatting nicer for build methods.
      )
    ]);
  }

  bool validate() {
    if (diliveryDateController.text.trim().length == 0 ||
        diliveryPhoneController.text.trim().length == 0 ||
        diliveryAddressController.text.trim().length == 0 ||
        requestedByController.text.trim().length == 0 ||
        approvedByController.text.trim().length == 0 ||
        departmentController.text.trim().length == 0) {
      return false;
    }
    return true;
  }

  Widget labelText(String text) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

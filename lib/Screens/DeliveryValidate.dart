import 'dart:io';
import 'package:construction_procurement_app/Providers/DeliveryManagerProvider.dart';
import 'package:construction_procurement_app/Screens/DeliveryReconciliate.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:construction_procurement_app/Widgets/RaisedGredientBtn.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class DeliveryValidate extends StatefulWidget {
  @override
  _DeliveryValidateState createState() => _DeliveryValidateState();
}

class _DeliveryValidateState extends State<DeliveryValidate> {
  File _imageFile;
  var isButtonDisabled = true;

  final qtyAllController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    qtyAllController.dispose();
  }

  ///NOTE: Only supported on Android & iOS
  ///Needs image_picker plugin {https://pub.dev/packages/image_picker}
  final picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }

  Future uploadImageToFirebase(BuildContext context) async {
    final delProvider =
        Provider.of<DeliveryManagerProvider>(context, listen: false);
    String fileName = basename(_imageFile.path);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL().then((value) => {
          delProvider.changeImageUrl(value),
          delProvider.changeButtonDisable(false),
          _showMyDialog(context, "succes", delProvider.isButtonDisable,
              "Delevery Quantity is Accepted")
        });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final delProvider =
        Provider.of<DeliveryManagerProvider>(context, listen: false);
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
        body: SingleChildScrollView(
          child: Center(
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
                          "Check quantity",
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
                          onChanged: (value) => delProvider.changeAllQty(value),
                          controller: qtyAllController,
                          keyboardType: TextInputType.number,
                          decoration: new InputDecoration(
                            hintText: "Quantity",
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: height * (2.1 / 4),
                        child: Expanded(
                          child: Container(
                            //height: double.infinity,
                            margin: const EdgeInsets.only(
                                left: 10.0, right: 10.0, top: 10.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: _imageFile != null
                                  ? Image.file(_imageFile)
                                  : FlatButton(
                                      child: Icon(
                                        Icons.add_a_photo,
                                        size: 50,
                                      ),
                                      onPressed: pickImage,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 20,
                          left: 20.0,
                          right: 20.0,
                        ),
                        decoration: BoxDecoration(
                            // gradient: LinearGradient(
                            //   colors: [yellow, orange],
                            // ),
                            borderRadius: BorderRadius.circular(30.0)),
                        child: RaisedGradientButton(
                          onPressed: () => {
                            uploadImageToFirebase(context),
                            delProvider.changeAllQty(qtyAllController.text)
                          },
                          child: Text(
                            "Validate",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      )
    ]);
    ;
  }

  Future<void> _showMyDialog(context, type, isDisable, message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Icon(
              type == "succes" ? Icons.done_rounded : Icons.error,
              size: 50,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(isDisable ? "Please wait..." : "Ok"),
              onPressed: () {
                if (!isDisable) {
                  //Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DeliveryReconciliate()),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}

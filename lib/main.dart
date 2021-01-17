import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_add_retrive_data/ListScreen.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController namecontroller = new TextEditingController();
  TextEditingController brandcontroller = new TextEditingController();
  TextEditingController pricecontroller = new TextEditingController();
  TextEditingController imageUrlcontroller = new TextEditingController();

  Map<String ,dynamic> productAdd;
  CollectionReference ref =Firestore.instance.collection("products");


  addProduct(){

    productAdd={
      "name":namecontroller.text,
      "brand": brandcontroller.text,
      "price":pricecontroller.text,
      "imageurl":imageUrlcontroller.text,
    };

    ref.add(productAdd).whenComplete(() => print("Product To ADDED"));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(icon: Icon(Icons.next_week_outlined, color: Colors.white,),
              onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) =>ListScreen()));
              }),
        ],
      ),
      backgroundColor: Colors.indigo,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30.0,),
              Text("Mobile CMS",
                style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
                textAlign: TextAlign.center,),
              SizedBox(height: 50.0,),

              _buildTextField(namecontroller,  "Name"),
              SizedBox(height: 25.0,),
              _buildTextField(brandcontroller,  "Brand"),
              SizedBox(height: 25.0,),
              _buildTextField(pricecontroller,  "Price"),
              SizedBox(height: 25.0,),
              _buildTextField(imageUrlcontroller,  "Image Url"),
              SizedBox(height: 25.0,),

              FlatButton(onPressed: (){
                addProduct();
              },
                child: Text("ADD TO THE DATABASE"),
                color: Colors.green,),

            ],
          ),
        ),
      ),
    );
  }

  _buildTextField(TextEditingController controller,
      String labelText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.blueAccent, border: Border.all(color: Colors.blue)),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.white),
            // prefix: Icon(icon),
            border: InputBorder.none),
      ),
    );
  }

}

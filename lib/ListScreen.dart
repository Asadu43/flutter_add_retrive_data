import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController brandcontroller = new TextEditingController();
  TextEditingController pricecontroller = new TextEditingController();
  TextEditingController imageUrlcontroller = new TextEditingController();

  CollectionReference ref =Firestore.instance.collection("products");

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
      ),
      body: StreamBuilder(
        stream: ref.snapshots(),
        builder: (_,AsyncSnapshot<QuerySnapshot>  snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index){
                var documentsnapshot = snapshot.data.documents[index];
                return ListTile(
                  title: Text(documentsnapshot['name'],style: TextStyle(
                    color: Colors.white,
                  ),),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(documentsnapshot['brand'],style: TextStyle(color: Colors.grey),),
                      Text(documentsnapshot['price'],style: TextStyle(color: Colors.grey),),
                    ],
                  ),
                  trailing: Image.network(documentsnapshot['imageurl'],
                    height: 100,width: 100,fit: BoxFit.cover,),
                  leading: IconButton(
                    onPressed: (){

                      namecontroller.text = documentsnapshot['name'];
                      brandcontroller.text = documentsnapshot['brand'];
                      pricecontroller.text = documentsnapshot['price'];
                      imageUrlcontroller.text = documentsnapshot['imageurl'];


                      showDialog(context: context,builder: (context)=>Dialog(
                        child: Container(
                          color: Colors.indigo,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ListView(
                              shrinkWrap: true,
                              children: [

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

                                  snapshot.data.documents[index].reference.updateData({
                                    "name":namecontroller.text,
                                    "brand": brandcontroller.text,
                                    "price":pricecontroller.text,
                                    "imageurl":imageUrlcontroller.text,
                                  }).whenComplete(() => Navigator.pop(context));
                                },
                                  child: Text("Update Data"),
                                  color: Colors.green,),
                                SizedBox(height: 25.0,),

                                FlatButton(onPressed: (){

                                  snapshot.data.documents[index].reference.delete();
                                },
                                  child: Text("Delete Data"),
                                  color: Colors.red,),

                              ],
                            ),
                          ),
                        ),
                      ) );
                    },
                    icon: Icon(Icons.edit,color: Colors.white,),
                  ),
                );
              },
            );
          }else{
            return Text("");
          }
        },
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

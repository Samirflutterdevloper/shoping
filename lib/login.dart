

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  QuerySnapshot<Map<String, dynamic>>? getsnapshot;

  Future<void> Setdata() async {
    try{
      await Firebase.initializeApp();
      await FirebaseFirestore.instance.collection("sam").doc().set({
        "address":addconteoller.text,
        "mobile":mobilecontroller.text
      ,"name":namecontroller.text,
      });
      getsnapshot = await FirebaseFirestore.instance.collection("sam").get();
      setState(() {

      });
    }
    catch(e){
print(e);

    }
  }
  TextEditingController namecontroller=TextEditingController();
  TextEditingController mobilecontroller=TextEditingController();
  TextEditingController addconteoller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller:namecontroller,
            decoration: InputDecoration(
              hintText: ("Enter your name"),
            ),
          ),
          SizedBox(height: h*0.1,),
          TextField(
            keyboardType: TextInputType.number,
            controller:mobilecontroller,
            decoration: InputDecoration(

              hintText: ("Enter your mobile no"),
            ),
          ),
          SizedBox(height: h*0.1,),
          TextField(
            controller:addconteoller,
            decoration: InputDecoration(
              hintText: ("Enter your address"),
            ),
          ),
          SizedBox(height: h*0.1,),
          if(getsnapshot!=null)
         SingleChildScrollView(
           child: Container(
             height: h*0.2,
             width: h*0.2,
             child: ListView.builder(
               physics: AlwaysScrollableScrollPhysics(),
               itemCount: getsnapshot?.docs.length,itemBuilder: (context, index) {
               return Text("name:-${getsnapshot!.docs[index]['name']['mobile']}");


             },),
           ),
         ),
          InkWell(
            onTap:() {
              setState(() {
                Setdata();
              });
            },
            child: Container(
              height: h * 0.2,
              width: h * 0.5,
              decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.all(Radius.circular(h * 0.1))),
              child: Center(child: Text("Submit",style: TextStyle(
                fontSize: h*0.1,color: Colors.white
              ),)),
            ),
          ),

        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:library_manager_project/login.dart';

class Logout extends StatefulWidget {
  const Logout({super.key});

  @override
  State<Logout> createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.blue,
        ),
      ),
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.blue.shade900,
                  height: MediaQuery.of(context).size.height/5,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          ElevatedButton.icon(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back_rounded),
                            label: Text("Back"),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                )
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width/20),
                      Image.asset("assets/icon.png"),
                      SizedBox(width: MediaQuery.of(context).size.width/10),
                      Text("LIBRARY MANAGER",style: TextStyle(fontSize: MediaQuery.of(context).size.height/10,fontWeight: FontWeight.w600),),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.blue.shade800,
                            Colors.blue.shade50
                          ]
                      )
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: MediaQuery.of(context).size.height/5),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: <Widget>[
                            SizedBox(width:MediaQuery.of(context).size.width/3.1),
                            Card(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                                child: Row(
                                  children: [
                                    SizedBox(width:MediaQuery.of(context).size.width/100),
                                    Icon(Icons.logout_outlined,size: MediaQuery.of(context).size.height/15,),
                                    SizedBox(width:MediaQuery.of(context).size.width/100),
                                    Text("Confirm Logout?",style: TextStyle(fontSize: MediaQuery.of(context).size.height/15, fontWeight: FontWeight.w400),),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width:MediaQuery.of(context).size.width/10),
                          ],
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height/10),
                      Row(
                        children: <Widget>[
                          SizedBox(width: MediaQuery.of(context).size.width/2.6),
                          InkWell(
                            onTap: (){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Logged out successfully")),
                              );
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
                            },
                            child: Card(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                                child: Row(
                                  children: [
                                    SizedBox(width:MediaQuery.of(context).size.width/100),
                                    Icon(Icons.check_circle_outline_outlined,size: MediaQuery.of(context).size.height/40,),
                                    Text("Yes",style: TextStyle(fontSize: MediaQuery.of(context).size.height/40, fontWeight: FontWeight.w400),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width/13),
                          InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Card(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                                child: Row(
                                  children: [
                                    SizedBox(width:MediaQuery.of(context).size.width/100),
                                    Icon(Icons.cancel_outlined,size: MediaQuery.of(context).size.height/40,),
                                    Text("No",style: TextStyle(fontSize: MediaQuery.of(context).size.height/40, fontWeight: FontWeight.w400),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width/3),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height/3.7),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

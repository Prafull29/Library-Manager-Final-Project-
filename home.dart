import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'searchBook.dart';
import 'issuedBooks.dart';
import 'issueBook.dart';
import 'package:excel/excel.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/services.dart' show Bytedata, rootBundle;
import 'package:path_provider/path_provider.dart';
import 'logout.dart';
import 'add.dart';
import 'delete.dart';
import 'updateBook.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Future<void>copyFile()async{
    Directory appDocumentsDirectory=await getApplicationDocumentsDirectory();
    String appDocumentsPath=appDocumentsDirectory.path;
    String filePath='$appDocumentsPath/Books.xlsx';
    if(!(await File(filePath).exists())){
      ByteData data=await rootBundle.load("assets/Books.xlsx");
      List<int>bytes=data.buffer.asUint8List();
      await File(filePath).writeAsBytes(bytes);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    copyFile();
  }

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
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Logout()));
                            },
                            icon: Icon(Icons.person_outline_outlined),
                            label: Text("Log Out"),
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
                      SizedBox(height: MediaQuery.of(context).size.height/6),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: <Widget>[
                            SizedBox(width:MediaQuery.of(context).size.width/5),
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchBook()));
                              },
                              child: Card(
                                child: Container(
                                  padding:EdgeInsets.fromLTRB(20, 20, 50, 20),
                                  child: Row(
                                    children: [
                                      Icon(Icons.search, size: MediaQuery.of(context).size.height/20,),
                                      SizedBox(width:MediaQuery.of(context).size.width/100),
                                      Text("Search Book",style: TextStyle(fontSize: MediaQuery.of(context).size.height/20, fontWeight: FontWeight.w500),),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width:MediaQuery.of(context).size.width/10),
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Add()));
                              },
                              child: Card(
                                child: Container(
                                  padding:EdgeInsets.fromLTRB(20, 20, 132, 20),
                                  child: Row(
                                    children: [
                                      Icon(Icons.add_circle_outline_outlined, size: MediaQuery.of(context).size.height/20,),
                                      SizedBox(width:MediaQuery.of(context).size.width/100),
                                      Text("Add Book",style: TextStyle(fontSize: MediaQuery.of(context).size.height/20, fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height/20),
                      Row(
                        children: <Widget>[
                          SizedBox(width:MediaQuery.of(context).size.width/5),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Delete()));
                            },
                            child: Card(
                              child: Container(
                                padding:EdgeInsets.fromLTRB(20, 20, 25, 20),
                                child: Row(
                                  children: [
                                    Icon(Icons.delete_outline_outlined, size: MediaQuery.of(context).size.height/20,),
                                    SizedBox(width:MediaQuery.of(context).size.width/100),
                                    Text("Remove Book",style: TextStyle(fontSize: MediaQuery.of(context).size.height/20, fontWeight: FontWeight.w500),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width:MediaQuery.of(context).size.width/10),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateBook()));
                            },
                            child: Card(
                              child: Container(
                                padding:EdgeInsets.fromLTRB(20, 20, 76, 20),
                                child: Row(
                                  children: [
                                    Icon(Icons.update_outlined, size: MediaQuery.of(context).size.height/20,),
                                    SizedBox(width:MediaQuery.of(context).size.width/100),
                                    Text("Update Book",style: TextStyle(fontSize: MediaQuery.of(context).size.height/20, fontWeight: FontWeight.w500)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height/20),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: <Widget>[
                            SizedBox(width:MediaQuery.of(context).size.width/5),
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>IssueBook()));
                              },
                              child: Card(
                                child: Container(
                                  padding:EdgeInsets.fromLTRB(20, 20, 80, 20),
                                  child: Row(
                                    children: [
                                      Icon(Icons.note_add_outlined, size: MediaQuery.of(context).size.height/20,),
                                      SizedBox(width:MediaQuery.of(context).size.width/100),
                                      Text("Issue Book",style: TextStyle(fontSize: MediaQuery.of(context).size.height/20, fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width:MediaQuery.of(context).size.width/10),
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>IssuedBooks()));
                              },
                              child: Card(
                                child: Container(
                                  padding:EdgeInsets.fromLTRB(20, 20, 6, 20),
                                  child: Row(
                                    children: [
                                      Icon(Icons.list_alt_outlined, size: MediaQuery.of(context).size.height/20,),
                                      SizedBox(width:MediaQuery.of(context).size.width/100),
                                      Text("Issued Books List",style: TextStyle(fontSize: MediaQuery.of(context).size.height/20, fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height/7.5),
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
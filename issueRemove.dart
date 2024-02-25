import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:library_manager_project/home.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/services.dart' show Bytedata, rootBundle;
import 'package:path_provider/path_provider.dart';
import 'addBook.dart';

class IssueRemove extends StatefulWidget {
  late List list;
  IssueRemove({this.list=const[]});

  @override
  State<IssueRemove> createState() => _IssueRemoveState();
}

class _IssueRemoveState extends State<IssueRemove> {
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
                            SizedBox(width:MediaQuery.of(context).size.width/3.4),
                            Card(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                                child: Row(
                                  children: [
                                    SizedBox(width:MediaQuery.of(context).size.width/100),
                                    Text("Remove from Issue List?",style: TextStyle(fontSize: MediaQuery.of(context).size.height/15, fontWeight: FontWeight.w400),),
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
                            onTap: ()async{
                              Directory appDocumentsDirectory=await getApplicationDocumentsDirectory();
                              String appDocumentsPath=appDocumentsDirectory.path;
                              String filePath='$appDocumentsPath/Books.xlsx';
                              var bytes=await File(filePath).readAsBytes();
                              var excel=Excel.decodeBytes(bytes);
                              var sheet=excel.tables.values.first;
                              int i=-1;
                              for(var row in sheet.rows) {
                                i++;
                              }
                              var j=int.parse(widget.list[2].toString());
                              for(int k=1; k<=i; k++)
                                {
                                  var v=sheet.rows[k][2]?.value;
                                  if(int.parse(v.toString())==int.parse(j.toString()))
                                    {
                                      sheet.rows[k][6]?.value="No";
                                      sheet.rows[k][7]?.value="_";
                                      sheet.rows[k][8]?.value="_";
                                      sheet.rows[k][9]?.value="_";
                                    }
                                }
                              var updatedBytes = excel.encode();
                              await File(filePath).writeAsBytes(updatedBytes!);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Book Removed from Issue List")),
                              );
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
                            },
                            child: Card(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                                child: Row(
                                  children: [
                                    SizedBox(width:MediaQuery.of(context).size.width/100),
                                    Icon(Icons.delete_outline_outlined,size: MediaQuery.of(context).size.height/40,),
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





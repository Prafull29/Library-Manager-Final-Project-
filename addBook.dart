import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:excel/excel.dart';
import 'package:library_manager_project/home.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/services.dart' show Bytedata, rootBundle;
import 'package:path_provider/path_provider.dart';

class AddBook extends StatefulWidget {
  late String p;
  AddBook({this.p="NA"});

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {

  TextEditingController searchcontroller1=new TextEditingController();
  TextEditingController searchcontroller2=new TextEditingController();
  TextEditingController searchcontroller3=new TextEditingController();
  TextEditingController searchcontroller4=new TextEditingController();

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
                      SizedBox(height: MediaQuery.of(context).size.height/20),
                      Row(
                        children: [
                          SizedBox(width: MediaQuery.of(context).size.width/3),
                          Card(
                            child: Container(
                              padding:EdgeInsets.fromLTRB(20, 20, 50, 20),
                              child: Row(
                                children: [
                                  Icon(Icons.note_alt_outlined, size: MediaQuery.of(context).size.height/20,),
                                  SizedBox(width:MediaQuery.of(context).size.width/100),
                                  Text("Fill Book Details",style: TextStyle(fontSize: MediaQuery.of(context).size.height/20, fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height/20),
                      Row(
                        children: <Widget>[
                          SizedBox(width: MediaQuery.of(context).size.width/4),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.fromLTRB(15, 5, 124, 5),
                            child: Column(
                              children: [
                                Text("Location:",style: TextStyle(fontSize: MediaQuery.of(context).size.height/25, fontWeight: FontWeight.w400),),
                              ],
                            ),
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width/20),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: (){
                                          },
                                          child: Container(
                                            child: Icon(Icons.add_circle_outline_outlined,color: Colors.black,),
                                            margin: EdgeInsets.fromLTRB(5, 0, 10, 0),
                                          ),
                                        ),
                                        Expanded(
                                          child: TextField(
                                            controller: searchcontroller1,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "Enter Location"
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
                          SizedBox(width: MediaQuery.of(context).size.width/4),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height/20),
                      Row(
                        children: <Widget>[
                          SizedBox(width: MediaQuery.of(context).size.width/4),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.fromLTRB(15, 5, 80, 5),
                            child: Column(
                              children: [
                                Text("Book Name:",style: TextStyle(fontSize: MediaQuery.of(context).size.height/25, fontWeight: FontWeight.w400),),
                              ],
                            ),
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width/20),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: (){
                                          },
                                          child: Container(
                                            child: Icon(Icons.add_circle_outline_outlined,color: Colors.black,),
                                            margin: EdgeInsets.fromLTRB(5, 0, 10, 0),
                                          ),
                                        ),
                                        Expanded(
                                          child: TextField(
                                            controller: searchcontroller2,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "Enter Book Name"
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
                          SizedBox(width: MediaQuery.of(context).size.width/4),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height/20),
                      Row(
                        children: <Widget>[
                          SizedBox(width: MediaQuery.of(context).size.width/4),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.fromLTRB(15, 5, 66, 5),
                            child: Column(
                              children: [
                                Text("Book Author:",style: TextStyle(fontSize: MediaQuery.of(context).size.height/25, fontWeight: FontWeight.w400),),
                              ],
                            ),
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width/20),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: (){
                                          },
                                          child: Container(
                                            child: Icon(Icons.add_circle_outline_outlined,color: Colors.black,),
                                            margin: EdgeInsets.fromLTRB(5, 0, 10, 0),
                                          ),
                                        ),
                                        Expanded(
                                          child: TextField(
                                            controller: searchcontroller3,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "Enter Author Name"
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
                          SizedBox(width: MediaQuery.of(context).size.width/4),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height/20),
                      Row(
                        children: <Widget>[
                          SizedBox(width: MediaQuery.of(context).size.width/4),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.fromLTRB(15, 5, 118, 5),
                            child: Column(
                              children: [
                                Text("Category:",style: TextStyle(fontSize: MediaQuery.of(context).size.height/25, fontWeight: FontWeight.w400),),
                              ],
                            ),
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width/20),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: (){
                                          },
                                          child: Container(
                                            child: Icon(Icons.add_circle_outline_outlined,color: Colors.black,),
                                            margin: EdgeInsets.fromLTRB(5, 0, 10, 0),
                                          ),
                                        ),
                                        Expanded(
                                          child: TextField(
                                            controller: searchcontroller4,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "Enter Category"
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
                          SizedBox(width: MediaQuery.of(context).size.width/4),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height/20),
                      ElevatedButton(onPressed:()async{
                        Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
                        String appDocumentsPath = appDocumentsDirectory.path;
                        String filePath = '$appDocumentsPath/Books.xlsx';
                        var bytes = await File(filePath).readAsBytes();
                        var excel = Excel.decodeBytes(bytes);
                        var sheet = excel.tables.values.first;
                        int i = -1;
                        int flag = 0;
                        for (var row in sheet.rows) {
                          i++;
                        }
                        List list=[];
                        list.add(i+1);
                        if(searchcontroller1.text.toString()!="")
                          {
                            list.add(searchcontroller1.text);
                          }
                        else
                          {
                            list.add("_");
                          }
                        list.add(widget.p);
                        if(searchcontroller2.text.toString()!="")
                        {
                          list.add(searchcontroller2.text);
                        }
                        else
                        {
                          list.add("_");
                        }
                        if(searchcontroller3.text.toString()!="")
                        {
                          list.add(searchcontroller3.text);
                        }
                        else
                        {
                          list.add("_");
                        }
                        if(searchcontroller4.text.toString()!="")
                        {
                          list.add(searchcontroller4.text);
                        }
                        else
                        {
                          list.add("_");
                        }
                        list.add("No");
                        list.add("_");
                        list.add("_");
                        list.add("_");
                        sheet.appendRow(list);
                        var updatedBytes = excel.encode();
                        await File(filePath).writeAsBytes(updatedBytes!);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Book Added")),
                        );
                        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Home()));
                      },
                      child: Text("Add Book")
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height/20),
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

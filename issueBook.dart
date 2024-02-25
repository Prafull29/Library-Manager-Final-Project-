import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:excel/excel.dart';
import 'package:library_manager_project/home.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/services.dart' show Bytedata, rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:library_manager_project/issueConfirm.dart';
import 'renew.dart';

class IssueBook extends StatefulWidget {
  const IssueBook({super.key});

  @override
  State<IssueBook> createState() => _IssueBookState();
}

class _IssueBookState extends State<IssueBook> {
  TextEditingController searchcontroller=new TextEditingController();

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
                      SizedBox(height: MediaQuery.of(context).size.height/10),
                      Row(
                        children: [
                          SizedBox(width: MediaQuery.of(context).size.width/3),
                          Card(
                            child: Container(
                              padding:EdgeInsets.fromLTRB(20, 20, 20, 20),
                              child: Row(
                                children: [
                                  Icon(Icons.note_add_outlined, size: MediaQuery.of(context).size.height/20,),
                                  SizedBox(width:MediaQuery.of(context).size.width/100),
                                  Text("Issue/Renew Book",style: TextStyle(fontSize: MediaQuery.of(context).size.height/20, fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height/10),
                      Row(
                        children: <Widget>[
                          SizedBox(width: MediaQuery.of(context).size.width/4),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.fromLTRB(15, 5, 62, 5),
                            child: Column(
                              children: [
                                Text("Issue book: ",style: TextStyle(fontSize: MediaQuery.of(context).size.height/25, fontWeight: FontWeight.w400),),
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
                                            child: Icon(Icons.note_add_outlined),
                                            margin: EdgeInsets.fromLTRB(5, 0, 10, 0),
                                          ),
                                        ),
                                        Expanded(
                                          child: Autocomplete<String>(
                                            optionsBuilder: (TextEditingValue searchcontroller)async{
                                              Directory appDocumentsDirectory=await getApplicationDocumentsDirectory();
                                              String appDocumentsPath=appDocumentsDirectory.path;
                                              String filePath='$appDocumentsPath/Books.xlsx';
                                              var bytes=await File(filePath).readAsBytes();
                                              var excel=Excel.decodeBytes(bytes);
                                              var sheet=excel.tables.values.first;
                                              int i=-1;
                                              int flag=0;
                                              List<String>listItems=[];
                                              for(var row in sheet.rows) {
                                                i++;
                                              }
                                              for(int j=1; j<=i; j++){
                                                listItems.add(sheet.rows[j][2]?.value?.toString() ?? '');
                                              }
                                              if(searchcontroller.text.isEmpty) {
                                                return Iterable<String>.empty();
                                              }
                                              return listItems.where((String item) {
                                                return item.contains(searchcontroller.text.toLowerCase());
                                              });
                                            },
                                            onSelected: (String item){
                                            },
                                            fieldViewBuilder: (context,searchcontroller, focusNode, onEditingComplete){
                                              return TextField(
                                                controller: searchcontroller,
                                                focusNode: focusNode,
                                                onEditingComplete: onEditingComplete,
                                                enableSuggestions: true,
                                                autocorrect: true,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "Enter Accession No."
                                                ),
                                                textInputAction: TextInputAction.search,
                                                onSubmitted: (value)async{
                                                  if(searchcontroller.text.replaceAll(" ", "")!="")
                                                  {
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
                                                        for(int j=1; j<=i; j++)
                                                        {
                                                          if(sheet.rows[j][2]?.value.toString()==searchcontroller.text)
                                                          {
                                                            flag=1;
                                                            if(sheet.rows[j][6]?.value.toString()=="Yes"){
                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                SnackBar(content: Text("Book already issued")),
                                                              );
                                                            }
                                                            else{
                                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>IssueConfirm(p:j)));
                                                            }
                                                          }
                                                        }
                                                        if(flag!=1)
                                                        {
                                                          ScaffoldMessenger.of(context).showSnackBar(
                                                            SnackBar(content: Text("Book does not exist")),
                                                          );
                                                        }
                                                  }
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width/3),
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
                            padding: EdgeInsets.fromLTRB(15, 5, 40, 5),
                            child: Column(
                              children: [
                                Text("Renew book: ",style: TextStyle(fontSize: MediaQuery.of(context).size.height/25, fontWeight: FontWeight.w400),),
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
                                            child: Icon(Icons.note_add_outlined),
                                            margin: EdgeInsets.fromLTRB(5, 0, 10, 0),
                                          ),
                                        ),
                                        Expanded(
                                          child: Autocomplete<String>(
                                            optionsBuilder: (TextEditingValue searchcontroller)async{
                                              Directory appDocumentsDirectory=await getApplicationDocumentsDirectory();
                                              String appDocumentsPath=appDocumentsDirectory.path;
                                              String filePath='$appDocumentsPath/Books.xlsx';
                                              var bytes=await File(filePath).readAsBytes();
                                              var excel=Excel.decodeBytes(bytes);
                                              var sheet=excel.tables.values.first;
                                              int i=-1;
                                              int flag=0;
                                              List<String>listItems=[];
                                              for(var row in sheet.rows) {
                                                i++;
                                              }
                                              for(int j=1; j<=i; j++){
                                                listItems.add(sheet.rows[j][2]?.value?.toString() ?? '');
                                              }
                                              if(searchcontroller.text.isEmpty) {
                                                return Iterable<String>.empty();
                                              }
                                              return listItems.where((String item) {
                                                return item.contains(searchcontroller.text.toLowerCase());
                                              });
                                            },
                                            onSelected: (String item){
                                            },
                                            fieldViewBuilder: (context,searchcontroller, focusNode, onEditingComplete){
                                              return TextField(
                                                controller: searchcontroller,
                                                focusNode: focusNode,
                                                onEditingComplete: onEditingComplete,
                                                enableSuggestions: true,
                                                autocorrect: true,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "Enter Accession No."
                                                ),
                                                textInputAction: TextInputAction.search,
                                                onSubmitted: (value)async{
                                                  if(searchcontroller.text.replaceAll(" ", "")!="")
                                                  {
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
                                                    for(int j=1; j<=i; j++)
                                                    {
                                                      if(sheet.rows[j][2]?.value.toString()==searchcontroller.text)
                                                      {
                                                        flag=1;
                                                        if(sheet.rows[j][6]?.value.toString()=="No"){
                                                          ScaffoldMessenger.of(context).showSnackBar(
                                                            SnackBar(content: Text("Book has not been issued")),
                                                          );
                                                        }
                                                        else{
                                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Renew(p:j)));
                                                        }
                                                      }
                                                    }
                                                    if(flag!=1)
                                                    {
                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                        SnackBar(content: Text("Book does not exist")),
                                                      );
                                                    }
                                                  }
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width/3),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height/3.6),
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

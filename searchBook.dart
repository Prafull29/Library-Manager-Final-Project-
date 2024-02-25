import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:excel/excel.dart';
import 'package:library_manager_project/home.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/services.dart' show Bytedata, rootBundle;
import 'package:path_provider/path_provider.dart';
import 'bookList.dart';

class SearchBook extends StatefulWidget {
  const SearchBook({super.key});

  @override
  State<SearchBook> createState() => _SearchBookState();
}

class _SearchBookState extends State<SearchBook> {

  TextEditingController searchcontroller1 =new TextEditingController();
  TextEditingController searchcontroller2 =new TextEditingController();
  TextEditingController searchcontroller3 =new TextEditingController();
  TextEditingController searchcontroller4 =new TextEditingController();
  TextEditingController searchcontroller5 =new TextEditingController();

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
                        children: <Widget>[
                          SizedBox(width: MediaQuery.of(context).size.width/2.5),
                          Card(
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
                            padding: EdgeInsets.fromLTRB(15, 5, 108, 5),
                            child: Column(
                              children: [
                                Text("Accession No.:",style: TextStyle(fontSize: MediaQuery.of(context).size.height/25, fontWeight: FontWeight.w400),),
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
                                            child: Icon(Icons.search,color: Colors.black,),
                                            margin: EdgeInsets.fromLTRB(5, 0, 10, 0),
                                          ),
                                        ),
                                        Expanded(
                                          child: Autocomplete<String>(
                                            optionsBuilder: (TextEditingValue searchcontroller1)async{
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
                                              if(searchcontroller1.text.isEmpty) {
                                                return Iterable<String>.empty();
                                              }
                                              return listItems.where((String item) {
                                                return item.contains(searchcontroller1.text.toLowerCase());
                                              });
                                            },
                                            onSelected: (String item){
                                            },
                                            fieldViewBuilder: (context,searchcontroller1, focusNode, onEditingComplete){
                                              return TextField(
                                                controller: searchcontroller1,
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
                                                  if(searchcontroller1.text.replaceAll(" ", "")!="")
                                                  {
                                                    Directory appDocumentsDirectory=await getApplicationDocumentsDirectory();
                                                    String appDocumentsPath=appDocumentsDirectory.path;
                                                    String filePath='$appDocumentsPath/Books.xlsx';
                                                    var bytes=await File(filePath).readAsBytes();
                                                    var excel=Excel.decodeBytes(bytes);
                                                    var sheet=excel.tables.values.first;
                                                    int i=-1;
                                                    int flag=0;
                                                    for(var row in sheet.rows) {
                                                      i++;
                                                    }
                                                    List <List>list=[];
                                                    for(int k=1; k<=i; k++)
                                                    {
                                                      var v=sheet.rows[k][2]?.value;
                                                      if(int.parse(v.toString())==int.parse(searchcontroller1.text.toString()))
                                                      {
                                                        flag=1;
                                                        List l=["1"];
                                                        var a=sheet.rows[k][1]?.value;
                                                        var b=sheet.rows[k][2]?.value;
                                                        var c=sheet.rows[k][3]?.value;
                                                        var d=sheet.rows[k][4]?.value;
                                                        var e=sheet.rows[k][5]?.value;
                                                        var f=sheet.rows[k][6]?.value;
                                                        var g=sheet.rows[k][7]?.value;
                                                        var h=sheet.rows[k][8]?.value;
                                                        var i=sheet.rows[k][9]?.value;
                                                        l.add("$a");
                                                        l.add("$b");
                                                        l.add("$c");
                                                        l.add("$d");
                                                        l.add("$e");
                                                        l.add("$f");
                                                        l.add("$g");
                                                        l.add("$h");
                                                        l.add("$i");
                                                        list.add(l);
                                                        break;
                                                      }
                                                    }
                                                    if(flag==1)
                                                    {
                                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>BookList(list: list)));
                                                    }
                                                    var updatedBytes = excel.encode();
                                                    await File(filePath).writeAsBytes(updatedBytes!);
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
                        SizedBox(width: MediaQuery.of(context).size.width/4),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height/40),
                      Row(
                        children: <Widget>[
                          SizedBox(width: MediaQuery.of(context).size.width/4),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.fromLTRB(15, 5, 140, 5),
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
                                            child: Icon(Icons.search,color: Colors.black,),
                                            margin: EdgeInsets.fromLTRB(5, 0, 10, 0),
                                          ),
                                        ),
                                        Expanded(
                                          child: Autocomplete<String>(
                                            optionsBuilder: (TextEditingValue searchcontroller2)async{
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
                                                if(!listItems.contains(sheet.rows[j][3]?.value.toString()?.toUpperCase()))
                                                {
                                                  listItems.add(sheet.rows[j][3]?.value?.toString()?.toUpperCase() ?? '');
                                                }
                                              }
                                              if(searchcontroller2.text.isEmpty) {
                                                return Iterable<String>.empty();
                                              }
                                              return listItems.where((String item) {
                                                return item.contains(searchcontroller2.text.toUpperCase());
                                              });
                                            },
                                            onSelected: (String item){
                                            },
                                            fieldViewBuilder: (context,searchcontroller2, focusNode, onEditingComplete){
                                              return TextField(
                                                controller: searchcontroller2,
                                                focusNode: focusNode,
                                                onEditingComplete: onEditingComplete,
                                                enableSuggestions: true,
                                                autocorrect: true,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "Enter Book Name"
                                                ),
                                                textInputAction: TextInputAction.search,
                                                onSubmitted: (value)async{
                                                  if(searchcontroller2.text.replaceAll(" ", "")!="")
                                                  {
                                                    Directory appDocumentsDirectory=await getApplicationDocumentsDirectory();
                                                    String appDocumentsPath=appDocumentsDirectory.path;
                                                    String filePath='$appDocumentsPath/Books.xlsx';
                                                    var bytes=await File(filePath).readAsBytes();
                                                    var excel=Excel.decodeBytes(bytes);
                                                    var sheet=excel.tables.values.first;
                                                    int i=-1;
                                                    int flag=0;
                                                    for(var row in sheet.rows) {
                                                      i++;
                                                    }
                                                    int m=1;
                                                    List <List>list=[];
                                                    for(int k=1; k<=i; k++)
                                                    {
                                                      var v=sheet.rows[k][3]?.value;
                                                      if(v.toString().toUpperCase().replaceAll(" ", "").replaceAll(".", '').replaceAll(",", "")==
                                                          searchcontroller2.text.toString().toUpperCase().replaceAll(" ","").replaceAll(".", "").replaceAll(",", ""))
                                                      {
                                                        flag=1;
                                                        List l=["$m"];
                                                        var a=sheet.rows[k][1]?.value;
                                                        var b=sheet.rows[k][2]?.value;
                                                        var c=sheet.rows[k][3]?.value;
                                                        var d=sheet.rows[k][4]?.value;
                                                        var e=sheet.rows[k][5]?.value;
                                                        var f=sheet.rows[k][6]?.value;
                                                        var g=sheet.rows[k][7]?.value;
                                                        var h=sheet.rows[k][8]?.value;
                                                        var i=sheet.rows[k][9]?.value;
                                                        l.add("$a");
                                                        l.add("$b");
                                                        l.add("$c");
                                                        l.add("$d");
                                                        l.add("$e");
                                                        l.add("$f");
                                                        l.add("$g");
                                                        l.add("$h");
                                                        l.add("$i");
                                                        list.add(l);
                                                        m++;
                                                      }
                                                    }
                                                    if(flag==1)
                                                    {
                                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>BookList(list: list)));
                                                    }
                                                    var updatedBytes = excel.encode();
                                                    await File(filePath).writeAsBytes(updatedBytes!);
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
                          SizedBox(width: MediaQuery.of(context).size.width/4),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height/40),
                      Row(
                        children: <Widget>[
                          SizedBox(width: MediaQuery.of(context).size.width/4),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.fromLTRB(15, 5, 115, 5),
                            child: Column(
                              children: [
                                Text("Author Name:",style: TextStyle(fontSize: MediaQuery.of(context).size.height/25, fontWeight: FontWeight.w400),),
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
                                            child: Icon(Icons.search,color: Colors.black,),
                                            margin: EdgeInsets.fromLTRB(5, 0, 10, 0),
                                          ),
                                        ),
                                        Expanded(
                                          child: Autocomplete<String>(
                                            optionsBuilder: (TextEditingValue searchcontroller3)async{
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
                                                if(!listItems.contains(sheet.rows[j][4]?.value.toString()?.toUpperCase()))
                                                  {
                                                    listItems.add(sheet.rows[j][4]?.value?.toString()?.toUpperCase() ?? '');
                                                  }
                                              }
                                              if(searchcontroller3.text.isEmpty) {
                                                return Iterable<String>.empty();
                                              }
                                              return listItems.where((String item) {
                                                return item.contains(searchcontroller3.text.toUpperCase());
                                              });
                                            },
                                            onSelected: (String item){
                                            },
                                            fieldViewBuilder: (context,searchcontroller3, focusNode, onEditingComplete){
                                              return TextField(
                                                controller: searchcontroller3,
                                                focusNode: focusNode,
                                                onEditingComplete: onEditingComplete,
                                                enableSuggestions: true,
                                                autocorrect: true,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "Enter Author Name"
                                                ),
                                                textInputAction: TextInputAction.search,
                                                onSubmitted: (value)async{
                                                  if(searchcontroller3.text.replaceAll(" ", "")!="")
                                                  {
                                                    Directory appDocumentsDirectory=await getApplicationDocumentsDirectory();
                                                    String appDocumentsPath=appDocumentsDirectory.path;
                                                    String filePath='$appDocumentsPath/Books.xlsx';
                                                    var bytes=await File(filePath).readAsBytes();
                                                    var excel=Excel.decodeBytes(bytes);
                                                    var sheet=excel.tables.values.first;
                                                    int i=-1;
                                                    int flag=0;
                                                    for(var row in sheet.rows) {
                                                      i++;
                                                    }
                                                    int m=1;
                                                    List <List>list=[];
                                                    for(int k=1; k<=i; k++)
                                                    {
                                                      var v=sheet.rows[k][4]?.value;
                                                      if(v.toString().toUpperCase().replaceAll(" ", "").replaceAll(".", '').replaceAll(",", "")==searchcontroller3.text.toString().toUpperCase().replaceAll(" ","").replaceAll(".", "").replaceAll(",", ""))
                                                      {
                                                        flag=1;
                                                        List l=["$m"];
                                                        var a=sheet.rows[k][1]?.value;
                                                        var b=sheet.rows[k][2]?.value;
                                                        var c=sheet.rows[k][3]?.value;
                                                        var d=sheet.rows[k][4]?.value;
                                                        var e=sheet.rows[k][5]?.value;
                                                        var f=sheet.rows[k][6]?.value;
                                                        var g=sheet.rows[k][7]?.value;
                                                        var h=sheet.rows[k][8]?.value;
                                                        var i=sheet.rows[k][9]?.value;
                                                        l.add("$a");
                                                        l.add("$b");
                                                        l.add("$c");
                                                        l.add("$d");
                                                        l.add("$e");
                                                        l.add("$f");
                                                        l.add("$g");
                                                        l.add("$h");
                                                        l.add("$i");
                                                        list.add(l);
                                                        m++;
                                                      }
                                                    }
                                                    if(flag==1)
                                                    {
                                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>BookList(list: list)));
                                                    }
                                                    var updatedBytes = excel.encode();
                                                    await File(filePath).writeAsBytes(updatedBytes!);
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
                          SizedBox(width: MediaQuery.of(context).size.width/4),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height/40),
                      Row(
                        children: <Widget>[
                          SizedBox(width: MediaQuery.of(context).size.width/4),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.fromLTRB(15, 5, 180, 5),
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
                                            child: Icon(Icons.search,color: Colors.black,),
                                            margin: EdgeInsets.fromLTRB(5, 0, 10, 0),
                                          ),
                                        ),
                                        Expanded(
                                          child: Autocomplete<String>(
                                            optionsBuilder: (TextEditingValue searchcontroller4)async{
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
                                                if(!listItems.contains(sheet.rows[j][5]?.value.toString()?.toUpperCase()))
                                                {
                                                  listItems.add(sheet.rows[j][5]?.value?.toString()?.toUpperCase() ?? '');
                                                }
                                              }
                                              if(searchcontroller4.text.isEmpty) {
                                                return Iterable<String>.empty();
                                              }
                                              return listItems.where((String item) {
                                                return item.contains(searchcontroller4.text.toUpperCase());
                                              });
                                            },
                                            onSelected: (String item){
                                            },
                                            fieldViewBuilder: (context,searchcontroller4, focusNode, onEditingComplete){
                                              return TextField(
                                                controller: searchcontroller4,
                                                focusNode: focusNode,
                                                onEditingComplete: onEditingComplete,
                                                enableSuggestions: true,
                                                autocorrect: true,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "Enter Category"
                                                ),
                                                textInputAction: TextInputAction.search,
                                                onSubmitted: (value)async{
                                                  if(searchcontroller4.text.replaceAll(" ", "")!="")
                                                  {
                                                    Directory appDocumentsDirectory=await getApplicationDocumentsDirectory();
                                                    String appDocumentsPath=appDocumentsDirectory.path;
                                                    String filePath='$appDocumentsPath/Books.xlsx';
                                                    var bytes=await File(filePath).readAsBytes();
                                                    var excel=Excel.decodeBytes(bytes);
                                                    var sheet=excel.tables.values.first;
                                                    int i=-1;
                                                    int flag=0;
                                                    for(var row in sheet.rows) {
                                                      i++;
                                                    }
                                                    int m=1;
                                                    List <List>list=[];
                                                    for(int k=1; k<=i; k++)
                                                    {
                                                      var v=sheet.rows[k][5]?.value;
                                                      if(v.toString().toUpperCase().replaceAll(" ", "").replaceAll(".", '').replaceAll(",", "")==searchcontroller4.text.toString().toUpperCase().replaceAll(" ","").replaceAll(".", "").replaceAll(",", ""))
                                                      {
                                                        flag=1;
                                                        List l=["$m"];
                                                        var a=sheet.rows[k][1]?.value;
                                                        var b=sheet.rows[k][2]?.value;
                                                        var c=sheet.rows[k][3]?.value;
                                                        var d=sheet.rows[k][4]?.value;
                                                        var e=sheet.rows[k][5]?.value;
                                                        var f=sheet.rows[k][6]?.value;
                                                        var g=sheet.rows[k][7]?.value;
                                                        var h=sheet.rows[k][8]?.value;
                                                        var i=sheet.rows[k][9]?.value;
                                                        l.add("$a");
                                                        l.add("$b");
                                                        l.add("$c");
                                                        l.add("$d");
                                                        l.add("$e");
                                                        l.add("$f");
                                                        l.add("$g");
                                                        l.add("$h");
                                                        l.add("$i");
                                                        list.add(l);
                                                        m++;
                                                      }
                                                    }
                                                    if(flag==1)
                                                    {
                                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>BookList(list: list)));
                                                    }
                                                    var updatedBytes = excel.encode();
                                                    await File(filePath).writeAsBytes(updatedBytes!);
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
                          SizedBox(width: MediaQuery.of(context).size.width/4),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height/40),
                      Row(
                        children: <Widget>[
                          SizedBox(width: MediaQuery.of(context).size.width/4),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.fromLTRB(15, 5, 187, 5),
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
                                            child: Icon(Icons.search,color: Colors.black,),
                                            margin: EdgeInsets.fromLTRB(5, 0, 10, 0),
                                          ),
                                        ),
                                        Expanded(
                                          child: Autocomplete<String>(
                                            optionsBuilder: (TextEditingValue searchcontroller5)async{
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
                                                if(!listItems.contains(sheet.rows[j][1]?.value.toString()?.toUpperCase()))
                                                {
                                                  listItems.add(sheet.rows[j][1]?.value?.toString()?.toUpperCase() ?? '');
                                                }
                                              }
                                              if(searchcontroller5.text.isEmpty) {
                                                return Iterable<String>.empty();
                                              }
                                              return listItems.where((String item) {
                                                return item.contains(searchcontroller5.text.toUpperCase());
                                              });
                                            },
                                            onSelected: (String item){
                                            },
                                            fieldViewBuilder: (context,searchcontroller5, focusNode, onEditingComplete){
                                              return TextField(
                                                controller: searchcontroller5,
                                                focusNode: focusNode,
                                                onEditingComplete: onEditingComplete,
                                                enableSuggestions: true,
                                                autocorrect: true,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "Enter Location"
                                                ),
                                                textInputAction: TextInputAction.search,
                                                onSubmitted: (value)async{
                                                  if(searchcontroller5.text.replaceAll(" ", "")!="")
                                                  {
                                                    Directory appDocumentsDirectory=await getApplicationDocumentsDirectory();
                                                    String appDocumentsPath=appDocumentsDirectory.path;
                                                    String filePath='$appDocumentsPath/Books.xlsx';
                                                    var bytes=await File(filePath).readAsBytes();
                                                    var excel=Excel.decodeBytes(bytes);
                                                    var sheet=excel.tables.values.first;
                                                    int i=-1;
                                                    int flag=0;
                                                    for(var row in sheet.rows) {
                                                      i++;
                                                    }
                                                    int m=1;
                                                    List <List>list=[];
                                                    for(int k=1; k<=i; k++)
                                                    {
                                                      var v=sheet.rows[k][1]?.value;
                                                      if(v.toString().toUpperCase().replaceAll(" ", "").replaceAll(".", '').replaceAll(",", "")==searchcontroller5.text.toString().toUpperCase().replaceAll(" ","").replaceAll(".", "").replaceAll(",", ""))
                                                      {
                                                        flag=1;
                                                        List l=["$m"];
                                                        var a=sheet.rows[k][1]?.value;
                                                        var b=sheet.rows[k][2]?.value;
                                                        var c=sheet.rows[k][3]?.value;
                                                        var d=sheet.rows[k][4]?.value;
                                                        var e=sheet.rows[k][5]?.value;
                                                        var f=sheet.rows[k][6]?.value;
                                                        var g=sheet.rows[k][7]?.value;
                                                        var h=sheet.rows[k][8]?.value;
                                                        var i=sheet.rows[k][9]?.value;
                                                        l.add("$a");
                                                        l.add("$b");
                                                        l.add("$c");
                                                        l.add("$d");
                                                        l.add("$e");
                                                        l.add("$f");
                                                        l.add("$g");
                                                        l.add("$h");
                                                        l.add("$i");
                                                        list.add(l);
                                                        m++;
                                                      }
                                                    }
                                                    if(flag==1)
                                                    {
                                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>BookList(list: list)));
                                                    }
                                                    var updatedBytes = excel.encode();
                                                    await File(filePath).writeAsBytes(updatedBytes!);
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
                          SizedBox(width: MediaQuery.of(context).size.width/4),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height/20),
                      ElevatedButton(
                          onPressed:()async{
                            Directory appDocumentsDirectory=await getApplicationDocumentsDirectory();
                            String appDocumentsPath=appDocumentsDirectory.path;
                            String filePath='$appDocumentsPath/Books.xlsx';
                            var bytes=await File(filePath).readAsBytes();
                            var excel=Excel.decodeBytes(bytes);
                            var sheet=excel.tables.values.first;
                            int i=-1;
                            int flag=0;
                            for(var row in sheet.rows) {
                              i++;
                            }
                            int m=1;
                            List <List>list=[];
                            for(int k=1; k<=i; k++)
                            {
                                flag=1;
                                List l=["$m"];
                                var a=sheet.rows[k][1]?.value;
                                var b=sheet.rows[k][2]?.value;
                                var c=sheet.rows[k][3]?.value;
                                var d=sheet.rows[k][4]?.value;
                                var e=sheet.rows[k][5]?.value;
                                var f=sheet.rows[k][6]?.value;
                                var g=sheet.rows[k][7]?.value;
                                var h=sheet.rows[k][8]?.value;
                                var i=sheet.rows[k][9]?.value;
                                l.add("$a");
                                l.add("$b");
                                l.add("$c");
                                l.add("$d");
                                l.add("$e");
                                l.add("$f");
                                l.add("$g");
                                l.add("$h");
                                l.add("$i");
                                list.add(l);
                                m++;
                            }
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>BookList(list: list)));
                          },
                          child: Text("Show all Books")
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height/35),
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


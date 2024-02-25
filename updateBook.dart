import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/services.dart' show Bytedata, rootBundle;
import 'package:path_provider/path_provider.dart';
import 'addBook.dart';
import 'updateConfirm.dart';

class UpdateBook extends StatefulWidget {
  const UpdateBook({super.key});

  @override
  State<UpdateBook> createState() => _UpdateBookState();
}

class _UpdateBookState extends State<UpdateBook> {
  TextEditingController searchcontroller1=new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                          SizedBox(width: MediaQuery.of(context).size.width/2.5),
                          Card(
                            child: Container(
                              padding:EdgeInsets.fromLTRB(20, 20, 50, 20),
                              child: Row(
                                children: [
                                  Icon(Icons.update_outlined, size: MediaQuery.of(context).size.height/20,),
                                  SizedBox(width:MediaQuery.of(context).size.width/100),
                                  Text("Update Book",style: TextStyle(fontSize: MediaQuery.of(context).size.height/20, fontWeight: FontWeight.w500),),
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
                            padding: EdgeInsets.fromLTRB(15, 5, 75, 5),
                            child: Column(
                              children: [
                                Text("Update Book:",style: TextStyle(fontSize: MediaQuery.of(context).size.height/25, fontWeight: FontWeight.w400),),
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
                                            child: Icon(Icons.update_outlined,color: Colors.black,),
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
                                                    if(searchcontroller1.text.replaceAll(" ","")!="")
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
                                                      for(int k=1; k<=i; k++)
                                                      {
                                                        var v=sheet.rows[k][2]?.value;
                                                        if(int.parse(v.toString())==int.parse(searchcontroller1.text.toString()))
                                                        {
                                                          flag=1;
                                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateConfirm(p: searchcontroller1.text.toString())));
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
                      SizedBox(height: MediaQuery.of(context).size.height/2.51),
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

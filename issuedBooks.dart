import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:excel/excel.dart';
import 'package:library_manager_project/home.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/services.dart' show Bytedata, rootBundle;
import 'package:path_provider/path_provider.dart';
import 'issueList.dart';

class IssuedBooks extends StatefulWidget {
  const IssuedBooks({super.key});

  @override
  State<IssuedBooks> createState() => _IssuedBooksState();
}

class _IssuedBooksState extends State<IssuedBooks> {
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
                          SizedBox(width: MediaQuery.of(context).size.width/2.8),
                          Card(
                            child: Container(
                              padding:EdgeInsets.fromLTRB(20, 20, 20, 20),
                              child: Row(
                                children: [
                                  Icon(Icons.list_alt_outlined, size: MediaQuery.of(context).size.height/20,),
                                  SizedBox(width:MediaQuery.of(context).size.width/100),
                                  Text("Issued Books List",style: TextStyle(fontSize: MediaQuery.of(context).size.height/20, fontWeight: FontWeight.w500)),
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
                            padding: EdgeInsets.fromLTRB(15, 5, 50, 5),
                            child: Column(
                              children: [
                                Text("List by Person Name:",style: TextStyle(fontSize: MediaQuery.of(context).size.height/25, fontWeight: FontWeight.w400),),
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
                                            child: Icon(Icons.person_search_outlined,color: Colors.black,),
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
                                                if(!listItems.contains(sheet.rows[j][7]?.value.toString()?.toUpperCase()))
                                                {
                                                  listItems.add(sheet.rows[j][7]?.value?.toString()?.toUpperCase() ?? '');
                                                }
                                              }
                                              if(searchcontroller.text.isEmpty) {
                                                return Iterable<String>.empty();
                                              }
                                              return listItems.where((String item) {
                                                return item.contains(searchcontroller.text.toUpperCase());
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
                                                    hintText: "Enter Person Name"
                                                ),
                                                textInputAction: TextInputAction.search,
                                                onSubmitted: (value)async{
                                                  if(searchcontroller.text.replaceAll(" ", "")!="")
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
                                                      var v=sheet.rows[k][7]?.value;
                                                      if(v.toString().toUpperCase().replaceAll(" ", "").replaceAll(".", '').replaceAll(",", "")==searchcontroller.text.toString().toUpperCase().replaceAll(" ","").replaceAll(".", "").replaceAll(",", ""))
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
                                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>IssueList(list: list)));
                                                    }
                                                    var updatedBytes = excel.encode();
                                                    await File(filePath).writeAsBytes(updatedBytes!);
                                                    if(flag!=1)
                                                    {
                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                        SnackBar(content: Text("No issued books")),
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
                      SizedBox(height: MediaQuery.of(context).size.height/6.4),
                      Container(
                        child: ElevatedButton(
                          onPressed: ()async{
                            List<List>list=[];
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
                            int m=1;
                            for(int j=1; j<=i; j++)
                            {
                              if(sheet.rows[j][6]?.value.toString()=="Yes")
                              {
                                List l=["$m"];
                                var a=sheet.rows[j][1]?.value;
                                var b=sheet.rows[j][2]?.value;
                                var c=sheet.rows[j][3]?.value;
                                var d=sheet.rows[j][4]?.value;
                                var e=sheet.rows[j][5]?.value;
                                var f=sheet.rows[j][6]?.value;
                                var g=sheet.rows[j][7]?.value;
                                var h=sheet.rows[j][8]?.value;
                                var i=sheet.rows[j][9]?.value;
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
                            if(list.isEmpty)
                            {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("No Issued Books")),
                              );
                            }
                            else
                            {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>IssueList(list: list,)));
                            }
                          },
                          child: Text("Get List of all Issued Books"),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height/5),
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

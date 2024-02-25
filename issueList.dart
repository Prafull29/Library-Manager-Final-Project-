import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:excel/excel.dart';
import 'package:library_manager_project/home.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/services.dart' show Bytedata, rootBundle;
import 'package:path_provider/path_provider.dart';
import 'issueRemove.dart';

class IssueList extends StatefulWidget {
  late List<List>list;
  IssueList({this.list=const[]});

  @override
  State<IssueList> createState() => _IssueListState();
}

class _IssueListState extends State<IssueList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.blue,
        ),
      ),
      body: SingleChildScrollView(
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
              SizedBox(height: MediaQuery.of(context).size.height/10,),
              Container(
                child: Card(
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                      child: Text("List of Issued Books",style: TextStyle(fontSize: MediaQuery.of(context).size.height/20,fontWeight: FontWeight.w400),)
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height/20,),
              Container(
                width: MediaQuery.of(context).size.width/1.1,
                child: Table(
                    border: TableBorder.all(),
                    columnWidths: {
                      0: FixedColumnWidth(MediaQuery.of(context).size.width/200), // Adjust column widths as needed
                      1: FixedColumnWidth(MediaQuery.of(context).size.width/200),
                      2: FixedColumnWidth(MediaQuery.of(context).size.width/30),
                      3: FixedColumnWidth(MediaQuery.of(context).size.width/7.5),
                      4: FixedColumnWidth(MediaQuery.of(context).size.width/10),
                      5: FixedColumnWidth(MediaQuery.of(context).size.width/20),
                      6: FixedColumnWidth(MediaQuery.of(context).size.width/200),
                      7: FixedColumnWidth(MediaQuery.of(context).size.width/25),
                      8: FixedColumnWidth(MediaQuery.of(context).size.width/30),
                      9: FixedColumnWidth(MediaQuery.of(context).size.width/30),
                    },
                    children: [TableRow(
                      decoration: BoxDecoration(
                        color: Colors.blue.shade300,
                      ),
                      children: [
                        TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'S.No.',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Shelf',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Accession No.',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Name of Book',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Author of Book',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Category',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Issued',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Issued to',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Issue Date',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Return Date',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                      ...widget.list.map((row) {
                        return TableRow(
                          children:
                          row.map((cellValue) {
                            return TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(cellValue),
                              ),
                            );
                          }).toList(),
                        );
                      }).toList(),
                    ]
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height/20,),
              Container(
                width: MediaQuery.of(context).size.width/2,
                child: ListView.builder(
                    itemCount: widget.list.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context,index){
                      int i=index+1;
                      List l=widget.list[index];
                      String s=l[3].toString();
                      String st=l[2].toString();
                      String str=l[7].toString();
                      return InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>IssueRemove(list: l,)));
                        },
                        child: Card(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                            child: Row(
                              children: [
                                Text("Remove ",style: TextStyle(fontWeight: FontWeight.w500),),
                                Text("$s, Accession No.$st, Issued to $str"),
                              ],
                            )
                          ),
                        ),
                      );
                    }
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height/10,),
            ]
          ),
        ),
      ),
    );
  }
}

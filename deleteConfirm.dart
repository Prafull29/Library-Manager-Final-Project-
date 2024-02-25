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
import 'package:library_manager_project/home.dart';

class DeleteConfirm extends StatefulWidget{
  late List<List> p;
  DeleteConfirm({this.p=const[]});
  @override
  State<DeleteConfirm> createState() => _DeleteConfirmState();
}

class _DeleteConfirmState extends State<DeleteConfirm> {
  late String b=widget.p[0][2].toString();
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
                      Container(
                        child: Card(
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                              child: Text("Book Details",style: TextStyle(fontSize: MediaQuery.of(context).size.height/20,fontWeight: FontWeight.w400),)
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
                            children: [
                              TableRow(
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
                              ...widget.p.map((row) {
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
                      SizedBox(height: MediaQuery.of(context).size.height/8,),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: <Widget>[
                            SizedBox(width:MediaQuery.of(context).size.width/2.63),
                            Card(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                                child: Row(
                                  children: [
                                    SizedBox(width:MediaQuery.of(context).size.width/100),
                                    Text("Confirm Remove Book?",style: TextStyle(fontSize: MediaQuery.of(context).size.height/25, fontWeight: FontWeight.w400),),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width:MediaQuery.of(context).size.width/10),
                          ],
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height/50),
                      Row(
                        children: <Widget>[
                          SizedBox(width: MediaQuery.of(context).size.width/2.5),
                          InkWell(
                            onTap: ()async{
                              Directory appDocumentsDirectory=await getApplicationDocumentsDirectory();
                              String appDocumentsPath=appDocumentsDirectory.path;
                              String filePath='$appDocumentsPath/Books.xlsx';
                              var bytes=await File(filePath).readAsBytes();
                              var excel=Excel.decodeBytes(bytes);
                              var sheet=excel.tables.values.first;
                              int i=-1;
                              for(var row in sheet.rows)
                              {
                                i++;
                              }
                              late int o;
                              for(int j=1; j<=i; j++)
                              {
                                if(int.parse(sheet.rows[j][2]?.value?.toString() ?? '')==int.parse(b))
                                  {
                                    o=j;
                                    break;
                                  }
                              }
                              if(i==1 || o==i)
                                {
                                  for(int k=0; k<=9; k++)
                                  {
                                    sheet.removeRow(o);
                                  }
                                }
                              else
                                {
                                  List list=[];
                                  list.add(o);
                                  for(int k=1; k<=9; k++)
                                    {
                                      list.add(sheet.rows[i][k]?.value.toString());
                                    }
                                  for(int k=0; k<=9; k++)
                                    {
                                      sheet.removeRow(i);
                                    }
                                  for(int k=0; k<=9; k++)
                                    {
                                      sheet.rows[o][k]?.value=list[k];
                                    }
                                }
                              var updatedBytes = excel.encode();
                              await File(filePath).writeAsBytes(updatedBytes!);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Book Removed")),
                              );
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
                            },
                            child: Card(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                                child: Row(
                                  children: [
                                    SizedBox(width:MediaQuery.of(context).size.width/100),
                                    Icon(Icons.delete_outline_outlined),
                                    Text("Yes",style: TextStyle(fontSize: MediaQuery.of(context).size.height/50, fontWeight: FontWeight.w400),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width/12),
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
                                    Icon(Icons.cancel_outlined),
                                    Text("No",style: TextStyle(fontSize: MediaQuery.of(context).size.height/50, fontWeight: FontWeight.w400),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width/3),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height/9),
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

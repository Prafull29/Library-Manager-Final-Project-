import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:excel/excel.dart';
import 'package:library_manager_project/home.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/services.dart' show Bytedata, rootBundle;
import 'package:path_provider/path_provider.dart';

class Renew extends StatefulWidget {
  late int p;
  Renew({this.p=0});
  List<List>list=[];
  @override
  State<Renew> createState() => _RenewState();
}

class _RenewState extends State<Renew> {

  TextEditingController searchcontroller=new TextEditingController();
  late DateTime Date=DateTime.now();

  Future<void> selectDate(BuildContext context)async{
    final DateTime? _Date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2099),
    );

    if (_Date != null && _Date != Date) {
      setState(() {
        Date = _Date;
        searchcontroller.text = Date.toString().substring(0,10);
      });
    }
  }

  Future<void>autofill()async{
    if(searchcontroller.text.toString()=="")
    {
      int nextMonth = DateTime.now()!.month + 1;
      int nextYear = DateTime.now().year;
      if(nextMonth > 12){
        nextMonth=1;
        nextYear+=1;
      }
      DateTime nextMonthDate = DateTime(nextYear, nextMonth, DateTime.now()!.day);
      searchcontroller.text=nextMonthDate.toString().substring(0,10);
    }
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
      if(k==widget.p)
      {
        List l=[];
        l.add("1");
        l.add(sheet.rows[k][1]?.value.toString());
        l.add(sheet.rows[k][2]?.value.toString());
        l.add(sheet.rows[k][3]?.value.toString());
        l.add(sheet.rows[k][4]?.value.toString());
        l.add(sheet.rows[k][5]?.value.toString());
        l.add(sheet.rows[k][6]?.value.toString());
        l.add(sheet.rows[k][7]?.value.toString());
        l.add(sheet.rows[k][8]?.value.toString());
        l.add(sheet.rows[k][9]?.value.toString());
        widget.list.add(l);
        setState(() {
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    autofill();
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
                      SizedBox(height: MediaQuery.of(context).size.height/20),
                      Row(
                        children: [
                          SizedBox(width: MediaQuery.of(context).size.width/2.5),
                          Card(
                            child: Container(
                              padding:EdgeInsets.fromLTRB(20, 20, 20, 20),
                              child: Row(
                                children: [
                                  Icon(Icons.note_add_outlined, size: MediaQuery.of(context).size.height/20,),
                                  SizedBox(width:MediaQuery.of(context).size.width/100),
                                  Text("Renew Book",style: TextStyle(fontSize: MediaQuery.of(context).size.height/20, fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                          ),
                        ],
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
                      SizedBox(height: MediaQuery.of(context).size.height/20),
                      Row(
                        children: <Widget>[
                          SizedBox(width: MediaQuery.of(context).size.width/4),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.fromLTRB(15, 5, 35, 5),
                            child: Column(
                              children: [
                                Text("New Return Date:",style: TextStyle(fontSize: MediaQuery.of(context).size.height/25, fontWeight: FontWeight.w400),),
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
                                            controller: searchcontroller,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Enter New Return Date",
                                              suffixIcon: IconButton(
                                                icon: Icon(Icons.calendar_month_outlined),
                                                onPressed: ()=> selectDate(context),
                                              ),
                                            ),
                                            readOnly: true,
                                          ),
                                        )
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
                      SizedBox(height: MediaQuery.of(context).size.height/5),
                      Row(
                        children: <Widget>[
                          SizedBox(width: MediaQuery.of(context).size.width/2.3),
                          ElevatedButton(
                            child: Text("Confirm Renew"),
                            onPressed: ()async{
                              Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
                              String appDocumentsPath = appDocumentsDirectory.path;
                              String filePath = '$appDocumentsPath/Books.xlsx';
                              var bytes = await File(filePath).readAsBytes();
                              var excel = Excel.decodeBytes(bytes);
                              var sheet = excel.tables.values.first;
                              if(searchcontroller.text=="")
                              {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Please fill all fields")),
                                );
                              }
                              else
                              {
                                sheet.rows[widget.p][9]?.value=searchcontroller.text.toString();
                                var updatedBytes = excel.encode();
                                await File(filePath).writeAsBytes(updatedBytes!);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Book Renewed")),
                                );
                                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Home()));
                              }
                            },
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width/3),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height/8.5),
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
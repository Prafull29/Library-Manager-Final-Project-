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
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class BookList extends StatefulWidget {
  late List<List>list;
  BookList({this.list=const[]});

  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {

  Future<Uint8List> generatePDF() async {
    final pdf = pw.Document();
    final rowsPerPage=8;
    final totalrows=widget.list.length;
    for (int startIndex = 0; startIndex < totalrows; startIndex+=rowsPerPage) {
      final endIndex = (startIndex + rowsPerPage < totalrows) ? startIndex + rowsPerPage : totalrows;
      pdf.addPage(
        pw.Page(
          orientation: pw.PageOrientation.landscape,
          build: (pw.Context context) {
            return pw.Table(
              border: pw.TableBorder.all(),
              columnWidths: {
                0: pw.FixedColumnWidth(30), // Adjust column widths as needed
                1: pw.FixedColumnWidth(30),
                2: pw.FixedColumnWidth(30),
                3: pw.FixedColumnWidth(100),
                4: pw.FixedColumnWidth(75),
                5: pw.FixedColumnWidth(70),
                6: pw.FixedColumnWidth(30),
                7: pw.FixedColumnWidth(50),
                8: pw.FixedColumnWidth(50),
                9: pw.FixedColumnWidth(50),
              },
              children: [
                pw.TableRow(
                  decoration: pw.BoxDecoration(
                    color: PdfColors.blue300,
                  ),
                  children: [
                    'S.No.',
                    'Shelf',
                    'Acc. No.',
                    'Name of Book',
                    'Author of Book',
                    'Category',
                    'Issued',
                    'Issued to',
                    'Issue Date',
                    'Return Date',
                  ].map((header) {
                    return pw.Container(
                      alignment: pw.Alignment.center,
                      padding: pw.EdgeInsets.all(8),
                      child: pw.Text(
                        header,
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                    );
                  }).toList(),
                ),
                ...widget.list.sublist(startIndex,endIndex).map((row) {
                  return pw.TableRow(
                    children: row.map((cellValue) {
                      return pw.Container(
                        alignment: pw.Alignment.center,
                        padding: pw.EdgeInsets.all(8),
                        child: pw.Text(cellValue),
                      );
                    }).toList(),
                  );
                }).toList(),
              ],
            );
          },
        ),
      );
    }
    return pdf.save();
  }

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
                SizedBox(height: MediaQuery.of(context).size.height/20,),
                Container(
                  child: Card(
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                        child: Text("Book List",style: TextStyle(fontSize: MediaQuery.of(context).size.height/20,fontWeight: FontWeight.w400),)
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height/20,),
                Container(
                  width: MediaQuery.of(context).size.width/1.1,
                  child: Table(
                    border: TableBorder.all(),
                    columnWidths: {
                      0: FixedColumnWidth(MediaQuery.of(context).size.width/200),
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
                ElevatedButton(
                  onPressed: () async {
                    final pdfBytes = await generatePDF();
                    final dir = await getApplicationDocumentsDirectory();
                    String appDocumentsPath=dir.path;
                    String filePath='$appDocumentsPath/my_pdf_file.pdf';
                    final file = File(filePath);
                    await file.writeAsBytes(pdfBytes);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('PDF saved')),
                    );
                  },
                  child: Text('Generate and Save PDF'),
                ),
                SizedBox(height: MediaQuery.of(context).size.height/20,),
              ]
          ),
        ),
      ),
    );
  }
}

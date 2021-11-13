import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart' as pw;

import 'mobile.dart' if (dart.library.html) 'web.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDF Converter',
      theme: ThemeData.dark(),
      home: MyHomePage(title: 'File Keeper'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String name = "";
  String email = "";
  String phone = "";
  String company = "";
  String listOfItems = "";


  Future<void> convert() async {

    List<String> items = listOfItems.split(",");
    pw.PdfDocument document = new pw.PdfDocument();
    final page = document.pages.add();

    page.graphics.drawString("Name - "+name + "\nEmail - "+email+ "\nPhone - "+phone+ "\nCompany - "+company+ "\n",
        pw.PdfStandardFont(pw.PdfFontFamily.helvetica, 30));


    pw.PdfGrid grid = pw.PdfGrid();
    grid.style = pw.PdfGridStyle(
        font: pw.PdfStandardFont(pw.PdfFontFamily.helvetica, 30),
        cellPadding: pw.PdfPaddings(left: 5, right: 2, top: 2, bottom: 2));

    grid.columns.add(count: 1);
    grid.headers.add(1);

    pw.PdfGridRow header = grid.headers[0];
    header.cells[0].value = 'Items';

    for(int i=0; i<items.length; i++){
      pw.PdfGridRow row = grid.rows.add();
      row.cells[0].value = items[i];
    }

    grid.draw(
        page: document.pages.add(), bounds: const Rect.fromLTWH(0, 0, 0, 0));

    List<int> bytes = document.save();
    document.dispose();

    LaunchFile(bytes, 'Output.pdf');

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              onChanged: (input) => {name = input},
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your username'),
            ),
            TextFormField(
              onChanged: (input) => {email = input},
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your Email'),
            ),
            SizedBox(height: 10),
            TextFormField(
              onChanged: (input) => {phone = input},
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your Phone Number'),
            ),
            SizedBox(height: 10),
            TextFormField(
              onChanged: (input) => {company = input},
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your Company Name'),
            ),
            SizedBox(height: 20),
            Text("Add the itmes seperating with commos"),
            TextFormField(
              onChanged: (input) => {listOfItems = input},
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(height: 20),
            ElevatedButton(onPressed: convert, child: Text("Generate Bill")),
          ],
        ),
      )),
    );
  }

}

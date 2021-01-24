import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Binary2Decimal Converter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _getBinary = TextEditingController();
  String textFieldValue;
  int convertBinary = 0;

  int bin2dec(String binary) {
    for (var i = binary.length - 1; i >= 0; i--) {
      //   print(pow(2, bin.length - 1 - i));
      //   print(int.parse(binary[i]));
      convertBinary += int.parse(binary[i]) * pow(2, binary.length - 1 - i);
    }
    return convertBinary;
  }

  void reset() {
    textFieldValue = '';
    convertBinary = 0;
    _getBinary.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Column(
          children: [
            TextField(
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-1]')),
              ],
              keyboardType: TextInputType.number,
              controller: _getBinary,
              decoration: InputDecoration(
                hintText: 'Only 0\'s and 1\'s',
                labelText: 'Binary',
              ),
              onChanged: (val) {
                setState(() {
                  textFieldValue = val;
                  print(textFieldValue);
                });
              },
            ),
            SizedBox(height: 20.0),
            Container(
              padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
              height: 50.0,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Decimal : $convertBinary',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20.0,
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                    ),
                    onPressed: () {
                      setState(() {
                        reset();
                      });
                    },
                    child: Text(
                      'Reset',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () {
                  setState(() {
                    bin2dec(
                      textFieldValue,
                    );
                  });
                },
                child: Text(
                  'Convert',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

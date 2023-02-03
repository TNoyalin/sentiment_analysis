import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Home());
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController inputController = new TextEditingController();
  String _text = "";
  var width;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        title: Text('Sentiment Analysis'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Center(
        child: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: TextField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]'))
                ],
                decoration: InputDecoration(
                    // maxLength: 20,

                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'How are you feeling now',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 3)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.redAccent,
                      width: 3,
                    ))),
                textCapitalization: TextCapitalization.characters,
                textAlign: TextAlign.center,
                controller: inputController,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: ElevatedButton(
                // color: Colors.blue,
                onPressed: () {
                  setState(() {
                    String smile = "HAPPY";
                    String sad = "SAD";
                    String depress = "ALONG";
                    if (inputController.text.contains(smile)) {
                      _text = '😃';
                    } else if (inputController.text.contains(sad)) {
                      _text = '😥';
                    } else if (inputController.text.contains(depress)) {
                      _text = '😕';
                    } else {
                      _text = '🙄';
                    }
                  });
                },
                child: Text(
                  'Show',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Text(
              '$_text',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        )),
      ),
    );
  }
}

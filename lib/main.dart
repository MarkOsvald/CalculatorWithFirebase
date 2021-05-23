import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:calculator_firebase/HistoryPage.dart';
import 'package:calculator_firebase/KmMilesSecondScreen.dart';
import 'dart:math';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyCalculator',
      routes: {
        '/history': (context) => HistoryPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: PowerCalculationScreen(),
    );
  }
}

class PowerCalculationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple calculator"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: new MyCalculator(),
      ),
    );
  }
}

class MyCalculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Calculator();
}

class Calculator extends State<MyCalculator> {
  CollectionReference calculations = FirebaseFirestore.instance.collection('calculations');
  final controller_numberA = TextEditingController();
  final controller_numberB = TextEditingController();
  final my_form_key = GlobalKey<FormState>();
  String textToShow = "";

  void Sum() async {
    if (my_form_key.currentState.validate()) {
      int numberA = int.parse(controller_numberA.text);
      int numberB = int.parse(controller_numberB.text);
      int result = numberA + numberB;

      setState(() {
        textToShow = "$numberA + $numberB = $result";
      });
      await calculations.add({'equation': textToShow });
    }
  }

  void Minus() async {
    if (my_form_key.currentState.validate()) {
      int numberA = int.parse(controller_numberA.text);
      int numberB = int.parse(controller_numberB.text);
      int result = numberA - numberB;

      setState(() {
        textToShow = "$numberA - $numberB = $result";
      });
      await calculations.add({'equation': textToShow });
    }
  }

  void Times() async {
    if (my_form_key.currentState.validate()) {
      int numberA = int.parse(controller_numberA.text);
      int numberB = int.parse(controller_numberB.text);
      int result = numberA * numberB;

      setState(() {
        textToShow = "$numberA * $numberB = $result";
      });
      await calculations.add({'equation': textToShow });
    }
  }

  void Divide() async {
    if (my_form_key.currentState.validate()) {
      int numberA = int.parse(controller_numberA.text);
      int numberB = int.parse(controller_numberB.text);
      double result = numberA / numberB;

      setState(() {
        textToShow = "$numberA / $numberB = $result";
      });
      await calculations.add({'equation': textToShow });
    }
  }

  void Power() async {
    if (my_form_key.currentState.validate()) {
      int numberA = int.parse(controller_numberA.text);
      int numberB = int.parse(controller_numberB.text);
      int result = calculatePower(numberA, numberB);
      setState(() {
        textToShow = "$numberA ^ $numberB = $result";
      });
      await calculations.add({'equation': textToShow });
    }
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Form(
            key: my_form_key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                    controller: controller_numberA,
                    validator: (value) {
                      if (value.isEmpty) return "Please enter number";
                    },
                    decoration: InputDecoration(hintText: "Enter number"),
                    keyboardType: TextInputType.number),
                TextFormField(
                    controller: controller_numberB,
                    validator: (value) {
                      if (value.isEmpty) return "Please enter number";
                    },
                    decoration: InputDecoration(hintText: "Enter number"),
                    keyboardType: TextInputType.number),
                Text(
                  textToShow,
                  style: TextStyle(fontSize: 20.0),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: Sum,
                        child: Text('+'),
                      ),
                      RaisedButton(
                        onPressed: Minus,
                        child: Text('-'),
                      ),
                      RaisedButton(
                        onPressed: Power,
                        child: Text('^'),
                      )
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: Divide,
                        child: Text('/'),
                      ),
                      RaisedButton(
                        onPressed: Times,
                        child: Text('*'),
                      ),
                      RaisedButton(
                          child: Text("km/miles"),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MySecondRoute()),
                            );}
                      ),
                Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            OutlineButton(
                                child: Text("History"),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HistoryPage()),
                                  );}
                            )
                          ]),
                    ])
              ],
            )));
  }

  int calculatePower(int numberA, int numberB) => pow(numberA, numberB);
}
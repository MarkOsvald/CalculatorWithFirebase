import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:calculator_firebase/screens/HistoryPage.dart';
import 'package:calculator_firebase/screens/KmMilesSecondScreen.dart';
import 'package:calculator_firebase/services/FirebaseAPI.dart';
import 'dart:math';

class MainPage extends StatelessWidget {
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
  final controllerNumberA = TextEditingController();
  final controllerNumberB = TextEditingController();
  final myFormKey = GlobalKey<FormState>();
  String textToShow = "";

  void sum() {
    if (myFormKey.currentState.validate()) {
      int numberA = int.parse(controllerNumberA.text);
      int numberB = int.parse(controllerNumberB.text);
      int result = numberA + numberB;

      setState(() {
        textToShow = "$numberA + $numberB = $result";
      });
      addDataToFirebase(textToShow);
    }
  }

  void minus() {
    if (myFormKey.currentState.validate()) {
      int numberA = int.parse(controllerNumberA.text);
      int numberB = int.parse(controllerNumberB.text);
      int result = numberA - numberB;

      setState(() {
        textToShow = "$numberA - $numberB = $result";
      });
      addDataToFirebase(textToShow);
    }
  }

  void times() {
    if (myFormKey.currentState.validate()) {
      int numberA = int.parse(controllerNumberA.text);
      int numberB = int.parse(controllerNumberB.text);
      int result = numberA * numberB;

      setState(() {
        textToShow = "$numberA * $numberB = $result";
      });
      addDataToFirebase(textToShow);
    }
  }

  void divide() {
    if (myFormKey.currentState.validate()) {
      int numberA = int.parse(controllerNumberA.text);
      int numberB = int.parse(controllerNumberB.text);
      double result = numberA / numberB;

      setState(() {
        textToShow = "$numberA / $numberB = $result";
      });
      addDataToFirebase(textToShow);
    }
  }

  void power() {
    if (myFormKey.currentState.validate()) {
      int numberA = int.parse(controllerNumberA.text);
      int numberB = int.parse(controllerNumberB.text);
      int result = calculatePower(numberA, numberB);
      setState(() {
        textToShow = "$numberA ^ $numberB = $result";
      });
      addDataToFirebase(textToShow);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Form(
            key: myFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                    controller: controllerNumberA,
                    validator: (value) {
                      if (value.isEmpty) return "Please enter number";
                    },
                    decoration: InputDecoration(hintText: "Enter number"),
                    keyboardType: TextInputType.number),
                TextFormField(
                    controller: controllerNumberB,
                    validator: (value) {
                      if (value.isEmpty) return "Please enter number";
                    },
                    decoration: InputDecoration(hintText: "Enter number"),
                    keyboardType: TextInputType.number),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    textToShow,
                    style: TextStyle(fontSize: 25.0),
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: sum,
                        child: Text('+'),
                      ),
                      ElevatedButton(
                        onPressed: minus,
                        child: Text('-'),
                      ),
                      ElevatedButton(
                        onPressed: power,
                        child: Text('^'),
                      )
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: divide,
                        child: Text('/'),
                      ),
                      ElevatedButton(
                        onPressed: times,
                        child: Text('*'),
                      ),
                      ElevatedButton(
                          child: Text("km/miles"),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MySecondRoute()),
                            );
                          }),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                          child: Text("History"),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.black,
                            padding: EdgeInsets.symmetric(horizontal: 60),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HistoryPage()),
                            );
                          })
                    ]),
              ],
            )));
  }

  int calculatePower(int numberA, int numberB) => pow(numberA, numberB);
}

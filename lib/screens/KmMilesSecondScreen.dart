import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MySecondRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SecondRoute();
}

class SecondRoute extends State<MySecondRoute> {
  final controllerNumber = TextEditingController();
  final myFormKey = GlobalKey<FormState>();

  String textToShow = "";

  void kmToMiles() {
    if (myFormKey.currentState.validate()) {
      double number = double.parse(controllerNumber.text);
      double result = number * 1.60934;
      result.toString();
      setState(() {
        textToShow = "$result miles";
      });
    }
  }

  void milesToKm() {
    if (myFormKey.currentState.validate()) {
      double number = double.parse(controllerNumber.text);
      double result = number * 0.621371;
      result.toString();
      setState(() {
        textToShow = "$result km";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Km to miles converter"),
      ),
      body: Form(
          key: myFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                  controller: controllerNumber,
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
                  ElevatedButton(
                    onPressed: kmToMiles,
                    child: Text('km/miles'),
                  ),
                  ElevatedButton(
                    onPressed: milesToKm,
                    child: Text('miles/km'),
                  )
                ],
              )
            ],
          )),
    );
  }
}

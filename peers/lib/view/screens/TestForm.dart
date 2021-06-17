import 'package:flutter/material.dart';

class TestForm extends StatefulWidget {
  const TestForm({Key? key}) : super(key: key);

  @override
  _TestFormState createState() => _TestFormState();
}

class _TestFormState extends State<TestForm> {
  String name = "";
  String _currency = "Dollar";
  final _currencies = ["Dollar", "Euro", "Pounds"];
  String result = "";

  final double _formDistance = 5.0;

  TextEditingController distanceController = TextEditingController();
  TextEditingController avgController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  void _onDropDownChanged(String value) {
    setState(() {
      this._currency = value;
    });
  }

  String _calculate() {
    double _distance = double.parse(distanceController.text);
    double _fuelCost = double.parse(priceController.text);
    double _consumption = double.parse(avgController.text);
    double _totalCost = _distance / _consumption * _fuelCost;
    String _result =
        "Total cost is ${_totalCost.toStringAsFixed(2)} $_currency";
    return _result;
  }

  void _reset() {
    distanceController.text = "";
    avgController.text = "";
    priceController.text = "";
    setState(() {
      result = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.headline6;

    return Scaffold(
        appBar: AppBar(
          title: Text("TestForm"),
          backgroundColor: Colors.blueGrey,
        ),
        body: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(
                    top: _formDistance,
                    bottom: _formDistance,
                  ),
                  child: TextField(
                    controller: distanceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "e.g. 124",
                        labelText: "Distance",
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
              Padding(
                  padding: EdgeInsets.only(
                    top: _formDistance,
                    bottom: _formDistance,
                  ),
                  child: TextField(
                    controller: avgController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "e.g. 17",
                        labelText: "Distance per Unit",
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
              Padding(
                  padding: EdgeInsets.only(
                    top: _formDistance,
                    bottom: _formDistance,
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: TextField(
                        controller: priceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: "e.g. 1.65",
                            labelText: "Price",
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                      Container(width: _formDistance * 5),
                      Expanded(
                          child: DropdownButton<String>(
                        items: _currencies.map((String value) {
                          return DropdownMenuItem<String>(
                              value: value, child: Text(value));
                        }).toList(),
                        onChanged: (String? value) =>
                            _onDropDownChanged(value!),
                        value: _currency,
                      )),
                    ],
                  )),
              Row(
                children: <Widget>[
                  Expanded(
                      child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColorDark,
                        textStyle: TextStyle(
                            color: Theme.of(context).primaryColorLight)),
                    child: Text("Submit", textScaleFactor: 1.5),
                    onPressed: () {
                      setState(() {
                        result = _calculate();
                      });
                    },
                  )),
                  Expanded(
                      child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).buttonColor,
                        textStyle: TextStyle(
                            color: Theme.of(context).primaryColorDark)),
                    child: Text("Reset", textScaleFactor: 1.5),
                    onPressed: () {
                      setState(() {
                        _reset();
                      });
                    },
                  )),
                ],
              ),
              Text(result),
            ],
          ),
        ));
  }
}

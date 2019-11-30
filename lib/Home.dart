import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _precoBuy = "0.00";
  String _precoSell = "0.00";
  String _format = "EUR";


  void _recoverBuyPrice() async{

    String url = "https://blockchain.info/ticker";
    http.Response response = await http.get(url);
    Map <String, dynamic> returnValue = json.decode(response.body);

    setState(() {
      _precoBuy = returnValue[_format]["buy"].toString();
    });

    print(_precoBuy);

  }

  void _recoverSellPrice() async {

    String url = "https://blockchain.info/ticker";
    http.Response response = await http.get(url);
    Map <String, dynamic> returnValue = json.decode(response.body);

    setState(() {
      _precoSell = returnValue[_format]["sell"].toString();

    });

    print(_precoSell);
  }

  void _sucessfullMessage(){

    Fluttertoast.showToast(
        msg: "Update Sucessful",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("imagens/bitcoin.png"),
              Padding(padding: EdgeInsets.only(top: 30, bottom: 30),
              child: Text(
                "Buy at: " + _precoBuy + " €",
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 30),
                child: Text(
                  "Sell for: " + _precoSell + " €",
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
              ),
              RaisedButton(
                child: Text(
                  "Update",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white
                  ),
                ),
                color: Colors.orange,
                padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                onPressed: (){ _recoverBuyPrice();
                _recoverSellPrice();
                _sucessfullMessage();}
              )
            ],
          ),
        ),
      ),
    );
  }
}

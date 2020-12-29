import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override

  String _valorDolar = "0,00";
  String _valorReal = "0,00";

  void _atualizar() async {

    String url = "https://blockchain.info/ticker";
    http.Response response = await http.get(url);
    
    Map<String,dynamic> resultado = json.decode(response.body);
    
    setState(() {
      _valorDolar = resultado["USD"]["buy"].toString();
      _valorReal = resultado["BRL"]["buy"].toString();  
    });
 
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: <Widget>[
             Image.asset("images/bitcoin.png"),
             Padding(
               padding: EdgeInsets.only(top:40),
               child: Text(
                 " \$ " + _valorDolar,
                 style: TextStyle(
                   fontSize: 25
                 ),
               ),
             ),
             Padding(
               padding: EdgeInsets.only(top:20, bottom:40),
               child: Text(
                 "R\$ " + _valorReal,
                 style: TextStyle(
                   fontSize: 25
                 ),
               ),
             ),
             RaisedButton(
               color: Colors.orange,
               child: Text(
                 "Atualizar",
                 style: TextStyle(
                   fontSize: 20,
                   color: Colors.white
                 ),
               ),
               onPressed: _atualizar,
             )
           ],
        ),
      )
    );
  }
}


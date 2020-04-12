import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?key=4ee86e9e";

void main() async {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
      hintColor: Colors.amber,
      primaryColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder:
        OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
        focusedBorder:
        OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        hintStyle: TextStyle(color: Colors.amber),
      )),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  print(response.body);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double dolar;
  double real;
  double euro;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("\$ Conversor de Moedas \$"),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Container(color: Colors.green);
              break;
            case ConnectionState.active:
              return Center(
                child: Text(
                  "Carregando dados",
                  style: TextStyle(color: Colors.amber, fontSize: 25.0),
                  textAlign: TextAlign.center,
                ),
              );
              break;
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  "Carregando dados",
                  style: TextStyle(color: Colors.amber, fontSize: 25.0),
                  textAlign: TextAlign.center,
                ),
              );
              break;
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Erro ao carregar dados :(",
                    style: TextStyle(color: Colors.amber, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
//                real = snapshot.data["results"]["currencies"]["BRL"]["buy"];
                return SingleChildScrollView(
                    padding: EdgeInsets.all(10.0),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Icon(Icons.monetization_on, size: 150.0, color: Colors.amber,),
                        Padding(padding: EdgeInsets.only(top: 10),
                        child: TextField(
                          style: new TextStyle(color: Colors.amber),
                          decoration: InputDecoration(
                            prefixText: "R\$ ",
                            labelText: "Reais",
                            labelStyle: TextStyle(color: Colors.amber),
                          ),
                        ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 10),
                          child: TextField(
                            style: new TextStyle(color: Colors.amber),
                            decoration: InputDecoration(
                              prefixText: "\$ ",
                              labelText: "Dolar",
                              labelStyle: TextStyle(color: Colors.amber),
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 10),
                          child: TextField(
                            style: new TextStyle(color: Colors.amber),
                            decoration: InputDecoration(
                              prefixText: "\€ ",
                              labelText: "Euro",
                              labelStyle: TextStyle(color: Colors.amber),
                            ),
                          ),
                        ),
                      ],
                    )
                );
              }
              break;
          }
        },
      ),
    );
  }
}

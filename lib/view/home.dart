import 'dart:math';
import 'package:weather_now/model/tarefa.dart';
import 'package:flutter/material.dart';
import 'package:weather_now/controller/api_weather_controller.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  TarefaHelper helper = TarefaHelper();

  @override
  void initState() {
    Tarefa t = Tarefa();
    t.titulo = "teste";
    t.descricao = "desc";

    helper.saveTarefa(t);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.18,
            padding: EdgeInsets.all(16.0),
            color: Colors.green,
            child: Row(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.menu),
                  // Divider(
                  //  height: 05,
                  // ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: Text("SEG"),
                      ),
                      Divider(height: 3),
                      Container(
                          height: 40,
                          width: 40,
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                          ),
                          child: Center(
                              child: Text(
                            "29",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )))
                    ],
                  )
                ],
              ),
              Column(),
              FloatingActionButton(onPressed: () {
                ApiWeatherController().testApi();
              })
            ]),
          ),
        ],
      ),
    );
  }
}
/*Container(
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width * 0.25,
          color: Colors.redAccent[700],
          child: Text("Jeffzin funkero",
              style: TextStyle(
                color: Colors.green[600],
                fontSize: 100,
              ))),*/
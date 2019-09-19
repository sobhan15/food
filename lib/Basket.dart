import 'package:flutter/material.dart';

class Basket extends StatefulWidget {
  @override
  _BasketState createState() => _BasketState();
}

class _BasketState extends State<Basket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, position) {
          return Stack(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.all(2.5),

                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.white10,
                      Colors.white30,
                      Colors.deepPurple[200],
                    ]
                  )
                ),
                width: MediaQuery.of(context).size.width*0.9,
                height: MediaQuery.of(context).size.height*0.125,
              ),
              Container(
                     width: MediaQuery.of(context).size.width*0.9,
                height: MediaQuery.of(context).size.height*0.125,
                color: Colors.blue,
                margin: EdgeInsets.all(2.5),
              )
            ],
          );
        },
      )),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FinishOrders extends StatefulWidget {
  @override
  _FinishOrdersState createState() => _FinishOrdersState();
}

class _FinishOrdersState extends State<FinishOrders> {
  double rate = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("سفارشات"),
        ),
        body: ListView.builder(
          itemBuilder: (context, position) {
            return Container(
              padding: EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.2,
              color: Colors.blue[200],
              margin: EdgeInsets.all(2.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    color: Colors.red[200],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text("غذا"),
                      Text("رستوران"),
                    ],
                  ),
                  Text(""),
                  Text(""),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[

                      Row(
                        children: <Widget>[
                          GestureDetector(
                            onLongPress: () {
                              if (rate > 10) {
                                setState(() {
                                  rate -= 10;
                                });
                              }
                            },
                            onTap: () {
                              if (rate > 0) {
                                setState(() {
                                  rate--;
                                });
                              }
                            },
                            child: Container(
                              width: 20,
                              height: 20,
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.remove,
                                size: 20,
                              ),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red[200]),
                            ),
                          ),
                          Text("     "),
                          Text("${rate / 10}"),
                          Text("     "),
                          GestureDetector(
                            onLongPress: () {
                              if (rate < 40) {
                                setState(() {
                                  rate += 10;
                                });
                              }
                            },
                            onTap: () {
                              if (rate < 50) {
                                setState(() {
                                  rate++;
                                });
                              }
                            },
                            child: Container(
                              width: 20,
                              height: 20,
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.add,
                                size: 20,
                              ),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red[200]),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text("ثبت امتیاز"),
                        width: 80,
                        height: 30,
                        color: Colors.red[200],
                      )
                    ],
                  )
                ],
              ),
            );
          },
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class FoodList extends StatefulWidget {
  @override
  _FoodListState createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  double starRating;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget rightTolbarItem(String name, bool isActive) {
    return RotationTransition(
        turns: AlwaysStoppedAnimation(90 / 360),
        child: isActive
            ? Text(name,
                style: TextStyle(
                    fontSize: 19,
                    color: Colors.black,
                    fontWeight: FontWeight.w700))
            : Text(name,
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("لیست غذا ها"),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 10),
              alignment: Alignment.centerRight,
              height: MediaQuery.of(context).size.height * 0.125,
              child: Text(
                "رستوران چاپاتی",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      rightTolbarItem("غذا ها", true),
                      rightTolbarItem("رستوران ها", false),
                      rightTolbarItem("سبد خرید", false),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.6,
                    color: Colors.white,
                    child: PageView(
                      controller: PageController(viewportFraction: 0.7),
                      onPageChanged: (v) {
                        print(v);
                      },
                      children: <Widget>[
                        Container(
                            color: Colors.blue,
                            width: MediaQuery.of(context).size.width * 1,
                            height: MediaQuery.of(context).size.height * 1,
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: <Widget>[
                                Container(
                                  color: Colors.black,
                                  width: MediaQuery.of(context).size.width * 1,
                                  height: MediaQuery.of(context).size.height *
                                      0.225,
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.amber,
                                          shape: BoxShape.circle),
                                      width: 100,
                                      height: 100,
                                    ),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width * 1,
                                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: Text(
                                        "قرمه سبزی",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      width:
                                          MediaQuery.of(context).size.width * 1,
                                      child: Text(
                                        "برنج ایرانی + خورش + کره + لیمو + ترشی",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                       Container(
                                      
                                      width:
                                          MediaQuery.of(context).size.width * 1,
                                      alignment: Alignment.center,
                                      child: SmoothStarRating(
                                            color: Colors.red,
                                            allowHalfRating: true,
                                            starCount: 5,
                                            rating: starRating == null
                                                ? 0
                                                : starRating,
                                            borderColor: Colors.amber,
                                            onRatingChanged: (v) {
                                              print(v);
                                              setState(() {
                                                starRating = v;
                                              });
                                            },
                                          )
                                    ),
                                   
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width * 1,
                                      alignment: Alignment.centerRight,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Icon(Icons.attach_money),
                                          Text("13,000 هزار تومان"),
                                        ],
                                      ),
                                    ),
                                     Container(
                                      margin: EdgeInsets.only(right: 5),
                                      width:
                                          MediaQuery.of(context).size.width * 1,
                                      alignment: Alignment.centerRight,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Icon(Icons.person),
                                          Text("یک نفره"),
                                        ],
                                      ),
                                    ),
                                 
                                   Container(
                                      margin: EdgeInsets.only(right: 5),
                                      width:
                                          MediaQuery.of(context).size.width * 1,
                                      alignment: Alignment.centerRight,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Icon(Icons.person),
                                          RaisedButton(onPressed: (){

                                          },
                                          child: Text("خرید"),),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Container(
                          width: MediaQuery.of(context).size.width * 1,
                          height: MediaQuery.of(context).size.height * 1,
                          color: Colors.red,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 1,
                          height: MediaQuery.of(context).size.height * 1,
                          color: Colors.blue,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}

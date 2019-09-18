import 'package:flutter/material.dart';
import 'package:food/FoodItem.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class FoodList extends StatefulWidget {
  @override
  _FoodListState createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  double starRating;
  bool activeFood = true;
  bool activeResturan = false;
  bool activeBasket = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget rightTolbarItem(String name, bool isActive) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 1,
      height: 70,
      child: RotationTransition(
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
                      fontWeight: FontWeight.w500))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.home,
            color: Colors.white,
          ),
          backgroundColor: Colors.deepPurple[200],
          onPressed: () {},
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Container(
          child: Stack(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                activeFood = true;
                                activeResturan = false;
                                activeBasket = false;
                              });
                            },
                            child: rightTolbarItem("غذا ها", activeFood)),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                activeFood = false;
                                activeResturan = true;
                                activeBasket = false;
                              });
                            },
                            child:
                                rightTolbarItem("رستوران ها", activeResturan)),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                activeFood = false;
                                activeResturan = false;
                                activeBasket = true;
                              });
                            },
                            child: rightTolbarItem("سبد خرید", activeBasket)),
                      ],
                    ),
                  ),
                  Container(
                    child: PageView(
                      children: <Widget>[
                        Flexible(
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.02),
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 10),
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.09,
                            child: Text(
                              "رستوران چاپاتی",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.75,
                            child: PageView(
                              controller:
                                  PageController(viewportFraction: 0.85),
                              onPageChanged: (v) {
                                print(v);
                              },
                              children: <Widget>[
                                FoodItem(
                                    imageFood: "ghorme",
                                    nameFood: "قورمه سبزی",
                                    descFood:
                                        "برنج ایرانی + ته چین + سبزی + ترشی + لیمو",
                                    ratingFood: 3.5,
                                    pricefood: 13000,
                                    person: "یک"),
                                FoodItem(
                                    imageFood: "dizi",
                                    nameFood: "دیزی سنگی",
                                    descFood:
                                        "سبزی + پیاز + ترشی بادمجان + دو تکه سنگک",
                                    ratingFood: 5,
                                    pricefood: 10000,
                                    person: "یک"),
                                FoodItem(
                                    imageFood: "ghorme",
                                    nameFood: "قورمه سبزی",
                                    descFood:
                                        "برنج ایرانی + ته چین + سبزی + ترشی + لیمو",
                                    ratingFood: 3.5,
                                    pricefood: 13000,
                                    person: "یک"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                      ],
                    )
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        "دسته بندی",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                      Text(
                        "نقشه",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                      Text("           "),
                      Text(
                        "سفارشات",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                      Text(
                        "خروج",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ],
                  ),
                  color: Colors.deepPurple[200],
                ),
              )
            ],
          ),
        ));
  }
}

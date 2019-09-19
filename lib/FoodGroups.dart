import 'package:flutter/material.dart';

class FoodGroups extends StatefulWidget {
  @override
  _FoodGroupsState createState() => _FoodGroupsState();
}

class _FoodGroupsState extends State<FoodGroups> {
  List nameGroup = [
    "کباب",
    "آش",
    "خورش",
    "فست فود",
        "کباب",
    "آش",
    "خورش",
    "فست فود",
  ];

  List imageGroup = [
    "kabab.jpg",
    "ash.jpg",
    "khoresh.jpg",
    "fast.jpg",
       "kabab.jpg",
    "ash.jpg",
    "khoresh.jpg",
    "fast.jpg",
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).accentColor,
          child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(
                  8,
                  (i) => Container(
                        child: Stack(
                          children: <Widget>[
                         
                            Image.asset("images/${imageGroup[i]}",
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width*1,
                          height: MediaQuery.of(context).size.height*1,
                          
                          ),
                             Container(
                               child: Center(child: Text(nameGroup[i],style: TextStyle(color: Colors.white,fontSize: 20),),),
                              width: MediaQuery.of(context).size.width*1,
                          height: MediaQuery.of(context).size.height*1,
                          color: Colors.black45,
                            ),],
                        ),
                        margin: EdgeInsets.all(5),
                      )))),
    );
  }
}

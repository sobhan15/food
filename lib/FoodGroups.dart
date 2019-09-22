import 'package:flutter/material.dart';

class FoodGroups extends StatefulWidget {
  final ValueChanged<void> kababGroup;
  final ValueChanged<void> khoreshGroup;
  final ValueChanged<void> ashGroup;
  final ValueChanged<void> fastFoodGroup;

  const FoodGroups(
      {Key key,
      this.kababGroup,
      this.ashGroup,
      this.fastFoodGroup,
      this.khoreshGroup})
      : super(key: key);
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
                            Image.asset(
                              "images/${imageGroup[i]}",
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width * 1,
                              height: MediaQuery.of(context).size.height * 1,
                            ),
                            GestureDetector(
                              onTap: () {
                                if (nameGroup[i] == "کباب") {
                                  widget.kababGroup(null);
                                }else if(nameGroup[i]=="آش"){
                                  widget.ashGroup(null);
                                }else if(nameGroup[i]=="خورش"){
                                  widget.khoreshGroup(null);
                                }else if(nameGroup[i]=="فست فود"){
                                  widget.fastFoodGroup(null);
                                }
                              },
                              child: Container(
                                child: Center(
                                  child: Text(
                                    nameGroup[i],
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width * 1,
                                height: MediaQuery.of(context).size.height * 1,
                                color: Colors.black45,
                              ),
                            ),
                          ],
                        ),
                        margin: EdgeInsets.all(5),
                      )))),
    );
  }
}

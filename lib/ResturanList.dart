import 'package:flutter/material.dart';

class ResturanList extends StatefulWidget {
  final List imgName;
  final List resturanName;

  const ResturanList({Key key, this.imgName, this.resturanName})
      : super(key: key);

  @override
  _ResturanListState createState() => _ResturanListState();
}

class _ResturanListState extends State<ResturanList> {
  List imgName;
  List resturanName;
  @override
  void initState() {
    super.initState();
    setState(() {
      this.imgName = widget.imgName;
      this.resturanName = widget.resturanName;
    });

    
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, position) {
        return Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(5),
              child: Image.asset(
                "images/${imgName[position]}",
                width: MediaQuery.of(context).size.width * 1,
                fit: BoxFit.fill,
                height: MediaQuery.of(context).size.height * 0.2,
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Colors.black12,
                    Colors.black26,
                    Theme.of(context).primaryColor.withOpacity(0.9)
                  ])),
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            Positioned(
              bottom: 0,
              child: Container(
                alignment: Alignment.center,
                child: Text(resturanName[position],style: TextStyle(fontSize: 19,color: Colors.white),),
                height: 30,
                color: Theme.of(context).primaryColor.withOpacity(0.3),
                width: MediaQuery.of(context).size.width * 0.8,
              ),
            )
          ],
        );
      },
    );
  }
}

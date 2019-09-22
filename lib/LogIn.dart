import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController phoneController;
  TextEditingController passController;

  FocusNode phoneFocus;
  FocusNode passFocus;

  @override
  void initState() {
    super.initState();

    phoneController = TextEditingController();
    passController = TextEditingController();

    phoneFocus = FocusNode();
    passFocus = FocusNode();
  }

  @override
  void dispose() {
    phoneController.dispose();
    passController.dispose();

    phoneFocus.dispose();
    passFocus.dispose();

    super.dispose();
  }

  Widget txtFiled(TextEditingController controller, String labelName,
      IconData icon, FocusNode focusNode, FocusNode nextFocusNode) {
    return TextField(
      focusNode: focusNode,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(nextFocusNode);
      },
      controller: controller,
      decoration: InputDecoration(labelText: labelName, prefixIcon: Icon(icon)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ورود"),
        backgroundColor: Color(0xff095857),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        color: Color(0xffE0F2F1),
        alignment: Alignment.center,
        child: SingleChildScrollView(
                  child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              txtFiled(phoneController,"تلفن همراه",Icons.phone,null,passFocus),
              Text(""),
              txtFiled(passController,"رمز عبور",Icons.vpn_key,null,null),
              Text(""),
              Text(""),
              Text("لطفا شماره خود را وارد کنید",style: TextStyle(color: Colors.red),),
              Text(""),


               Transform(
                        transform: Matrix4.skew(-0.4, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 1)),
                          height: 40,
                          child: Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height:
                                        MediaQuery.of(context).size.height * 1,
                                    color: Color(0xff09888A),
                                    child: Text(
                                      "تایید",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    )),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height * 1,
                                color: Color(0xff095857),
                                width: 10,
                              ),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.158,
                                  alignment: Alignment.center,
                                  color: Colors.white70,
                                  height: MediaQuery.of(context).size.height * 1,
                                  child: Icon(Icons.check_circle))
                            ],
                          ),
                        ),
                      ),
            ],
          ),
        ),
      ),
    );
  }
}

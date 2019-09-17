import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController;
  TextEditingController passController;
  TextEditingController phoneController;

  FocusNode nameFocus;
  FocusNode passFocus;
  FocusNode phoneFocus;

  bool showVarication = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    passController = TextEditingController();
    phoneController = TextEditingController();

    nameFocus = FocusNode();
    passFocus = FocusNode();
    phoneFocus = FocusNode();
  }

  @override
  void dispose() {
    nameController.dispose();
    passController.dispose();
    phoneController.dispose();

    nameFocus.dispose();
    passFocus.dispose();
    phoneFocus.dispose();
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
          backgroundColor: Color(0xff095857),
          title: Text("عضویت"),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              color: Color(0xffE0F2F1),
              height: MediaQuery.of(context).size.height * 1,
              padding: EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(""),
                    Text(""),
                    txtFiled(nameController, "نام", Icons.person, nameFocus,
                        phoneFocus),
                    Text(""),
                    Text(""),
                    txtFiled(phoneController, "تلفن همراه", Icons.phone,
                        phoneFocus, passFocus),
                    Text(""),
                    Text(""),
                    txtFiled(passController, "رمز عبور", Icons.vpn_key,
                        passFocus, null),
                    Text(""),
                    Text(""),
                    Text(""),
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
                                setState(() {
                                  showVarication = true;
                                });
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
                    Text(""),
                  ],
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: showVarication?1:0,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInToLinear,
                          child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 1,
                child: showVarication
                    ? Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              "کدی که برای شما ارسال کردیم را وارد کنید.",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            PinCodeTextField(
                              pinBoxWidth: 30.0,
                              defaultBorderColor: Colors.white,
                              highlightColor: Colors.white,
                              hasTextBorderColor: Colors.white,
                              pinBoxHeight: 25.0,
                              pinTextStyle:
                                  TextStyle(color: Colors.white, fontSize: 20),
                              pinBoxDecoration: ProvidedPinBoxDecoration
                                  .underlinedPinBoxDecoration,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  showVarication = false;
                                });
                              },
                              child: Container(
                                width: 75,
                                height: 35,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.white),
                                ),
                                child: Text(
                                  "تایید",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Color(0xff095857),
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(150, 30))),
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.4,
                      )
                    : null,
              ),
            )
          ],
        ));
  }
}

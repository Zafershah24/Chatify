

import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  static String id ='welcome';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  @override
  void initState() {
    super.initState();
    controller=AnimationController(duration: Duration(seconds: 2), vsync: this,);
    animation=CurvedAnimation(parent: controller,curve: Curves.easeIn);
    controller.forward(from: .5);
    animation.addStatusListener((status) {if (status==AnimationStatus.completed){controller.reverse(from: 1);
    }else if (status==AnimationStatus.dismissed){controller.forward();}});
    controller.addListener(() {setState(() {    });});
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//

      body: Container(

          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [ Colors.white,Color.fromRGBO(229, 187, 211,1),])),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Hero(
                      tag: 'logo',
                      child: Container(

                        child: Image.asset('images/logo.png'),
                        height: 130,
                      ),
                    ),




                     TyperAnimatedTextKit(
                        text: ["Chatify"],
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w700,
                            fontSize: 58, color: Colors.pinkAccent, fontFamily: "Sriracha"),
                        textAlign: TextAlign.start,
                        alignment: AlignmentDirectional.topCenter // or Alignment.topLeft
                    ),


                  ],
                ),
                SizedBox(
                  height: 48.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    elevation: 5.0,
                    color: Color.fromRGBO(83, 162, 201,0.8),
                    borderRadius: BorderRadius.circular(30.0),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pushNamed(context, LoginScreen.id);
                      },
                      minWidth: 200.0,
                      height: 42.0,
                      child: Text(
                        'Log In',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    color: Colors.pinkAccent,
                    borderRadius: BorderRadius.circular(30.0),
                    elevation: 5.0,
                    child: MaterialButton(
                      onPressed: () {
                       Navigator.pushNamed(context, RegistrationScreen.id);
                      },
                      minWidth: 200.0,
                      height: 42.0,
                      child: Text(
                        'Register',
                      ),
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
import 'package:am_sliit/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyWelcomePage extends StatefulWidget{
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyWelcomePage>{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff00007b),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //We take the image from the assets
            Center(
              child: Image.asset(
                'assets/university.png',
                height: 250,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            //Texts and Styling of them
            Text(
              'Welcome to AM SLIIT !',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 28),
            ),
            SizedBox(height: 20),
            Text(
              'It is now easy to access every tool in once place and manage daily academic tasks!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(
              height: 30,
            ),
            //Our MaterialButton which when pressed will take us to a new screen named as
            //LoginScreen
            MaterialButton(
              elevation: 0,
              height: 50,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => LoginScreen()));
              },
              color: Color(0xffD0752c),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Get Started',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  Icon(Icons.arrow_forward_ios)
                ],
              ),
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}

import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'package:am_sliit/login.dart';
import 'package:am_sliit/bookmark_screens/bookmarks.dart';
import 'package:am_sliit/timetable_screens/timetable.dart';
import 'package:am_sliit/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:swipedetector/swipedetector.dart';

class IndexPage extends StatefulWidget{

  String url;
  IndexPage({Key key, this.url}): super (key: key);

  @override
  _MyIndexPage createState() => _MyIndexPage(url);
}

class _MyIndexPage extends State<IndexPage>{


  String url;
  _MyIndexPage(this.url);



  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Color logoGreen = Color(0xffD0752c);
  WebViewController _controller;

  DatabaseReference bookmarkRef = FirebaseDatabase.instance.reference().child("bookmarks").child(FirebaseAuth.instance.currentUser.uid);
  TextEditingController _controllerBookmarkTitle = TextEditingController();


  createAddBookmarkAlertDialog (BuildContext context, String currentUrlByUser){
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("Add this page as a bookmark"),
        content: TextField(
          controller: _controllerBookmarkTitle,
          decoration: InputDecoration(
            hintText: "Give a title",
          ),
        ),
        actions: [
          MaterialButton(
            elevation: 5.0,
            child: Text("Add"),
            onPressed: (){
              String _bookMarkTitle = _controllerBookmarkTitle.text.trim().toString();
              makeThisPageAsBookMark(context, _bookMarkTitle , currentUrlByUser);
              Navigator.of(context).pop();
            },
          )
        ],
      );
    }
    );
  }



  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();


  @override
  Widget build(BuildContext context) {
    if(url == null){
      url = "https://courseweb.sliit.lk/my/";
    }else{
      if(url.startsWith("https://")){
        url=url;
      }else if(url.startsWith("http://")){
        url=url;
      }else if(!url.startsWith("https://")){
        url = "http://" + url;
      }else if(!url.startsWith("http://")){
        url = "http://" + url;
      }
    }
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          color: logoGreen,
          child: Row(
            children: [
              IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.white,), onPressed: () {
                _controller.goBack();
              }),
              Spacer(),
            IconButton(icon: Icon(Icons.arrow_forward_ios, color: Colors.white,), onPressed: () {
                _controller.goForward();
              }),
            ],
          ),
        ),
        floatingActionButton:
        FloatingActionButton(
          backgroundColor: logoGreen,
          child: Icon(Icons.grid_view),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => Timetable()));
            },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        appBar: AppBar(
          backgroundColor: logoGreen,
          title:  Text("CourseWeb"),
          actions: [
            IconButton(
              icon: Icon(Icons.push_pin_rounded),
              onPressed: () async {
                createAddBookmarkAlertDialog(context, await _controller.currentUrl());
              } , // => function();
            ),
            IconButton(
              icon: Icon(Icons.collections_bookmark_sharp),
              onPressed: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => Bookmark()));
              } , // => function();
            ),
          ],
        ),
        drawer: Drawer(
            // Populate the Drawer in the next step.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text("Hi, Good " +greeting() + "!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                ),
                decoration: BoxDecoration(
                  color: Color (0xff00007b),
                  ),
                ),
              ListTile(
                title: Text('CourseWeb'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  _controller.loadUrl('https://courseweb.sliit.lk/');
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Student Portal'),
                onTap: () {
                  // Update the state of the app
                  // ..
                  _controller.loadUrl('https://study.sliit.lk/');
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Eduscope'),
                onTap: () {
                  // Update the state of the app
                  // ..
                  _controller.loadUrl('https://lecturecapture.sliit.lk/');
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Online Exams'),
                onTap: () {
                  // Update the state of the app
                  // ..
                  _controller.loadUrl('https://onlineexams.sliit.lk/login/index.php');
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Net Exams'),
                onTap: () {
                  // Update the state of the app
                  // ..
                  _controller.loadUrl('https://netexam.sliit.lk/login/index.php');
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        endDrawer: Drawer(
          // Populate the Drawer in the next step.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text("Hi, Good " +greeting() + "!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color (0xff00007b),
                ),
              ),

              ListTile(
                title: Text('Bookmark Page'),
                onTap: () {
                  // Update the state of the app
                  // ..
                  //loadLoggedUsersBookmarks(context);

                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => Bookmark()));
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              //add bmark list here

            ],
          ),
        ),
       body: WebView(

         initialUrl: url,
         javascriptMode: JavascriptMode.unrestricted,
         onWebViewCreated: (WebViewController webViewController) {
           _controller = webViewController;
         },
       ),
      ),
    );
  }


  void makeThisPageAsBookMark(BuildContext context, String bookmarkTitle, String bookmarkUrl) {

    final User user = FirebaseAuth.instance.currentUser;
    final uid = user.uid;

    Map bookmarkDetails = {
      "bookmarkTitle": bookmarkTitle,
      "bookmarkUrl": bookmarkUrl,
    };

    DatabaseReference bookmarkRef = FirebaseDatabase.instance.reference().child("bookmarks");
    bookmarkRef.child(uid).child(_randomString(10)).set(bookmarkDetails);

  }



  loadLoggedUsersBookmarks(BuildContext context){

    final User user = FirebaseAuth.instance.currentUser;
    final uid = user.uid;
    DatabaseReference bookmarkRef = FirebaseDatabase.instance.reference().child("bookmarks");


    bookmarkRef.child(uid).once().then((DataSnapshot snapshot){
      if(snapshot.value.isNotEmpty){
          snapshot.value.forEach((key,values) {

            Map bookmarkDetails = {
              "bookmarkTitle": values["bookmarkTitle"],
              "bookmarkUrl": values["bookmarkUrl"],
            };

            print(bookmarkDetails);
          });

      }
    });





  }



}


String greeting() {

  var hour = DateTime.now().hour;
  if (hour < 12) {
    return 'Morning';
  }
  if (hour < 17) {
    return 'Afternoon';
  }
  return 'Evening';
}

String _randomString(int length) {
  var rand = new Random();
  var codeUnits = new List.generate(
      length,
          (index){
        return rand.nextInt(33)+89;
      }
  );

  return new String.fromCharCodes(codeUnits);
}

displayToastMessage(String message, BuildContext context){
  Fluttertoast.showToast(msg: message);
}

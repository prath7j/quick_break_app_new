import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//Importing for firebase support
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
/*
void main() {
  runApp(MyApp());
}
*/

//Sample main
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final appTitle = 'Quick Break';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

// ignore: must_be_immutable
class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    /*Widget button1 = Container(
      margin: const EdgeInsets.all(10.0),
      alignment: Alignment.center,
      child: new ElevatedButton(
        onPressed: () { },
        child: Text('Surprise me'),
        style: ElevatedButton.styleFrom(
            primary: Colors.blue, // background
            onPrimary: Colors.white, // foreground
            padding: EdgeInsets.symmetric(horizontal: 80, vertical: 40),
            textStyle: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.normal)
        ), //Style
      ),
    );*/

    Widget button6 = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(Color(0xFF42A5F5), 'Surprise me', context),
        ],
      ),
    );

    Widget button23 = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(Color(0xFF42A5F5), 'Energy', context),
          _buildButtonColumn(Color(0xFF42A5F5), 'Calm', context),
        ],
      ),
    );

    Widget button45 = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(Color(0xFF42A5F5), 'Focus', context),
          _buildButtonColumn(Color(0xFF42A5F5), 'Uplift', context),
        ],
      ),
    );

    Widget gridbuttons = Container(
      width: 300,
      height: 400,
      child: GridView.count(
            primary: true,
            crossAxisCount: 2, //set the number of buttons in a row
            crossAxisSpacing: 4, //set the spacing between the buttons
            childAspectRatio: 1, //set the width-to-height ratio of the button,
            //>1 is a horizontal rectangle
            children: [
              _buildButtonColumn(Color(0xFF42A5F5), 'Energy', context),
              _buildButtonColumn(Color(0xFF42A5F5), 'Calm', context),
              _buildButtonColumn(Color(0xFF42A5F5), 'Focus', context),
              _buildButtonColumn(Color(0xFF42A5F5), 'Uplift', context),
            ],
        ),
    );

    return Scaffold(
    appBar: AppBar(title: Text(title)),
    body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          button6,
          //button23,
          //button45,
          gridbuttons,
        ]
    ),
      drawer: Drawer(
        child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Quick Break'),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text ("Text1"),
                onTap: (){
                  //Update state of the app
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text ("Text2"),
                onTap: (){
                  //Update state of the app
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
    );
  }
  Column _buildButtonColumn(Color color, String label, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 25),
          child: new ElevatedButton(
            onPressed: () {

              /*Trying to get data from database
              FirebaseFirestore.instance
                  .collection("prompts")
                  .doc("MUrAHs6oDJiqIBxMkLmJ")
                  .get().then((value){
                print(value.data().values.first);
              });
              */
              //ending db try

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondRoute()),
              );
            },
            child: Text(label),
            style: ElevatedButton.styleFrom(
                primary: color, // background
                onPrimary: Colors.white, // foreground
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                textStyle: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.normal)
            ), //Style
          ),
        ),
      ],
    );
  }
}


class SecondRoute extends StatelessWidget {
  String docId;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("Quick Break"),
        ),
        body: FutureBuilder(
          future: getTask(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data = snapshot.data.data() as Map<String, dynamic>;
              String str = data['Task'];
              print(str);
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    child: Text(
                      data['Task'],
                      overflow: TextOverflow.fade,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.none) {
              return Text("No data");
            }
            return CircularProgressIndicator();
          },
        ));
  }
//test above

/*
  @override
  Widget build(BuildContext context) {
    String str;
    String str1="hi";

    //Get task from DB
   Future f= FirebaseFirestore.instance
        .collection("prompts")
        .doc("MUrAHs6oDJiqIBxMkLmJ")
        .get();

    print(str);
    return Scaffold(
      appBar: AppBar(
        title: Text("Quick Break"),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 90, minHeight: 400, maxWidth: 300, maxHeight: 400),
          child: ElevatedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
            //Navigator.pop(context);
          },
          child: Text(str1),
              style: ElevatedButton.styleFrom(
              primary: Colors.blue, // background
              onPrimary: Colors.white, // foreground
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
              textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal)
          ), // Style
        ),
      ),
    ),
    );
  }
  */
  Future<DocumentSnapshot> getTask() async {
    //await Firebase.initializeApp();
    int num = 5;
    var random = new Random();
    docId = random.nextInt(num).toString();
    print(docId);
    return await FirebaseFirestore.instance
        .collection("prompts")
        .doc(docId)
        .get();
  }
}
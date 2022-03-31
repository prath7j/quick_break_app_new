import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//Importing for firebase support
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/painting.dart';
//Math library for random function
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:google_fonts/google_fonts.dart';

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
    print("ROOt widget is building");
    return ChangeNotifierProvider<RandomNumberProvider>(
        create: (_) => RandomNumberProvider(),
        child: Builder(
            builder: (context) {
              return MaterialApp(
                title: appTitle,
                home: MyHomePage(title: appTitle),
              );
            }
        )
    );
  }
}

// ignore: must_be_immutable
class MyHomePage extends StatelessWidget {
  final String title;
  int i=1;

  String getTime() {
    String message;
    var now = DateTime.now().hour;
    print("time");
    print(now);
    if(now>=4 && now<=11) return message = "Good Morning!";
    else if(now>=12 && now<=16) return message = "Good Afternoon!";
    else return message = "Good Evening";
    /*switch (now) {
      case 6:
        message = "Good Evening!";
        i=i+1;
        break;
      case 4-11:
        message = "Good Morning!";
        break;
      case 12-16:
        message = "Good Afternoon!";
        break;
      case 17-24:
        message = "Good Evening!";
        break;
      default:
        message = "Default!";
    }*/
    return message;
  }


  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("widget is building");

    Widget titleSection = Container(
      padding: const EdgeInsets.all(0),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /*2*/
                Container(
                  padding: EdgeInsets.only(bottom: 0),
                  child: Text(
                    getTime(),
                    style: GoogleFonts.lato(
                        color: Colors.white70,
                        fontSize: 30,
                        fontWeight: FontWeight.w600
                    )
                  ),
                ),
                Text(
                  'It is time for a quick break!',
        style: GoogleFonts.lato(
        height: 2.5,
        color: Colors.white54,
        fontSize: 25,
        fontWeight: FontWeight.w600
    )
                ),
              ],
            ),
          ),
        ], //Children
      ),
    );

    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(Color.fromRGBO(236, 253, 241, 1.0), 'Give me a cue', context),
        ],
      ),
    );


    return Scaffold(
    backgroundColor: Color.fromRGBO(71, 140, 92, 1.0),
    appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white70),
        centerTitle: true,
        title: Text(
            title,
            style: GoogleFonts.lato(
            fontSize: 22,
            fontWeight: FontWeight.w500,
              color: Colors.white70
          ),
        ),
        backgroundColor: Color.fromRGBO(1, 58, 32, 1.0),
        //foregroundColor: Colors.amberAccent,
    ),
      body: OrientationBuilder(

        builder: (context, orientation){
          if(orientation == Orientation.portrait){
            return
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:[
                    titleSection,
                    buttonSection,
                    Image.asset(
                      'images/homepage_cropped.png',
                      //fit: BoxFit.cover,
                      alignment: Alignment.bottomCenter,
                    ),
                  ]
              );
          }else{
            print("entering landscape");
            return
              Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:[
                    Expanded(child:
                  Column(
                      //mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:[
                    titleSection,
                    buttonSection]),
                    ),
                    Image.asset(
                      'images/homepage_cropped.png',
                      //fit: BoxFit.cover,
                      alignment: Alignment.centerRight,
                    ),
                  ]
              );
          }
        },
      ),

      drawer: Drawer(
        child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child:
                Container(
                  alignment: Alignment.centerLeft,
                  child:  Text(
                     'Quick Break',
                      textAlign : TextAlign.center,
                       style: GoogleFonts.lato(
                         fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.white54,
                    ),
                ),
                  height: 15,
              ),

                decoration: BoxDecoration(
                  color: Color.fromRGBO(71, 140, 92, 1.0),
                ),
              ),
              ListTile(
                title: Text ("Feedback",
                  style: GoogleFonts.lato(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  )
                ),
                onTap: () async{
                  //Update state of the app
                  //Navigator.pop(context);
                  final Email email = Email(
                    body: '',
                    subject: 'App Feedback',
                    recipients: ['quickbreak.contact@gmail.com'],
                    //cc: ['cc@example.com'],
                   // bcc: ['bcc@example.com'],
                    //attachmentPaths: ['/path/to/attachment.zip'],
                    isHTML: false,
                  );

                  await FlutterEmailSender.send(email);
                },
              ),
              ListTile(
                title: Text ("Invite friends",
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                ),
                onTap: (){
                  print ("arghh");
                  Share.share('check out my quick_break app');
                  //Update state of the app
                  //Navigator.pop(context);
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondRoute()),
              );
            },
            child: Text(label),
            style: ElevatedButton.styleFrom(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(50.0),
                ),
                primary: color, // background
                onPrimary: Colors.black54, // foreground
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                textStyle: GoogleFonts.lato(
                    fontSize: 25,
                    fontWeight: FontWeight.normal)
            ), //Style
          ),
        ),
      ], //children
    );
  }
}

class RandomNumberProvider extends ChangeNotifier{
  int _rannum = 1;
  int _total = 45;

  void generateNumber(){
    var random = new Random();
    _rannum = random.nextInt(_total)+1;
    //Call this whenever there is some change in any field of change notifier.
    notifyListeners();
    print("generated rannum");
  }

  //Getter for random number
  int get randomNumber => _rannum;
}


class SecondRoute extends StatelessWidget {
  int docId;
  String str = 'default';

  //get provider => null;
  @override
  Widget build(BuildContext context) {

    Widget cardSection = Consumer<RandomNumberProvider>(
        builder: (context, provider, child) {
          return
            FutureBuilder(
              future: getTask(provider.randomNumber),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data = snapshot.data.data() as Map<
                      String,
                      dynamic>;
                  this.str = data['Task'];
                  print(str);
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [ ConstrainedBox(
                      constraints: BoxConstraints(
                          minWidth: MediaQuery.of(context).size.width/2,
                          minHeight: MediaQuery.of(context).size.height/2,
                          maxWidth: MediaQuery.of(context).size.width*0.75,
                          maxHeight: MediaQuery.of(context).size.height/2),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          str,
                          textAlign: TextAlign.center,
                        ),
                        style: ElevatedButton.styleFrom(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(50.0),
                            ),
                            primary: Color.fromRGBO(236, 253, 241, 1.0),
                            // background
                            onPrimary: Color.fromARGB(250, 54, 69, 79),
                            // foreground
                            padding: EdgeInsets.symmetric(horizontal: 50,
                                vertical: 50),
                            textStyle: GoogleFonts.lato(
                                fontSize: 25,
                                fontWeight: FontWeight.normal
                            )
                        ), // Style
                      ),
                    )
                    ],
                  );
                } else if (snapshot.connectionState == ConnectionState.none) {
                  return Text("No data");
                }
                return CircularProgressIndicator(
                  color: Color.fromRGBO(236, 253, 241, 1.0)
                );
              },
            );
        }
    );

    Widget nextSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: new ElevatedButton(
                  //onPressed: () => Provider.of<RandomNumberProvider>(context, listen: false).generateNumber(),
                  onPressed: () {
                    print("fail check1");
                    context.read<RandomNumberProvider>().generateNumber();
                    print("fail check2");
                  },
                  child: Text('Next'),
                  style: ElevatedButton.styleFrom(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                      ),
                      primary: Color.fromRGBO(236, 253, 241, 1.0),
                      // background
                      onPrimary: Colors.black54,
                      // foreground
                      padding: EdgeInsets.symmetric(
                          horizontal: 25, vertical: 25),
                      textStyle: GoogleFonts.lato(
                          fontSize: 20,
                          fontWeight: FontWeight.normal)
                  ), //Style
                ),
              ),
            ], //children
          ),

        ], // Children
      ),
    );

 //   return ChangeNotifierProvider<RandomNumberProvider>(
 //       create: (_) => RandomNumberProvider(),
 //       child: Builder(
  //          builder: (context) {
              return Scaffold(
                backgroundColor: Color.fromRGBO(71, 140, 92, 1.0),
                appBar: AppBar(
                    iconTheme: IconThemeData(color: Colors.white70),
                    centerTitle: true,
                    title: Text("Quick Break",
                    style: GoogleFonts.lato(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                    ),
                    ),
                    backgroundColor: Color.fromRGBO(1, 58, 32, 1.0)
                ),
                body:
                OrientationBuilder(
                  builder: (context, orientation) {
                    if (orientation == Orientation.portrait) {
                      return
                        Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              cardSection,
                              nextSection,
                            ]
                        );
                    }
                    else{
                      return
                      Container(
                        alignment: Alignment.center,
                        child:
                        Row(
                            //mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              cardSection,
                              nextSection,
                            ]
                        )
                      );
                    }
                  }
              )
              );
           // }//
        //)//
    //);//
  }

  Future<DocumentSnapshot> getTask(a) async {
    //await Firebase.initializeApp();
    //int num = 5;
    //var random = new Random();
   // docId = random.nextInt(num)+1;
    docId = a;
    print(docId);
    return await FirebaseFirestore.instance
        .collection("prompts")
        .doc(docId.toString())
        .get();
  }
}


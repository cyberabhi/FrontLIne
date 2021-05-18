import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intro/Start.dart';
import 'package:intro/services/covid.dart';
import 'package:intro/services/quotes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  Homepage({Key key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //APIs
  PositiveQuotes q = PositiveQuotes();
  CovidData c = CovidData();

  String _quotess = "Loading...";
  String _author = "Loading...";
  int _totalCases = 0, _totalRecovered = 0, _totalDeath = 0;

  void gettheQuotes() async {
    Map temp = await q.getQuotes();
    if (mounted) {
      setState(() {
        _quotess = temp['q'];
        _author = temp['a'];
      });
    }
  }

  void getthecoviddata() async {
    Map covidTemp = await c.getCovidData();
    if (mounted) {
      setState(() {
        _totalCases = covidTemp["total"];
        _totalRecovered = covidTemp["discharged"];
        _totalDeath = covidTemp["deaths"];
      });
    }
  }

  //Authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Start()));
      }
    });
  }

  getUser() async {
    User firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isloggedin = true;
      });
    }
  }

  signOut() async {
    _auth.signOut();
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
    this.getUser();
    this.gettheQuotes();
    this.getthecoviddata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('My Dashboard'),
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Colors.redAccent,
          actions: [ModalWidget()],
        ),
        body: Container(
          child: !isloggedin
              ? Center(
                  child: (CircularProgressIndicator(
                    backgroundColor: Colors.redAccent,
                    valueColor: AlwaysStoppedAnimation(Colors.blueAccent),
                    strokeWidth: 5,
                  )),
                )
              : Column(
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    Container(
                      child: Text(
                        "Hello ${user.displayName}....You are doing a great job.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 40.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: ListTile(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              'Quote of the day! by     -- $_author',
                              textAlign: TextAlign.center,
                            ),
                          ));
                        },
                        tileColor: Colors.indigoAccent,
                        title: Text(
                          _quotess,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.dancingScript(
                              textStyle: TextStyle(
                                  fontSize: 30.0, color: Colors.white)),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      // Covid Data
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              "$_totalCases",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Text('Total Cases'),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              "$_totalRecovered",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Text('Total Recovered'),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              "$_totalDeath",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Text('Total Deceased'),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 15.0),
                    ElevatedButton(
                      onPressed: signOut,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                        child: Text(
                          'Log Out',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ],
                ),
        ));
  }
}

// For Modals
class ModalWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.more_vert),
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 300,
              color: Colors.redAccent,
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(1),
                      child: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

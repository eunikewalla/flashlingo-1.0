import 'package:flashlingo1_0/settings/ColorScheme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashlingo1_0/page/LevelPage.dart';
import 'package:flashlingo1_0/settings/bottomNavbar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userData;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    User user = FirebaseAuth.instance.currentUser!;
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    userData = userDoc.data();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: lightBlue,
      body: Column(
        children: [
          Container(
            child: Column(
              children: [SizedBox(height: 50)],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/searchbg.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello,",
                    style: TextStyle(fontSize: 20, fontFamily: 'circe'),
                  ),
                  Text(
                    userData['first_name'] ?? '',
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'circe',
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(30),
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Level",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      TextButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LevelPage())),
                          child: Text(
                            "See all",
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 13,
                            ),
                          )),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          LevelList(
                            img: "Colors",
                            name: "COLORS",
                            lvl: "Level 1",
                            lv: "1",
                            redirect: "Level1",
                          ),
                          LevelList(
                            img: "Shapes",
                            name: "SHAPES",
                            lvl: "Level 2",
                            lv: "2",
                            redirect: "Level2",
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavbar(currentIndex: 0),
    );
  }
}

class LevelList extends StatelessWidget {
  final String name;
  final String lvl;
  final String img;
  final String lv;
  final String redirect;

  const LevelList(
      {super.key,
      required this.name,
      required this.lvl,
      required this.img,
      required this.lv,
      required this.redirect});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, "/${redirect}"),
      child: Container(
        margin: EdgeInsets.only(top: 20),
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Row(
          children: [
            Container(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(30)),
                    child: Container(
                      height: 125,
                      width: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/iconBgNew.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 130,
                    padding: EdgeInsets.only(left: 5, top: 5),
                    child: Stack(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          child: RotatedBox(
                            quarterTurns: 2,
                            child: Icon(
                              Icons.star,
                              color: Colors.blueGrey,
                              size: 55,
                            ),
                          ),
                        ),
                        Container(
                          width: 60,
                          height: 60,
                          child: Center(
                            child: Text(
                              '$lv',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 60,
                    child: Container(
                      width: 90,
                      height: 130,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/$img.png'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 35, horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(90, 91, 159, 1.0),
                          ),
                        ),
                        Text('$lvl')
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

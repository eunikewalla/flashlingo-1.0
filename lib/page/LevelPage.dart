import 'package:flashlingo1_0/settings/ColorScheme.dart';
import 'package:flashlingo1_0/settings/bottomNavbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LevelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/snowbg.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              child: Column(
                children: [SizedBox(height: 30)],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 40,
                  mainAxisSpacing: 30,
                  children: [
                    LevelWidget(
                      img: "Colors",
                      name: "COLORS",
                      lvl: "Level 1",
                      lv: "1",
                      redirect: "Level1",
                    ),
                    LevelWidget(
                      img: "Shapes",
                      name: "SHAPES",
                      lvl: "Level 2",
                      lv: "2",
                      redirect: "Level2",
                    ),
                    LevelWidget(
                      img: "Numbers",
                      name: "NUMBERS",
                      lvl: "Level 3",
                      lv: "3",
                      redirect: "Level3",
                    ),
                    LevelWidget(
                      img: "Animals",
                      name: "ANIMAL",
                      lvl: "Level 4",
                      lv: "4",
                      redirect: "Level4",
                    ),
                    LevelWidget(
                      img: "objects",
                      name: "OBJECTS",
                      lvl: "Level 5",
                      lv: "5",
                      redirect: "Level5",
                    ),
                    LevelWidget(
                      img: "clothes",
                      name: "ClOTHES",
                      lvl: "Level 6",
                      lv: "6",
                      redirect: "Level6",
                    ),
                    LevelWidget(
                      img: "Food",
                      name: "FOOD",
                      lvl: "Level 7",
                      lv: "7",
                      redirect: "Level7",
                    ),
                    LevelWidget(
                      img: "body",
                      name: "BODY",
                      lvl: "Level 8",
                      lv: "8",
                      redirect: "Level8",
                    ),
                    LevelWidget(
                      img: "places",
                      name: "PLACES",
                      lvl: "Level 9",
                      lv: "9",
                      redirect: "Level9",
                    ),
                    LevelWidget(
                      img: "quiz",
                      name: "QUIZ",
                      lvl: "End",
                      lv: "10",
                      redirect: "Level10",
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20)
          ],
        ),
      ),
      bottomNavigationBar: BottomNavbar(currentIndex: 1),
    );
  }
}

class LevelWidget extends StatelessWidget {
  final String name;
  final String img;
  final String lv;
  final String lvl;
  final String redirect;

  const LevelWidget({
    Key? key,
    required this.name,
    required this.img,
    required this.lv,
    required this.lvl,
    required this.redirect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, "/$redirect"),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 5),
              color: lightBlue,
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 130,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 50,
                      height: 45,
                      child: RotatedBox(
                        quarterTurns: 2,
                        child: Icon(
                          Icons.star,
                          color: const Color.fromARGB(255, 128, 172, 193),
                          size: 55,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 5,
                    top: 5,
                    child: Container(
                      width: 35,
                      height: 20,
                      child: Center(
                        child: Text(
                          lv,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 38,
                    top: 10,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/$img.png'),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Positioned(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                    )),
                  )
                ],
              ),
            ),
            // Expanded(
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Column(
            //           mainAxisAlignment: MainAxisAlignment.spaceAround,
            //           children: [
            //             Text(
            //               name,
            //               style: TextStyle(
            //                 fontSize: 16,
            //                 fontWeight: FontWeight.w700,
            //                 color: Color.fromRGBO(90, 91, 159, 1.0),
            //               ),
            //             ),
            //             Text('$lvl')
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}

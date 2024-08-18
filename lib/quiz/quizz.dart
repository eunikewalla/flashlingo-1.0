import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashlingo1_0/Flashcards/Level2.dart';
import 'package:flashlingo1_0/page/HomePage.dart';
import 'package:flashlingo1_0/settings/ColorScheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Quiz extends StatefulWidget {
  final int level;

  const Quiz({Key? key, required this.level}) : super(key: key);

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  late List<ItemModel> items;
  late List<ItemModel> items2;

  late int score;
  late bool gameOver;

  @override
  void initState() {
    super.initState();
    initGame();
  }

  Future<void> initGame() async {
    gameOver = false;
    score = 0;
    items = getItemsForLevel(widget.level);
    items2 = List<ItemModel>.from(items);
    items.shuffle();
    items2.shuffle();

    // Reset the level score in Firestore when starting a new game
    await resetLevelScoreInFirestore();
    setState(() {});
  }

  List<ItemModel> getItemsForLevel(int level) {
    switch (level) {
      case 1:
        return [
          ItemModel(name: "Red", value: "Red", img: "merah"),
          ItemModel(name: "Green", value: "Hijau", img: "hijau"),
          ItemModel(name: "Blue", value: "Biru", img: "biru"),
          ItemModel(name: "Yellow", value: "Kuning", img: "kuning"),
          ItemModel(name: "White", value: "Putih", img: "putih"),
          ItemModel(name: "Orange", value: "Oranye", img: "orange"),
          ItemModel(name: "Pink", value: "Merah Muda", img: "pink"),
          ItemModel(name: "Purple", value: "Ungu", img: "ungu"),
          ItemModel(name: "Grey", value: "Abu", img: "abu"),
          ItemModel(name: "Black", value: "Hitam", img: "hitam")
        ];
      case 2:
        return [
          ItemModel(name: "Square", value: "Persegi", img: "square"),
          ItemModel(
              name: "Rectagle", value: "Persegi Panjang", img: "rectangle"),
          ItemModel(name: "Circle", value: "Lingkaran", img: "circle"),
          ItemModel(name: "Triangle", value: "Segitiga", img: "triangle"),
          ItemModel(name: "Oval", value: "Oval", img: "oval"),
          ItemModel(name: "Heart", value: "Hati", img: "heart"),
          ItemModel(name: "Star", value: "Bintang", img: "star"),
          ItemModel(name: "Diamond", value: "Wajik", img: "diamond"),
          ItemModel(name: "Crescent", value: "Bulan Sabit", img: "crescent"),
          ItemModel(name: "Hexagon", value: "Hexagon", img: "hexagon")
        ];
      // Add more cases for other levels
      default:
        return [];
    }
  }

  Future<void> resetLevelScoreInFirestore() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({
          'level_scores.level_${widget.level}': 0,
        });
      }
    } catch (e) {
      print("Error resetting level score: $e");
    }
  }

  Future<void> updateScoreInFirestore(int change) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        int currentScore = userDoc['score'] ?? 0;
        int newScore = currentScore + change;

        Map<String, dynamic> levelScores = userDoc['level_scores'] ?? {};
        int currentLevelScore = levelScores['level_${widget.level}'] ?? 0;
        int newLevelScore = currentLevelScore + change;

        levelScores['level_${widget.level}'] = newLevelScore;

        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({
          'score': newScore,
          'level_scores': levelScores,
        });
      }
    } catch (e) {
      print("Error updating score: $e");
    }
  }

  Future<void> saveFinalScore() async {
    try {
      await updateScoreInFirestore(score);
    } catch (e) {
      print("Error saving final score: $e");
    }
  }

  void handleGameOver() {
    setState(() {
      gameOver = true;
    });
    saveFinalScore();
  }

  @override
  Widget build(BuildContext context) {
    if (gameOver) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Game Over!"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Final Score: $score", style: TextStyle(fontSize: 24)),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Quiz(level: widget.level + 1)),
                  );
                },
                child: Text("Next Level"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                child: Text("Homepage"),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: lightBlue,
      appBar: AppBar(
        title: Text("Score: $score"),
        backgroundColor: lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            if (!gameOver)
              Row(
                children: <Widget>[
                  Column(
                    children: items.map((item) {
                      return Container(
                        margin: const EdgeInsets.all(8.0),
                        child: Draggable<ItemModel>(
                          data: item,
                          childWhenDragging: _buildImageWidget(
                            'assets/images/transparent.png',
                          ),
                          feedback: _buildImageWidget(item.imagePath),
                          child: _buildImageWidget(item.imagePath),
                        ),
                      );
                    }).toList(),
                  ),
                  Spacer(),
                  Column(
                    children: items2.map((item) {
                      return DragTarget<ItemModel>(
                        onAccept: (receivedItem) {
                          if (item.value == receivedItem.value) {
                            setState(() {
                              items.remove(receivedItem);
                              items2.remove(item);
                              score += 10;
                              item.accepting = false;
                              updateScoreInFirestore(
                                  10); // Update score in Firestore
                            });
                          } else {
                            setState(() {
                              score -= 5;
                              item.accepting = false;
                              updateScoreInFirestore(
                                  -5); // Update score in Firestore
                            });
                          }
                        },
                        onLeave: (receivedItem) {
                          setState(() {
                            item.accepting = false;
                          });
                        },
                        onWillAccept: (receivedItem) {
                          setState(() {
                            item.accepting = true;
                          });
                          return true;
                        },
                        builder: (context, acceptedItems, rejectedItem) =>
                            ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: item.accepting ? Colors.red : Colors.teal,
                            ),
                            height: 80,
                            width: 100,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.all(8.0),
                            child: Text(
                              item.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            if (gameOver)
              Column(
                children: [
                  Text(
                    "Fantastis!",
                    style: TextStyle(
                      fontSize: 60,
                      fontFamily: 'circe',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Image.asset(
                    "assets/images/trophy.png",
                    width: 300,
                    height: 300,
                  ),
                  Text(
                    "SCORE",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'circe'),
                  ),
                  Text(
                    "$score",
                    style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'circe',
                        color: Colors.green),
                  ),
                ],
              ),
            if (gameOver)
              Column(
                children: [
                  SizedBox(height: 20),
                  Center(
                      child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Level2()));
                    },
                    child: Text('Level Berikutnya',
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Color.fromARGB(255, 78, 90, 126),
                      backgroundColor: Color.fromARGB(
                          255, 50, 51, 108), // Background color on press
                      padding:
                          EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  )),
                  Center(
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          },
                          child: Text("homepage",
                              style: TextStyle(
                                  color: Colors.black45, fontSize: 18)))),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageWidget(String imagePath) {
    return FutureBuilder(
      future: _checkIfImageExists(imagePath),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          if (snapshot.hasData && snapshot.data!) {
            return Image.asset(
              imagePath,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            );
          } else {
            return SizedBox.shrink();
          }
        }
      },
    );
  }

  Future<bool> _checkIfImageExists(String imagePath) async {
    try {
      ByteData data = await rootBundle.load(imagePath);
      return data.buffer.asUint8List().isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}

class ItemModel {
  final String name;
  final String value;
  final String img;
  bool accepting;

  ItemModel({
    required this.name,
    required this.value,
    required this.img,
    this.accepting = false,
  });

  String get imagePath => 'assets/images/$img.png';
}

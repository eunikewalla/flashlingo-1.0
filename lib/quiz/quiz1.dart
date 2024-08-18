import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashlingo1_0/Flashcards/Level2.dart';
import 'package:flashlingo1_0/Flashcards/Level3.dart';
import 'package:flashlingo1_0/Flashcards/Level4.dart';
import 'package:flashlingo1_0/Flashcards/Level5.dart';
import 'package:flashlingo1_0/Flashcards/Level6.dart';
import 'package:flashlingo1_0/Flashcards/Level7.dart';
import 'package:flashlingo1_0/Flashcards/Level8.dart';
import 'package:flashlingo1_0/Flashcards/Level9.dart';
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
      case 3:
        return [
          ItemModel(value: 'Satu', name: 'One', img: 'satu'),
          ItemModel(value: 'Dua', name: 'Two', img: 'dua'),
          ItemModel(value: 'Tiga', name: 'Three', img: 'tiga'),
          ItemModel(value: 'Empat', name: 'Four', img: 'empat'),
          ItemModel(value: 'Lima', name: 'Five', img: 'lima'),
          ItemModel(value: 'Enam', name: 'Six', img: 'enam'),
          ItemModel(value: 'Tujuh', name: 'Seven', img: 'tujuh'),
          ItemModel(value: 'Delapan', name: 'Eight', img: 'delapan'),
          ItemModel(value: 'Sembilan', name: 'Nine', img: 'sembilan'),
          ItemModel(value: 'Sepuluh', name: 'Ten', img: 'sepuluh'),
        ];
      case 4:
        return [
          ItemModel(value: 'Anjing', name: 'Dog', img: 'dog'),
          ItemModel(value: 'Kucing', name: 'Cat', img: 'cat'),
          ItemModel(value: 'Monyet', name: 'Monkey', img: 'monkey'),
          ItemModel(value: 'Gajah', name: 'Elephant', img: 'elephant'),
          ItemModel(value: 'Singa', name: 'Lion', img: 'lion'),
          ItemModel(value: 'Jerapah', name: 'Giraffle', img: 'giraffle'),
          ItemModel(value: 'Burung', name: 'Bird', img: 'birds'),
          ItemModel(value: 'Hiu', name: 'Sharks', img: 'sharks'),
          ItemModel(value: 'Tikus', name: 'Mouse', img: 'mouse'),
          ItemModel(value: 'Semut', name: 'Ant', img: 'ant'),
        ];
      case 5:
        return [
          ItemModel(value: 'Buku', name: 'Book', img: 'book'),
          ItemModel(value: 'Pensil', name: 'Pencil', img: 'pencil'),
          ItemModel(value: 'Ransel', name: 'Backpack', img: 'backpack'),
          ItemModel(value: 'Jam', name: 'Clock', img: 'clock'),
          ItemModel(value: 'Kursi', name: 'Chair', img: 'chair'),
          ItemModel(value: 'Meja', name: 'Table', img: 'table'),
          ItemModel(value: 'Sepeda', name: 'Bicycle', img: 'bicycle'),
          ItemModel(value: 'Kasur', name: 'Bed', img: 'bed'),
          ItemModel(value: 'Boneka', name: 'Doll', img: 'doll'),
          ItemModel(value: 'Payung', name: 'Umbrella', img: 'umbrella'),
        ];
      case 6:
        return [
          ItemModel(value: 'Gaun', name: 'Dress', img: 'dress'),
          ItemModel(value: 'Celana', name: 'Pants', img: 'pants'),
          ItemModel(value: 'Rok', name: 'Skirt', img: 'skirts'),
          ItemModel(value: 'Kaos', name: 'T-shirt', img: 'tshirt'),
          ItemModel(value: 'Kemeja', name: 'Shirt', img: 'shirt'),
          ItemModel(value: 'Sweter', name: 'Sweater', img: 'sweater'),
          ItemModel(value: 'Jaket', name: 'Jacket', img: 'jacket'),
          ItemModel(value: 'Celana Pendek', name: 'Shorts', img: 'shorts'),
          ItemModel(value: 'Baju Renang', name: 'Swimsuit', img: 'swimsuit'),
          ItemModel(value: 'Mantel', name: 'Coat', img: 'coat'),
        ];
      case 7:
        return [
          ItemModel(value: 'Nasi', name: 'Rice', img: 'rice'),
          ItemModel(value: 'Mie', name: 'Noodle', img: 'noodle'),
          ItemModel(value: 'Telur', name: 'Egg', img: 'egg'),
          ItemModel(value: 'Keju', name: 'Cheese', img: 'cheese'),
          ItemModel(value: 'Jus', name: 'Juice', img: 'juice'),
          ItemModel(value: 'Wortel', name: 'Carrot', img: 'carrot'),
          ItemModel(value: 'Apel', name: 'Apple', img: 'apple'),
          ItemModel(value: 'Pisang', name: 'Banana', img: 'banana'),
          ItemModel(value: 'Roti', name: 'Bread', img: 'bread'),
          ItemModel(value: 'Kentang Goreng', name: 'Fries', img: 'fries'),
        ];
      case 8:
        return [
          ItemModel(value: 'Kepala', name: 'Head', img: 'head'),
          ItemModel(value: 'Mata', name: 'Eyes', img: 'eyes'),
          ItemModel(value: 'Mulut', name: 'Mouth', img: 'mouth'),
          ItemModel(value: 'Hidung', name: 'Nose', img: 'nose'),
          ItemModel(value: 'Telinga', name: 'Ears', img: 'ears'),
          ItemModel(value: 'Lengan', name: 'Arms', img: 'arms'),
          ItemModel(value: 'Rambut', name: 'Hair', img: 'hair'),
          ItemModel(value: 'Kaki', name: 'Leg', img: 'leg'),
          ItemModel(value: 'Telapak Kaki', name: 'Feet', img: 'feet'),
          ItemModel(value: 'Perut', name: 'Stomach', img: 'stomach'),
        ];
      case 9:
        return [
          ItemModel(value: 'Rumah', name: 'House', img: 'house'),
          ItemModel(value: 'Sekolah', name: 'School', img: 'school'),
          ItemModel(value: 'Rumah Sakit', name: 'Hospital', img: 'hospital'),
          ItemModel(value: 'Taman', name: 'Park', img: 'park'),
          ItemModel(value: 'Restoran', name: 'Restaurant', img: 'restaurant'),
          ItemModel(
              value: 'Kantor Polisi', name: 'Police Station', img: 'police'),
          ItemModel(value: 'Bandara', name: 'Airport', img: 'airport'),
          ItemModel(value: 'Pasar', name: 'Market', img: 'market'),
          ItemModel(value: 'Ungu', name: 'Purple', img: 'ungu'),
          ItemModel(value: 'Pantai', name: 'Beach', img: 'beach')
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

        Map<String, dynamic> levelScores =
            Map<String, dynamic>.from(userDoc['level_scores'] ?? {});
        int currentLevelScore = levelScores['level_${widget.level}'] ?? 0;
        int newLevelScore = currentLevelScore + change;

        levelScores['level_${widget.level}'] = newLevelScore;

        int totalScore = levelScores.values
            .fold(0, (sum, levelScore) => sum + (levelScore as int));

        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({
          'score': totalScore,
          'level_scores': levelScores,
        });

        setState(() {
          score = newLevelScore;
        });
      }
    } catch (e) {
      print("Error updating score: $e");
    }
  }

  Future<void> saveFinalScore() async {
    try {
      await updateScoreInFirestore(10);
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

  void checkGameOver() {
    if (items.isEmpty && items2.isEmpty) {
      handleGameOver();
    }
  }

  Widget getNextLevelWidget(int level) {
    switch (level) {
      case 1:
        return Level2();
      case 2:
        return Level3();
      case 3:
        return Level4();
      case 4:
        return Level5();
      case 5:
        return Level6();
      case 6:
        return Level7();
      case 7:
        return Level8();
      case 8:
        return Level9();
      default:
        return HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (gameOver) {
      return Scaffold(
        backgroundColor: lightBlue,
        appBar: AppBar(
          backgroundColor: lightBlue,
          actions: [
            IconButton(
              onPressed: () {
                initGame();
                setState(() {});
              },
              icon: Icon(
                Icons.refresh,
                color: Colors.black,
                size: 35,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
              SizedBox(height: 20),
              Text("Final Score: $score", style: TextStyle(fontSize: 24)),
              Column(
                children: [
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                getNextLevelWidget(widget.level),
                          ),
                        );
                      },
                      child: Text('Level Berikutnya',
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Color.fromARGB(255, 78, 90, 126),
                        backgroundColor: Color.fromARGB(255, 50, 51, 108),
                        padding:
                            EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                  ),
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

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 201, 244, 247),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: [
          if (!gameOver)
            Padding(
              padding: const EdgeInsets.only(right: 25, top: 10),
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Center(
                      child: Text.rich(TextSpan(children: [
                        TextSpan(text: "Score: "),
                        TextSpan(
                          text: "$score",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        )
                      ])),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            child: Image.asset(
              'assets/images/quizBg.png',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
          SingleChildScrollView(
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
                                  updateScoreInFirestore(10);
                                });
                                checkGameOver();
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
                                  color:
                                      item.accepting ? Colors.red : Colors.teal,
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
        ],
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

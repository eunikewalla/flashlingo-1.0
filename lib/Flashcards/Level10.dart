import 'package:confetti/confetti.dart';
import 'package:flashlingo1_0/settings/ColorScheme.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashlingo1_0/page/HomePage.dart';
import 'package:flutter/widgets.dart';

class Level10 extends StatefulWidget {
  final int level;

  Level10({required this.level});

  @override
  _Level10State createState() => _Level10State();
}

class _Level10State extends State<Level10> {
  late ConfettiController _confettiController;
  late List<Map<String, String>> words;
  int _currentWordIndex = 0;
  List<Letter> _draggedLetters = [];
  List<Letter> _availableLetters = [];
  String _feedbackMessage = '';
  int _score = 0;
  bool _gameOver = false;

  @override
  void initState() {
    super.initState();
    _initializeWords();
    initGame();
    _confettiController =
        ConfettiController(duration: const Duration(milliseconds: 800));
  }

  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _resetGame() {
    setState(() {
      _currentWordIndex = 0;
      _score = 0; // Reset score to 0
      _gameOver = false;
      _initializeWords();
    });

    resetLevelScoreInFirestore().then((_) {
      setState(() {
        _score = 0;
      });
    }).catchError((error) {
      print("Error resetting score in Firestore: $error");
    });
  }

  void _initializeWords() {
    words = [
      {'word': 'cat', 'image': 'cat'},
      {'word': 'dog', 'image': 'dog'},
      {'word': 'apple', 'image': 'apple'},
      {'word': 'banana', 'image': 'banana'},
      {'word': 'car', 'image': 'car'},
      {'word': "Red", 'image': "merah"},
      {'word': "Green", 'image': "hijau"},
      {'word': "Blue", 'image': "biru"},
      {'word': "Yellow", 'image': "kuning"},
      {'word': "White", 'image': "putih"},
      {'word': "Orange", 'image': "orange"},
      {'word': "Pink", 'image': "pink"},
      {'word': "Purple", 'image': "ungu"},
      {'word': "Grey", 'image': "abu"},
      {'word': "Black", 'image': "hitam"},
      {'word': "Square", 'image': "square"},
      {'word': "Rectagle", 'image': "rectangle"},
      {'word': "Circle", 'image': "circle"},
      {'word': "Triangle", 'image': "triangle"},
      {'word': "Oval", 'image': "oval"},
      {'word': "Heart", 'image': "heart"},
      {'word': "Star", 'image': "star"},
      {'word': "Diamond", 'image': "diamond"},
      {'word': "Crescent", 'image': "crescent"},
      {'word': "Hexagon", 'image': "hexagon"},
      {'word': 'One', 'image': 'satu'},
      {'word': 'Two', 'image': 'dua'},
      {'word': 'Three', 'image': 'tiga'},
      {'word': 'Four', 'image': 'empat'},
      {'word': 'Five', 'image': 'lima'},
      {'word': 'Six', 'image': 'enam'},
      {'word': 'Seven', 'image': 'tujuh'},
      {'word': 'Eight', 'image': 'delapan'},
      {'word': 'Nine', 'image': 'sembilan'},
      {'word': 'Ten', 'image': 'sepuluh'},
      {'word': 'Dog', 'image': 'dog'},
      {'word': 'Cat', 'image': 'cat'},
      {'word': 'Monkey', 'image': 'monkey'},
      {'word': 'Elephant', 'image': 'elephant'},
      {'word': 'Lion', 'image': 'lion'},
      {'word': 'Giraffle', 'image': 'giraffle'},
      {'word': 'Bird', 'image': 'birds'},
      {'word': 'Sharks', 'image': 'sharks'},
      {'word': 'Mouse', 'image': 'mouse'},
      {'word': 'Ant', 'image': 'ant'},
      {'word': 'Book', 'image': 'book'},
      {'word': 'Pencil', 'image': 'pencil'},
      {'word': 'Backpack', 'image': 'backpack'},
      {'word': 'Clock', 'image': 'clock'},
      {'word': 'Chair', 'image': 'chair'},
      {'word': 'Table', 'image': 'table'},
      {'word': 'Bicycle', 'image': 'bicycle'},
      {'word': 'Bed', 'image': 'bed'},
      {'word': 'Doll', 'image': 'doll'},
      {'word': 'Umbrella', 'image': 'umbrella'},
      {'word': 'Dress', 'image': 'dress'},
      {'word': 'Pants', 'image': 'pants'},
      {'word': 'Skirt', 'image': 'skirts'},
      {'word': 'T-shirt', 'image': 'tshirt'},
      {'word': 'Shirt', 'image': 'shirt'},
      {'word': 'Sweater', 'image': 'sweater'},
      {'word': 'Jacket', 'image': 'jacket'},
      {'word': 'Shorts', 'image': 'shorts'},
      {'word': 'Swimsuit', 'image': 'swimsuit'},
      {'word': 'Coat', 'image': 'coat'},
      {'word': 'Rice', 'image': 'rice'},
      {'word': 'Noodle', 'image': 'noodle'},
      {'word': 'Egg', 'image': 'egg'},
      {'word': 'Cheese', 'image': 'cheese'},
      {'word': 'Juice', 'image': 'juice'},
      {'word': 'Carrot', 'image': 'carrot'},
      {'word': 'Apple', 'image': 'apple'},
      {'word': 'Banana', 'image': 'banana'},
      {'word': 'Bread', 'image': 'bread'},
      {'word': 'Fries', 'image': 'fries'},
      {'word': 'Head', 'image': 'head'},
      {'word': 'Eyes', 'image': 'eyes'},
      {'word': 'Mouth', 'image': 'mouth'},
      {'word': 'Nose', 'image': 'nose'},
      {'word': 'Ears', 'image': 'ears'},
      {'word': 'Arms', 'image': 'arms'},
      {'word': 'Hair', 'image': 'hair'},
      {'word': 'Leg', 'image': 'leg'},
      {'word': 'Feet', 'image': 'feet'},
      {'word': 'Stomach', 'image': 'stomach'},
      {'word': 'House', 'image': 'house'},
      {'word': 'School', 'image': 'school'},
      {'word': 'Hospital', 'image': 'hospital'},
      {'word': 'Park', 'image': 'park'},
      {'word': 'Restaurant', 'image': 'restaurant'},
      {'word': 'Police Station', 'image': 'police'},
      {'word': 'Airport', 'image': 'airport'},
      {'word': 'Market', 'image': 'market'},
      {'word': 'Purple', 'image': 'ungu'},
      {'word': 'Beach', 'image': 'beach'}
    ];

    words.shuffle(Random());
    List<Map<String, String>> selectedWords = words.take(5).toList();

    words = selectedWords;

    final currentWord = words[_currentWordIndex]['word']!;
    _draggedLetters.clear();
    _availableLetters = currentWord
        .split('')
        .asMap()
        .entries
        .map((entry) => Letter(entry.value, entry.key))
        .toList();
    _availableLetters.shuffle(Random());
  }

  Future<void> initGame() async {
    _score = 0;
    await resetLevelScoreInFirestore();
  }

  void _loadCurrentWord() {
    final currentWord = words[_currentWordIndex]['word']!;
    _draggedLetters.clear();
    _availableLetters = currentWord
        .split('')
        .asMap()
        .entries
        .map((entry) => Letter(entry.value, entry.key))
        .toList();
    _availableLetters.shuffle(Random());
  }

  void _checkSpelling() {
    final spelledWord = _draggedLetters.map((e) => e.letter).join();
    if (spelledWord == words[_currentWordIndex]['word']) {
      setState(() {
        _feedbackMessage = 'Correct!';
        _updateScore(20);
        _nextWord();
      });
    } else {
      setState(() {
        _feedbackMessage = 'Try Again!';
        _updateScore(-10);
        _resetDraggedLetters();
      });
    }
  }

  void _resetDraggedLetters() {
    setState(() {
      _availableLetters = words[_currentWordIndex]['word']!
          .split('')
          .asMap()
          .entries
          .map((entry) => Letter(entry.value, entry.key))
          .toList();
      _draggedLetters.clear();
      _availableLetters.shuffle(Random());
    });
  }

  void _nextWord() {
    if (_currentWordIndex < words.length - 1) {
      setState(() {
        _currentWordIndex++;
        _feedbackMessage = '';
        _resetDraggedLetters();
        _loadCurrentWord();
      });
    } else {
      _handleGameOver();
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

  Future<void> _updateScore(int change) async {
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
          _score = newLevelScore;
        });
      }
    } catch (e) {
      print("Error updating score: $e");
    }
  }

  Future<void> _saveFinalScore() async {
    try {
      await _updateScore(10);
    } catch (e) {
      print("Error saving final score: $e");
    }
  }

  void _handleGameOver() {
    setState(() {
      _gameOver = true;
    });
    Future.delayed(Duration(milliseconds: 500), () {
      _confettiController.play();
    });
    _saveFinalScore();
  }

  @override
  Widget build(BuildContext context) {
    if (_gameOver) {
      return Scaffold(
        backgroundColor: lightBlue,
        appBar: AppBar(
          backgroundColor: lightBlue,
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  _currentWordIndex = 0;
                  _score = 0;
                  _gameOver = false;
                  _initializeWords();
                });

                resetLevelScoreInFirestore().then((_) {
                  print("Score reset successful in Firestore.");
                }).catchError((error) {
                  print("Error resetting score in Firestore: $error");
                });
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
          child: Stack(
            children: [
              if (_gameOver)
                Positioned(
                  child: ConfettiWidget(
                    confettiController: _confettiController,
                    blastDirectionality: BlastDirectionality.explosive,
                    shouldLoop: false,
                    blastDirection: -pi / 2,
                    maxBlastForce: 20,
                    minBlastForce: 8,
                    emissionFrequency: 0.05,
                    numberOfParticles: 20,
                    gravity: 0.1,
                  ),
                ),
              Center(
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
                    Text("Score: $_score", style: TextStyle(fontSize: 24)),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      },
                      child: Text('Homepage',
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
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    final currentWord = words[_currentWordIndex]['word']!;
    final currentImage =
        'assets/images/${words[_currentWordIndex]['image']}.png';

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: lightBlue,
        actions: [
          if (!_gameOver)
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
                          text: "$_score",
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
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            blastDirection: -pi / 2,
            maxBlastForce: 20,
            minBlastForce: 8,
            emissionFrequency: 0.05,
            numberOfParticles: 20,
            gravity: 0.1,
          ),
          Container(
            child: Image.asset(
              'assets/images/quizBg.png',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Spell the word:',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 20),
                Image(
                  image: AssetImage(currentImage),
                  height: 200,
                  width: 200,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _draggedLetters
                      .map((letter) =>
                          _buildLetterBox(letter.letter, Colors.blue))
                      .toList(),
                ),
                SizedBox(height: 20),
                DragTarget<Letter>(
                  onWillAccept: (letter) => true,
                  onAccept: (letter) {
                    setState(() {
                      _draggedLetters.add(letter);
                      _availableLetters.removeWhere((l) => l.id == letter.id);
                    });
                  },
                  builder: (context, candidateData, rejectedData) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (var i = 0; i < currentWord.length; i++)
                          if (i < _draggedLetters.length)
                            _buildLetterBox(
                                _draggedLetters[i].letter, Colors.blue)
                          else
                            _buildLetterBox('', Colors.blue)
                      ],
                    );
                  },
                ),
                SizedBox(height: 20),
                Text(
                  _feedbackMessage,
                  style: TextStyle(fontSize: 24, color: Colors.red),
                ),
                ElevatedButton(
                  onPressed: _checkSpelling,
                  child: Text('Check Spelling'),
                ),
                SizedBox(height: 20),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 10.0,
                  children: _availableLetters
                      .map((letter) => Draggable<Letter>(
                            data: letter,
                            child: _buildLetterBox(letter.letter, Colors.green),
                            feedback: _buildLetterBox(
                                letter.letter, Colors.green.withOpacity(0.7)),
                            childWhenDragging:
                                _buildLetterBox(letter.letter, Colors.grey),
                            onDragCompleted: () {
                              setState(() {
                                _availableLetters
                                    .removeWhere((l) => l.id == letter.id);
                              });
                            },
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLetterBox(String letter, Color color) {
    return Container(
      margin: EdgeInsets.all(4.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: color,
      ),
      child: Text(
        letter,
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
  }
}

class Letter {
  final String letter;
  final int id;

  Letter(this.letter, this.id);
}

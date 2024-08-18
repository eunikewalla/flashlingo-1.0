import 'package:flashlingo1_0/page/LevelPage.dart';
import 'package:flashlingo1_0/quiz/quiz1.dart';
import 'package:flashlingo1_0/settings/ColorScheme.dart';
import 'package:flashlingo1_0/Flashcards/flashSettings/flashcards_view.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class Level4 extends StatefulWidget {
  const Level4({Key? key}) : super(key: key);

  @override
  State<Level4> createState() => _Level4();
}

class _Level4 extends State<Level4> {
  List<Map<String, String>> _flashcards = [
    {'question': 'Anjing', 'answer': 'Dog', 'img': 'dog'},
    {'question': 'Kucing', 'answer': 'Cat', 'img': 'cat'},
    {'question': 'Monyet', 'answer': 'Monkey', 'img': 'monkey'},
    {'question': 'Gajah', 'answer': 'Elephant', 'img': 'elephant'},
    {'question': 'Singa', 'answer': 'Lion', 'img': 'lion'},
    {'question': 'Jerapah', 'answer': 'Giraffle', 'img': 'giraffle'},
    {'question': 'Burung', 'answer': 'Bird', 'img': 'birds'},
    {'question': 'Hiu', 'answer': 'Sharks', 'img': 'sharks'},
    {'question': 'Tikus', 'answer': 'Mouse', 'img': 'mouse'},
    {'question': 'Semut', 'answer': 'Ant', 'img': 'ant'},
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: lightBlue,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "ANIMALS",
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LevelPage()));
            },
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 350,
                height: 500,
                child: FlipCard(
                  front: Flashcardview(
                    text: _flashcards[_currentIndex]['question']!,
                    img: _flashcards[_currentIndex]['img']!,
                  ),
                  back: Flashcardview(
                    text: _flashcards[_currentIndex]['answer']!,
                    img: _flashcards[_currentIndex]['img']!,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlinedButton.icon(
                    onPressed: _currentIndex == 0 ? null : showPreviousCard,
                    icon: Icon(Icons.chevron_left),
                    label: Text('Prev'),
                  ),
                  OutlinedButton.icon(
                    onPressed: _currentIndex == _flashcards.length - 1
                        ? showSuccessDialog
                        : showNextCard,
                    icon: Icon(Icons.chevron_right),
                    label: Text('Next'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void showNextCard() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _flashcards.length;
    });
  }

  void showPreviousCard() {
    setState(() {
      _currentIndex =
          (_currentIndex - 1 + _flashcards.length) % _flashcards.length;
    });
  }

  void showSuccessDialog() {
    AwesomeDialog(
      context: context,
      animType: AnimType.leftSlide,
      headerAnimationLoop: false,
      dialogType: DialogType.success,
      showCloseIcon: true,
      title: 'Hore!',
      desc: 'Apakah Kamu Siap uji coba pengetahuanmu dengan kuis seru?',
      buttonsTextStyle: const TextStyle(color: Colors.black),
      btnCancelText: 'Tidak',
      btnOkText: 'Ya',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Quiz(level: 4)),
        );
      },
    ).show();
  }
}

import 'package:flashlingo1_0/page/LevelPage.dart';
import 'package:flashlingo1_0/quiz/quiz1.dart';
import 'package:flashlingo1_0/settings/ColorScheme.dart';
import 'package:flashlingo1_0/Flashcards/flashSettings/flashcards_view.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class Level7 extends StatefulWidget {
  const Level7({Key? key}) : super(key: key);

  @override
  State<Level7> createState() => _Level7();
}

class _Level7 extends State<Level7> {
  List<Map<String, String>> _flashcards = [
    {'question': 'Nasi', 'answer': 'Rice', 'img': 'rice'},
    {'question': 'Mie', 'answer': 'Noodle', 'img': 'noodle'},
    {'question': 'Telur', 'answer': 'Egg', 'img': 'egg'},
    {'question': 'Keju', 'answer': 'Cheese', 'img': 'cheese'},
    {'question': 'Jus', 'answer': 'Juice', 'img': 'juice'},
    {'question': 'Wortel', 'answer': 'Carrot', 'img': 'carrot'},
    {'question': 'Apel', 'answer': 'Apple', 'img': 'apple'},
    {'question': 'Pisang', 'answer': 'Banana', 'img': 'banana'},
    {'question': 'Roti', 'answer': 'Bread', 'img': 'bread'},
    {'question': 'Kentang Goreng', 'answer': 'Fries', 'img': 'fries'},
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
            "COLORS",
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
          MaterialPageRoute(builder: (context) => Quiz(level: 7)),
        );
      },
    ).show();
  }
}

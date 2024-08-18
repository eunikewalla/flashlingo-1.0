import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashlingo1_0/Flashcards/Level10.dart';
import 'package:flashlingo1_0/Flashcards/Level2.dart';
import 'package:flashlingo1_0/Flashcards/Level3.dart';
import 'package:flashlingo1_0/Flashcards/Level4.dart';
import 'package:flashlingo1_0/Flashcards/Level5.dart';
import 'package:flashlingo1_0/Flashcards/Level6.dart';
import 'package:flashlingo1_0/Flashcards/Level7.dart';
import 'package:flashlingo1_0/Flashcards/Level8.dart';
import 'package:flashlingo1_0/Flashcards/Level9.dart';
import 'package:flashlingo1_0/firebase/ForgotPassword.dart';
import 'package:flashlingo1_0/firebase/auth_service.dart';
import 'package:flashlingo1_0/firebase/signup.dart';
import 'package:flutter/material.dart';
import 'package:flashlingo1_0/Flashcards/Level1.dart';
import 'package:flashlingo1_0/settings/ColorScheme.dart';
import 'page/HomePage.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlashLingo',
      home: MyHomePage(),
      routes: {
        '/HomePage': (context) => HomePage(),
        '/Level1': (context) => Level1(),
        '/Level2': (context) => Level2(),
        '/Level3': (context) => Level3(),
        '/Level4': (context) => Level4(),
        '/Level5': (context) => Level5(),
        '/Level6': (context) => Level6(),
        '/Level7': (context) => Level7(),
        '/Level8': (context) => Level8(),
        '/Level9': (context) => Level9(),
        '/Level10': (context) => Level10(level: 10)
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String email = "", password = "", username = "";

  final FirebaseAuthService _auth = FirebaseAuthService();
  final _formkey = GlobalKey<FormState>(); 
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController usernamecontroller = TextEditingController();

  void dispose() {
    usernamecontroller.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: lightBlue,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                    image: AssetImage("assets/images/FlashLingo.png"),
                    width: 120,
                    height: 120,
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 10,
              height: MediaQuery.of(context).size.height * 0.45,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/images/SplashBG.png",
                    ),
                    fit: BoxFit.contain),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "English Playtime, ",
                    style: TextStyle(fontSize: 35, fontFamily: 'circe'),
                  ),
                  Text(
                    "Where Fun Meets Fluency!",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'circe',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Let's Learn English \n In a Fun Way with Flashcards",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'circe'),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 10,
                            color: Colors.black.withOpacity(0.1),
                          )),
                      child: Container(
                        padding: mediaQueryData.viewInsets,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 26, 40, 46),
                        ),
                        child: IconButton(
                          onPressed: () async {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setState) {
                                    return IntrinsicHeight(
                                      child: SingleChildScrollView(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom,
                                          ),
                                          child: Container(
                                            padding: EdgeInsets.all(16),
                                            child: Form(
                                              key:
                                                  _formkey, // Assign the GlobalKey to the Form widget
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(height: 25),
                                                  Text(
                                                    "Hello....",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.black),
                                                  ),
                                                  Text(
                                                    "Welcome Back!",
                                                    style: TextStyle(
                                                        fontSize: 30,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                  SizedBox(height: 25),
                                                  TextFormField(
                                                    controller: emailcontroller,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.trim() == "") {
                                                        return "Email is required";
                                                      } else if (!value
                                                          .trim()
                                                          .contains("@")) {
                                                        return "Email is not valid";
                                                      }
                                                      return null;
                                                    },
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      hintText:
                                                          "info@example.com",
                                                      labelText:
                                                          "Email / Username",
                                                      suffixIcon:
                                                          Icon(Icons.email),
                                                    ),
                                                  ),
                                                  SizedBox(height: 20),
                                                  TextFormField(
                                                    controller:
                                                        passwordcontroller,
                                                    obscureText: true,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value
                                                              .trim()
                                                              .isEmpty) {
                                                        return "Please enter a password";
                                                      }
                                                      return null;
                                                    },
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      labelText: "Password",
                                                      suffixIcon: Icon(Icons
                                                          .visibility_outlined),
                                                    ),
                                                  ),
                                                  SizedBox(height: 20),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "Don't have an account?",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          SignUp1()));

                                                          // showModalBottomSheet(
                                                          //   isScrollControlled:
                                                          //       true,
                                                          //   context: context,
                                                          //   builder: (context) {
                                                          //     return StatefulBuilder(
                                                          //         builder: (BuildContext
                                                          //                 context,
                                                          //             StateSetter
                                                          //                 setState) {
                                                          //       return Wrap(
                                                          //         children: [
                                                          //           Padding(
                                                          //             padding:
                                                          //                 EdgeInsets
                                                          //                     .only(
                                                          //               bottom: MediaQuery.of(
                                                          //                       context)
                                                          //                   .viewInsets
                                                          //                   .bottom,
                                                          //             ),
                                                          //             child:
                                                          //                 Container(
                                                          //               padding:
                                                          //                   EdgeInsets.all(
                                                          //                       16),
                                                          //               child:
                                                          //                   Column(
                                                          //                 crossAxisAlignment:
                                                          //                     CrossAxisAlignment.start,
                                                          //                 children: [
                                                          //                   SizedBox(
                                                          //                       height: 25),
                                                          // Text(
                                                          //   "Hello....",
                                                          //   style:
                                                          //       TextStyle(fontSize: 20, color: Colors.black),
                                                          // ),
                                                          // Text(
                                                          //   "Register",
                                                          //   style: TextStyle(
                                                          //       fontSize: 30,
                                                          //       fontWeight: FontWeight.bold,
                                                          //       color: Colors.black),
                                                          // ),
                                                          //                   SizedBox(
                                                          //                       height: 25),
                                                          //                   TextFormField(
                                                          //                     controller:
                                                          //                         emailcontroller,
                                                          //                     decoration:
                                                          //                         InputDecoration(
                                                          //                       border: OutlineInputBorder(
                                                          //                         borderRadius: BorderRadius.circular(10),
                                                          //                       ),
                                                          //                       hintText: "info@example.com",
                                                          //                       labelText: "Email",
                                                          //                       suffixIcon: Icon(Icons.email),
                                                          //                     ),
                                                          //                   ),
                                                          //                   SizedBox(
                                                          //                       height: 20),
                                                          //                   TextFormField(
                                                          //                     controller:
                                                          //                         usernamecontroller,
                                                          //                     decoration:
                                                          //                         InputDecoration(
                                                          //                       border: OutlineInputBorder(
                                                          //                         borderRadius: BorderRadius.circular(10),
                                                          //                       ),
                                                          //                       labelText: "Username",
                                                          //                       suffixIcon: Icon(Icons.account_circle_rounded),
                                                          //                     ),
                                                          //                   ),
                                                          //                   SizedBox(
                                                          //                       height: 20),
                                                          //                   TextFormField(
                                                          //                     obscureText:
                                                          //                         true,
                                                          //                     controller:
                                                          //                         passwordcontroller,
                                                          //                     decoration:
                                                          //                         InputDecoration(
                                                          //                       border: OutlineInputBorder(
                                                          //                         borderRadius: BorderRadius.circular(10),
                                                          //                       ),
                                                          //                       labelText: "Password",
                                                          //                       suffixIcon: Icon(Icons.visibility_outlined),
                                                          //                     ),
                                                          //                   ),
                                                          //                   SizedBox(
                                                          //                       height: 20),
                                                          //                   Row(
                                                          //                     mainAxisAlignment:
                                                          //                         MainAxisAlignment.end,
                                                          //                     children: [
                                                          //                       Padding(
                                                          //                         padding: const EdgeInsets.only(bottom: 12, top: 12),
                                                          //                         child: ElevatedButton(
                                                          //                           onPressed: _signUp,
                                                          //                           style: ElevatedButton.styleFrom(
                                                          //                             minimumSize: Size(150, 50),
                                                          //                             backgroundColor: Color.fromARGB(255, 26, 40, 46),
                                                          //                           ),
                                                          //                           child: Text(
                                                          //                             'Register',
                                                          //                             style: TextStyle(fontSize: 18, color: Colors.white),
                                                          //                           ),
                                                          //                         ),
                                                          //                       ),
                                                          //                       SizedBox(width: 20),
                                                          //                     ],
                                                          //                   ),
                                                          //                   SizedBox(
                                                          //                       height: 20),
                                                          //                 ],
                                                          //               ),
                                                          //             ),
                                                          //           ),
                                                          //         ],
                                                          //       );
                                                          //     });
                                                          //   },
                                                          // );
                                                        },
                                                        child: Text(
                                                          " Register Here",
                                                          style: TextStyle(
                                                            color: orange,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                bottom: 12,
                                                                top: 12),
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            if (_formkey
                                                                .currentState!
                                                                .validate()) {
                                                              _signIn();
                                                            }
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            minimumSize:
                                                                Size(165, 50),
                                                            backgroundColor:
                                                                Color.fromARGB(
                                                                    255,
                                                                    26,
                                                                    40,
                                                                    46),
                                                          ),
                                                          child: Text(
                                                            'Login',
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 20),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 22.0),
                                                    child: Container(
                                                      width: double
                                                          .infinity, // Make sure the container takes full width
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end, // Align the text to the right
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              ForgotPassword()));
                                                                },
                                                                child: Text(
                                                                  "Forgot Password?",
                                                                  style:
                                                                      TextStyle(
                                                                    color: dark,
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _signIn() async {
    String email = emailcontroller.text;
    String password = passwordcontroller.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    if (user != null) {
      print("User is Successfully Signed In");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      print("Some Error Happened");
    }
  }
}

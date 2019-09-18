import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

const String imgUrl =
    'https://img.maximummedia.ie/her_ie/eyJkYXRhIjoie1widXJsXCI6XCJodHRwOlxcXC9cXFwvbWVkaWEtaGVyLm1heGltdW1tZWRpYS5pZS5zMy5hbWF6b25hd3MuY29tXFxcL3dwLWNvbnRlbnRcXFwvdXBsb2Fkc1xcXC8yMDE4XFxcLzA5XFxcLzIzMTE1MjUzXFxcL1NjcmVlbi1TaG90LTIwMTgtMDktMjMtYXQtMTEuNTIuMzkucG5nXCIsXCJ3aWR0aFwiOjc2NyxcImhlaWdodFwiOjQzMSxcImRlZmF1bHRcIjpcImh0dHBzOlxcXC9cXFwvd3d3Lmhlci5pZVxcXC9hc3NldHNcXFwvaW1hZ2VzXFxcL2hlclxcXC9uby1pbWFnZS5wbmc_aWQ9YjYzYjA3MWIxM2EwZDk0ZWM2MTNcIixcIm9wdGlvbnNcIjpbXX0iLCJoYXNoIjoiNWZjNWU4NTZlOWMwMDU3NDFmNmMzZjRhMTBiMjRmMDE4N2IxYTNkYyJ9/screen-shot-2018-09-23-at-11-52-39.png';
const String emailValidation =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
const String userNameValidation = r'^[A-Za-z0-9_]+$';
const String bitCoinValidation = r"^[13][a-km-zA-HJ-NP-Z1-9]{26,33}$";
const String amountValidation = r"^[0-9]{1,4}(\.[0-9]{1,8})?$";

//Firestore data
String quizCollection = "quiz";

// App Data
const String successful = "Successful";
const String error = "Error";
const String disagree = "Disagree";
const String poor = "poor";

//connectivity
const String connection = "connection";

//Firesbase
FirebaseAuth auth = FirebaseAuth.instance;
Firestore db = Firestore.instance;
FirebaseMessaging firebaseMessaging = FirebaseMessaging();

// Referrer details
const String referrerId = "referrerID";

// Partner details
const String partner = "partner";

// quiz data
String quiz1 = "quiz1";
String quiz2 = "quiz2";
String quiz3 = "quiz3";
String quiz4 = "quiz4";
String quiz5 = "quiz5";
String quiz6 = "quiz6";
String question = "question";
String answer = "answer";

String zipcode = "zipcode";
String citystate = "citystate";
String planet = "planet";

bool isQuizFinished = false;

// pages name for analytics
const String signUpPage = "Signup Page";
const String quizPage = "Quiz Page";
const String sharePartnerPage = "Share Partner Page";
const String onBoardPage = "OnBoard Page";
const String loginPage = "Login Page";
const String confirmationPage = "Confirmation Page";
const String homePage = "Content Page";
const String emailPage = "Email Signup Page";

import 'package:flutter/material.dart';

const primaryTextColor = Color(0xFFFFFFFF);
const secondaryTextColor = Color(0xFFE0E0E0);
const backgroundPurple = Colors.deepPurple;
const backgroundOrange = Colors.orangeAccent;

const apiKey = ''; // Your openweathermap.org API key here

String getGreeting() {
  var timeNow = DateTime.now().hour;

  if (timeNow <= 12) {
    return 'Good Morning';
  } else if ((timeNow > 12) && (timeNow <= 16)) {
    return 'Good Afternoon';
  } else if ((timeNow > 16) && (timeNow < 20)) {
    return 'Good Evening';
  } else {
    return 'Good Night';
  }
}

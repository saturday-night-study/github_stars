import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:github_stars/firebase_options.dart';
import 'package:github_stars/github_stars_app.dart';

void main() async {
  runApp(const GithubStarsApp());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

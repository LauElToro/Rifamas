// Automatic FF imports
import '/backend/backend.dart';
import '/ff/ff_theme.dart';
import '/ff/ff_util.dart';
import 'index.dart'; // Imports other custom actions
import '/ff/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter/services.dart';

Future fixDeviceOrientationUp() async {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

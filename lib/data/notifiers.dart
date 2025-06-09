//ValueNotifier: hold the data
//ValueListenableBuilder: listen to the data (don't need to setstate)

import 'package:flutter/material.dart';

ValueNotifier<int> selectedPageNotifier = ValueNotifier(0);

ValueNotifier<String> playerName = ValueNotifier('');
ValueNotifier<String> object = ValueNotifier('');
ValueNotifier<String> location = ValueNotifier('');
ValueNotifier<String> target = ValueNotifier('');
ValueNotifier<String> gameCode = ValueNotifier('');
ValueNotifier<bool> gameStarted = ValueNotifier(false);

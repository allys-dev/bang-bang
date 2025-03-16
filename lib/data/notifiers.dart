//ValueNotifier: hold the data
//ValueListenableBuilder: listen to the data (don't need to setstate)

import 'package:flutter/material.dart';

ValueNotifier<int> selectedPageNotifier = ValueNotifier(0);
import 'package:flutter/material.dart';

class ColorPicker {
  static Color getColorFromString(String c) {
    switch (c) {
      case 'red':
        return Colors.red;
        break;
      case 'orange':
        return Colors.orange;
        break;
      case 'yellow':
        return Colors.yellow;
        break;
      case 'light_green':
        return Colors.lightGreen;
        break;
      case 'green':
        return Colors.green;
        break;
      case 'blue':
        return Colors.blue;
        break;
      case 'indigo':
        return Colors.indigo;
        break;
      case 'purple':
        return Colors.purple;
        break;
      case 'pink':
        return Colors.pink;
        break;
      case 'white':
        return Colors.white;
        break;
      case 'black':
        return Colors.black;
        break;
      case 'brown':
        return Colors.brown;
        break;
      default:
    }
  }

  static String getStringFromColor(Color c) {
    if (c == Colors.red) return 'red';
    if (c == Colors.orange) return 'orange';
    if (c == Colors.yellow) return 'yellow';
    if (c == Colors.lightGreen) return 'light_green';
    if (c == Colors.green) return 'green';
    if (c == Colors.blue) return 'blue';
    if (c == Colors.indigo) return 'indigo';
    if (c == Colors.purple) return 'purple';
    if (c == Colors.pink) return 'pink';
    if (c == Colors.white) return 'white';
    if (c == Colors.black) return 'black';
    if (c == Colors.brown) return 'brown';

    return '';
  }
}

import 'package:flutter/cupertino.dart';

class CounterClass with ChangeNotifier{

  int _count = 0;
  int get count => _count;

  void increment(){
    _count++;
    notifyListeners();
  }
}

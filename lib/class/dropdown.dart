import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practice_1/class/District%20Response.dart';


class DropdownModel extends ChangeNotifier {
  // String? selectedValue1;
  // String? selectedValue2;
  //
  //
  // void updateSelectedValue1(String newValue) {
  //   selectedValue1 = newValue;
  //   selectedValue2 = null;
  //   notifyListeners();
  // }
  //
  // void updateSelectedValue2(String newValue) {
  //   selectedValue2 = newValue;
  //   notifyListeners();
  // }

  List<String> districts = [];

  Future<void> fetchDistricts() async {
    final response = await http.get(Uri.parse('https://bdapis.com/api/v1.1/districts'));

    if (response.statusCode == 200) {
      final districtResponse = districtResponseFromMap(response.body);
      for (var element in districtResponse.data) {
        districts.add(element.district);
      }
    }
    else {
      throw Exception('Failed to load districts');
    }
    notifyListeners();
  }

}

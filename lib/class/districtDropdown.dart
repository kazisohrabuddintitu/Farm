import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'districtResponse.dart';

class districtDropdown with ChangeNotifier{
    List<String> district = [];

    Future<void> fetchDistrictData() async {
      final response = await http.get(Uri.parse('https://bdapis.com/api/v1.1/districts'));

      if (response.statusCode == 200){
        final disrictResponse = districtResponseFromMap(response.body);
        for (var element in disrictResponse.data){
          district.add(element.district);
        }
        print(district);
      }
      else{
        throw Exception("Failed to load distrcit");
      }
      notifyListeners();
    }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../class/districtDropdown.dart';

class districtPage extends StatefulWidget {
  const districtPage({Key? key}) : super(key: key);

  @override
  State<districtPage> createState() => _districtPageState();
}

class _districtPageState extends State<districtPage> {

  String? isSelected;
  bool screenReady = false;

  @override
  void initState() {
    final myDropDown = Provider.of<districtDropdown>(context,listen: false);
    myDropDown.fetchDistrictData().then((value) {
      setState(() {
        screenReady = true;
        isSelected = myDropDown.district[0];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('Districts'),
        centerTitle: true,

      ),
      body: Center(
        child: screenReady? Column(
          children: [
            SizedBox(height: 20),
            Container(
              height: 100,
              width: 200,
              child:Consumer<districtDropdown>(
                builder: (context, dropdownModel, _) {
                  return DropdownButton<String>(
                    value: isSelected,
                    onChanged: (newValue) {
                      setState(() {
                        isSelected = newValue;
                      });
                    },
                    items: dropdownModel.district.map((String district) {
                      return DropdownMenuItem<String>(
                        value: district,
                        child: Text(district),
                      );
                    }).toList(),
                  );
                },
              ),

            ),
            const SizedBox(height: 20),
          ],
        ) : const Center(child: CircularProgressIndicator(),),
      ),
    );
  }
}

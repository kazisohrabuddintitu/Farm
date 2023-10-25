import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../class/dropdown.dart';

class profileForm extends StatefulWidget {
  const profileForm({Key? key}) : super(key : key);

  @override
  State<profileForm> createState() => _profileFormState();
}

class _profileFormState extends State<profileForm> {

  String? selectedValue1;
  bool screenReady = false;
  @override
  void initState() {
    final dropDownModel = Provider.of<DropdownModel>(context,listen: false);
    dropDownModel.fetchDistricts().then((value) {
      setState(() {
        screenReady = true;
        selectedValue1 = dropDownModel.districts[0];
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('DropDown'),
          backgroundColor: Colors.blueGrey,
          centerTitle: true,
        ),
        body: Center(
          child: screenReady? Column(
            children: [
              SizedBox(height: 20),
              Container(
                height: 100,
                width: 200,
                child:Consumer<DropdownModel>(
                  builder: (context, dropdownModel, _) {
                    return DropdownButton<String>(
                      value: selectedValue1,
                      onChanged: (newValue) {
                        setState(() {
                          selectedValue1 = newValue;

                        });
                      },
                      items: dropdownModel.districts.map((String district) {
                        return DropdownMenuItem<String>(
                          value: district,
                          child: Text(district),
                        );
                      }).toList(),
                    );
                  },
                ),

                // child: Consumer<DropdownModel>(
                //   builder: (context, dropdownModel, child) {
                //     return DropdownButton<String>(
                //       value: dropdownModel.selectedValue1,
                //       onChanged: (String? newValue) {
                //         dropdownModel.updateSelectedValue1(newValue!);
                //         print(newValue);
                //       },
                //       items: division.map<DropdownMenuItem<String>>((String value) {
                //         return DropdownMenuItem<String>(
                //           value: value,
                //           child: Text(value),
                //         );
                //       }).toList(),
                //     );
                //   },
                // ),
              ),
              const SizedBox(height: 20),
            ],
          ): const Center(child: CircularProgressIndicator()),
        ),
      );
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';


// ignore: camel_case_types
class weightMeasure extends StatefulWidget {
  const weightMeasure({Key? key}) : super(key:key);

  @override
  State<weightMeasure> createState() => _weightMeasureState();
}

class _weightMeasureState extends State<weightMeasure> {
  File? selectedImage;
  double? weight;
  late String imageId;
  bool screenReady = true;

  Future<void> uploadImage(File imageFile) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(uploadImageUrl),
    );
    request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));
    try {
      var response = await request.send();

      if (response.statusCode == 201) {
        var responseBody = await response.stream.bytesToString();
        Map<String, dynamic> responseData = json.decode(responseBody);

        imageId = responseData['image_id'].toString();
        print('Image uploaded successfully. Image ID: $imageId');
      } else {
        print('Error uploading image. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }
  Future<void> getWeight() async {
    try {
      if (imageId.isNotEmpty) {
        var response = await http.get(
          Uri.parse('$getWeightUrl$imageId'),
        );

        if (response.statusCode == 200) {
          Map<String, dynamic> responseData = json.decode(response.body);
          setState(() {
            weight = responseData['weight'];
          });
          print('Weight for image $imageId: $weight');
        } else {
          print('Error getting weight. Status code: ${response.statusCode}');
        }
      } else {
        print('No image ID available');
      }
    } catch (e) {
      print('Error getting weight: $e');
    }
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weight Measurement'),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        toolbarHeight: 80,
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.fromLTRB(10, 20, 0, 10),
            child: const Text(
              'Upload the cattle image to scale the weight',
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.grey,
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (selectedImage != null)
                    Image.file(
                      selectedImage!,
                      height: 100,
                    ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      FilePickerResult? result = await FilePicker.platform.pickFiles(
                        type: FileType.image,
                      );
                      if (result != null) {
                        PlatformFile file = result.files.first;
                        print('Image picked: ${file.name}');
                        setState(() {
                          selectedImage = File(file.path!);
                        });
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    child: const Text(
                      'Choose Image',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () async {
              setState(() {
                screenReady = false;
              });
              if (selectedImage != null) {
                await uploadImage(selectedImage!).then((value) {
                  getWeight().then((value) {
                    setState(() {
                      screenReady = true;
                    });
                  });
                });
              } else {
                print("Image not selected");
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
            ),
            child: const Text(
              'Upload & Measure',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 40),
          // ElevatedButton(
          //   onPressed: () async {
          //     await getWeight();
          //   },
          //   style: ButtonStyle(
          //     backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
          //   ),
          //   child: const Text(
          //     'Measure',
          //     style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          //   ),
          // ),
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.grey,
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  screenReady? Container(
                    height: 40,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        '$weight kg',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ) : CircularProgressIndicator(),

                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.black,), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.person, color: Colors.black,), label: 'Profile'),
            ],
          selectedItemColor: Colors.black,
          onTap: (int index) {
            if (index == 0) {
              Navigator.of(context).pop();
            }
            else if (index == 1) {
            // Handle Profile tab
            }
          },
        ),
    );
  }
}

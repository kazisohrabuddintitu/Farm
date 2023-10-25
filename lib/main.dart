import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practice_1/class/dropdown.dart';
import 'package:practice_1/screens/districtPage.dart';
import 'package:provider/provider.dart';
import 'class/counterClass.dart';
import 'class/districtDropdown.dart';
import 'screens/form.dart';
import 'screens/weightMeasure.dart';
import 'widgets/Dashboard%20Card.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]
  );
  runApp(
      CowApp()
  );
}

class CowApp extends StatelessWidget{
  const CowApp({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CounterClass()),
        ChangeNotifierProvider(create: (context) => DropdownModel()),
        ChangeNotifierProvider(create: (context) => districtDropdown()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeActivity(),
      ),
    );
  }
}

class HomeActivity extends StatefulWidget{
  const HomeActivity({Key? key}) : super(key: key);

  @override
  State<HomeActivity> createState() => _HomeActivity();
}

class _HomeActivity extends State<HomeActivity>{

  final scaffoldKey = GlobalKey<ScaffoldState>();

  MyAlertDialogue(context){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return  AlertDialog(
            title: Text( 'Alert!'),
            icon: Icon(Icons.dangerous),
            content: Text('Do you want to delete?'),
            actions: [
              TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text('Yes')),
              TextButton(onPressed: () {Navigator.of(context).pop();}, child: Text('No')),
            ],
          );
        }
    );
  }



  @override
  Widget build(BuildContext context){

    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        child: ListView(
          children:  [
            DrawerHeader(
              padding: EdgeInsets.all(0),
              child: Image.asset('images/cow.jpg' ),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
            ListTile(leading: Icon(Icons.home),title: Text('Milk'),onTap: (){},),
            ListTile(leading: Icon(Icons.scale),title: Text('Weight Measure'),onTap: (){
              scaffoldKey.currentState!.closeDrawer();
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> weightMeasure()));},),
            ListTile(leading: Icon(Icons.save_as),title: Text('Weight Records'),onTap: (){},),
            ListTile(leading: Icon(Icons.home),title: Text('Home'),onTap: (){},),
            ListTile(leading: Icon(Icons.person),title: Text('Profile'),onTap: (){},),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.blueGrey,
            child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 30, 0, 0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: (){
                              scaffoldKey.currentState!.openDrawer();
                            },
                            child: Icon(Icons.menu),
                          ),

                          Container(
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.settings),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )

            ),
          Container(
            alignment: Alignment.center,
            color: Colors.blueGrey,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Column(
              children: [
                Image.asset(
                  'images/cow.jpg',
                  height: 100,
                ),

              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Column(
              children: [
                const Text(
                  'Cow Farm',
                  style: TextStyle(
                    fontFamily: 'CroissantOne',
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                Wrap(
                  spacing: 18,
                  runSpacing: 20,
                  children: [
                    DashboardCard(title: 'Milk' , onTap: (){}),
                    DashboardCard(title: 'Weight Measure', onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => weightMeasure()),);}),
                    DashboardCard(title: 'Weight Records', onTap: (){}),
                    // DashboardCard(title: 'Box 4', onTap: (){
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(builder: (context) => profileForm()),);}),
                    // DashboardCard(title: 'Box 5', onTap: (){
                    //   Navigator.push(context,
                    //       MaterialPageRoute(builder: (context) => districtPage())
                    //   );
                    // }),

                  ],
                ),
              ],
            ),
          ),
        ]
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items:  [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (int index){
          if (index==0){
            _HomeActivity();
          }
          else if (index==1){

          }
        },
      ),

    );
  }
}

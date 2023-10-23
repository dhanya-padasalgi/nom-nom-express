import 'package:flutter/material.dart';

double fem = 0.01;
double ffem = 0.001;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'nne',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        
      ),
      home: const MyHomePage(title: 'nne Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width:  double.infinity,
      height:  932*fem,
      decoration:  BoxDecoration (
        color:  Color(0xff010545),
        borderRadius:  BorderRadius.circular(40*fem),
      ),
      child : Stack(
        children:  [
          Positioned(
            left:  25*fem,
            top:  39*fem,
            child:  Container(
              width:  383*fem,
              height:  54*fem,
              child:  Row(
                crossAxisAlignment:  CrossAxisAlignment.center,
                children: [
                  Container(
                    margin:  EdgeInsets.fromLTRB(0*fem, 0*fem, 44.55*fem, 2*fem),
                    width:  49.38*fem,
                    height:  44*fem,
                    child:  IconButton(
                        icon: Icon(Icons.menu),
                        iconSize:  49.38*fem,
                        onPressed: () {
                          // Add your code to handle the menu button press
                        },
                      )
                      
                    ),
                  
                  Container(
                    margin:  EdgeInsets.fromLTRB(0*fem, 0*fem, 16.19*fem, 2.96*fem),
                    width:  12.88*fem,
                    height:  16.04*fem,
                    child: Icon(
                      Icons.place,
                      size: 16.04*fem, 
                      color: Colors.red, 
                    ),
                  ),
                  Container(
                    margin:  EdgeInsets.fromLTRB(0*fem, 0*fem, 6.51*fem, 6*fem),
                    child:  Text(
                      'location/store',
                      style:  TextStyle (
                        fontSize:  15*ffem,
                        fontWeight:  FontWeight.w600,
                        height:  3.2*ffem/fem,
                        color:  Color(0xffffffff),
                      ), 
                    ),
                  ),
                  Container( 
                    margin:  EdgeInsets.fromLTRB(0*fem, 0*fem, 39.32*fem, 6*fem),
                    width:  17.18*fem,
                    height:  10*fem,
                    child:   MyDropdownWidget(),
                  ),
                  Container(
                    margin:  EdgeInsets.fromLTRB(0*fem, 4*fem, 0*fem, 0*fem),
                    padding:  EdgeInsets.fromLTRB(20.09*fem, 0*fem, 18.91*fem, 0*fem),
                    height:  50*fem,
                    child: ProfileIconButton(),
                  ),
                ], // children
              ),
            ),
          ),
        ],
      ),
    );
  }
}
      



class MyDropdownWidget extends StatefulWidget {
  const MyDropdownWidget({Key? key});

  @override
  // ignore: library_private_types_in_public_api
  _MyDropdownWidgetState createState() => _MyDropdownWidgetState();
}

class _MyDropdownWidgetState extends State<MyDropdownWidget> {
  String selectedValue = 'Option 1';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DropdownButton<String>(
          value: selectedValue,
          onChanged: (String? newValue) {
            setState(() {
              selectedValue = newValue!;
            });
          },
          items: <String>['Option 1', 'Option 2', 'Option 3', 'Option 4']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        Text('Selected option: $selectedValue'),
      ],
    );
  }
}

class ProfileIconButton extends StatelessWidget {
  const ProfileIconButton({Key? key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Handle the tap event to navigate to the "profile page."
        // You can use Navigator.push or any navigation method you prefer.
        // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
      },
      child: CircleAvatar(
        backgroundColor: Colors.blue, // Background color of the circle
        radius: 50, // Adjust the radius as needed
        child: CircleAvatar(
          radius: 48, // Slightly smaller to create a border effect
          backgroundImage: AssetImage('assets/profile_picture.jpg'), // Replace with your image asset
        ),
      ),
    );
  }
}
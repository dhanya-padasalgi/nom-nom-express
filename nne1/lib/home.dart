import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.place,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: MyDropdownWidget(),
            ),
          ],
        ),
        actions: [
          ProfileIconButton(),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
              ),
              child: Text(
                'nom-nom express',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontSize: 30,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/home');
              },
              child: ListTile(
                title: Text('Home'),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Add your code to handle the click event for "Favorites"
              },
              child: ListTile(
                title: Text('favorites'),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/signlog');
              },
              child: ListTile(
                title: Text('login/signup'),
              ),
            ),
          ],
        ),
      ),

      //------------------------------------------------------body----------------------------------------------------
      // body: ListView(
      //   children: <Widget>[
      //     // "Mind" Section
      //     Container(
      //       alignment: Alignment.center,
      //       child: Column(
      //         children: <Widget>[
      //           Text("Mind", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      //           GridView.builder(
      //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      //             shrinkWrap: true,
      //             itemCount: mindPictures.length,
      //             itemBuilder: (context, index) {
      //               return InkWell(
      //                 onTap: () {
      //                   // Add navigation logic to open a new page
      //                 },
      //                 child: Column(
      //                   children: <Widget>[
      //                     ClipOval(
      //                       child: Image.network(mindPictures[index].imageUrl, width: 100, height: 100, fit: BoxFit.cover),
      //                     ),
      //                     Text(mindPictures[index].description),
      //                   ],
      //                 ),
      //               );
      //             },
      //           ),
      //         ],
      //       ),
      //     ),
      //     // "Store" Section
      //     Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: <Widget>[
      //         Text("Store", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      //         Container(
      //           height: 150,
      //           child: ListView.builder(
      //             scrollDirection: Axis.horizontal,
      //             itemCount: storePictures.length,
      //             itemBuilder: (context, index) {
      //               return InkWell(
      //                 onTap: () {
      //                   // Add navigation logic to open a new page
      //                 },
      //                 child: Column(
      //                   children: <Widget>[
      //                     Image.network(storePictures[index].imageUrl, width: 100, height: 100, fit: BoxFit.cover),
      //                     Text(storePictures[index].description),
      //                   ],
      //                 ),
      //               );
      //             },
      //           ),
      //         ),
      //       ],
      //     ),
      //     // "Today" Section
      //     Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: <Widget>[
      //         Text("Today", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      //         ListView.builder(
      //           physics: NeverScrollableScrollPhysics(),
      //           itemCount: todayPictures.length,
      //           shrinkWrap: true,
      //           itemBuilder: (context, index) {
      //             return InkWell(
      //               onTap: () {
      //                 // Add navigation logic to open a new page
      //               },
      //               child: Column(
      //                 children: <Widget>[
      //                   Image.network(todayPictures[index].imageUrl, width: 100, height: 100, fit: BoxFit.cover),
      //                   Text(todayPictures[index].description),
      //                 ],
      //               ),
      //             );
      //           },
      //         ),
      //       ],
      //     ),
      //   ],
      // ),
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
  String selectedValue = 'all';

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
          items: <String>['Option 1', 'Option 2', 'Option 3', 'Option 4', 'all']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class ProfileIconButton extends StatelessWidget {
  const ProfileIconButton({Key? key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: CircleAvatar(
        //backgroundColor: Colors.blue, // Background color of the circle
        radius: 20, // Adjust the radius as needed
        backgroundImage: AssetImage('assets/profile_picture.jpg'), // Replace with your image asset
        ),
      
      onPressed: () {
        // Add code to redirect to the profile page here
        Navigator.pushNamed(context, '/signlog');
      },
    );
  }
}

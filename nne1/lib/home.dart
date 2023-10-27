import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);


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
      body: ListView(
        children: <Widget>[
          // "Mind" Section
          Container(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Text("Mind", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  children: List.generate(4, (index) {
                    return Column(
                      children: <Widget>[
                        ClipOval(
                          child: Image.asset(
                            'assets/mind_image_$index.png',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: Text(
                            'Image $index',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),

          // "Store" Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Store", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              Container(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: storesList.length,
                  itemBuilder: (context, index) {
                    final store = storesList[index];
                    return Column(
                      children: <Widget>[
                        Image.asset(
                          'assets/${store.storePicture}',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        Text(store.storeName),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
          // "Today" Section
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: <Widget>[
    Text("Today", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: todayList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final item = todayList[index];
        return GestureDetector(
          onTap: () {
            // Handle the tap event here
          },
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/${item.image}',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(item.image.replaceAll('.jpg', ''), textAlign: TextAlign.left),
                  Text(item.store, textAlign: TextAlign.right),
                ],
              ),
            ],
          ),
        );
      },
    ),
  ],
),

              ]
            )
          );
        }
      }


class TodayItem {
  final String image;
  final String store;

  TodayItem({required this.image, required this.store});
}

// Create a sample list of items
final todayList = [
  TodayItem(image: 'assets/briyani.jpg', store: 'Roll me'),
  TodayItem(image: 'assets/burger.jpg', store: 'JOOS'),
  // Add more items as needed
];


class Store {
  final int index;
  final String storeId;
  final String storeName;
  final String storePicture;
  final String menuId;
  final String phoneNumber;

  Store({
    required this.index,
    required this.storeId,
    required this.storeName,
    required this.storePicture,
    required this.menuId,
    required this.phoneNumber,
  });
}

final List<Store> storesList = [
  Store(
    index: 0,
    storeId: 'store0',
    storeName: 'Store 0',
    storePicture: 'store_image_0.png',
    menuId: 'menu0',
    phoneNumber: '1234567890',
  ),
  Store(
    index: 1,
    storeId: 'store1',
    storeName: 'Store 1',
    storePicture: 'store_image_1.png',
    menuId: 'menu1',
    phoneNumber: '9876543210',
  ),
  // Add more store entries here as needed.
];





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

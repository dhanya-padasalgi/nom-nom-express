
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
                "nom-nom express",
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
                title: Text("What's On Your Mind"),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/signlog');
              },
              child: ListTile(
                title: Text('Login/Signup'),
              ),
            ),
          ],
        ),
        ),
      
      body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // "Mind" Section
              Container(
                width: 400,
                height: 340,
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: <Widget>[
                    Text(
                      "What's On Your Mind",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Container(
                      height: 300,
                      width: 300,
                      child: GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        children: List.generate(4, (index) {
                          String imageName = '';
                          if (index == 0) {
                            imageName = 'burger.jpg';
                          } else if (index == 1) {
                            imageName = 'maggi.jpg';
                          } else if (index == 2) {
                            imageName = 'sandwich.jpg';
                          } else if (index == 3) {
                            imageName = 'fries.jpg';
                          }

                          return Column(
                            children: <Widget>[
                              ClipOval(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white, width: 2.5), // Circular border
                                  ),
                                  child: Image.asset(
                                    'assets/$imageName',
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 100,
                                height: 30,
                                child: Text(
                                  imageName.split('.')[0],
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
              // "Store" Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Stores", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: storesList.length,
                      itemBuilder: (context, index) {
                        final store = storesList[index];
                        return Column(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white, width: 0.5), // Rectangular border
                              ),
                              child: Column(
                                children: [
                                  Image.asset(
                                    store.storePicture,
                                    width: 150,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                    width: 150,
                                    padding: EdgeInsets.only(left: 0.5, right: 0.5, bottom: 2.0), // Text border padding
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white, width: 0.5), // Text border
                                    ),
                                    child: Text(
                                      store.storeName,
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                  Text("Today's Special", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: todayList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final item = todayList[index];
                      return Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2.0), // Rectangular border
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  item.picture,
                                  width: 450,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                                Container(
                                  width: 450,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white, width: 2.0), // Text border
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        item.name,
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        item.store,
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
    );
  }
}




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

class MyDropdownWidget extends StatefulWidget {
  const MyDropdownWidget({Key? key});

  @override
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
        radius: 20,
        backgroundImage: AssetImage('assets/profile_picture.jpg'),
      ),
      onPressed: () {
        Navigator.pushNamed(context, '/signlog');
      },
    );
  }
}

final List<Store> storesList = [
  Store(
    index: 0,
    storeId: 'store0',
    storeName: 'Crave',
    storePicture: 'assets/crave.jpg',
    menuId: 'menu0',
    phoneNumber: '1234567890',
  ),
  Store(
    index: 1,
    storeId: 'store1',
    storeName: 'Joos',
    storePicture: 'assets/joos.jpg',
    menuId: 'menu1',
    phoneNumber: '9876543210',
  ),
  Store(
    index: 2,
    storeId: 'store2',
    storeName: 'USA Pizza',
    storePicture: 'assets/usapizza.jpg',
    menuId: 'menu1',
    phoneNumber: '9876543210',
  ),
  Store(
    index: 3,
    storeId: 'store3',
    storeName: 'Vapour Kitchen',
    storePicture: 'assets/vapourkit.jpg',
    menuId: 'menu1',
    phoneNumber: '9876543210',
  ),
];

class TodayItem {
  final int index;
  final String name;
  final String picture;
  final String store;

  TodayItem({
    required this.index,
    required this.name,
    required this.picture,
    required this.store,
  });
}

final List<TodayItem> todayList = [
  TodayItem(
    index: 0,
    name: 'Biryani',
    picture: 'assets/briyani.jpg',
    store: 'Roll Me',
  ),
  TodayItem(
    index: 1,
    name: 'Fries',
    picture: 'assets/fries.jpg',
    store: 'USA Pizza',
  ),
  // Add more items here as needed.
];

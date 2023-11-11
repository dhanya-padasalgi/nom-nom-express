
import 'package:flutter/material.dart';
import 'package:nom_nom_express/bill.dart';

class MenuItem {
  final String name;
  final double price;
  final double rating;
  final bool bestseller;
  final String imagePath;
  MenuItem({
    required this.name,
    required this.price,
    required this.rating,
    required this.bestseller,
    required this.imagePath,
  });
}
class CartItem {
  final String name;
  final double price;
  int quantity;
  CartItem({required this.name, required this.price, required this.quantity});
}
class Menu {
  final List<MenuItem> items = [
    MenuItem(
      name: 'Strawberry Milkshake',
      price: 65,
      rating: 3.2,
      bestseller: true,
      imagePath: 'joos.jpg',//  change the image path 
    ),
    MenuItem(
      name: 'Chicken Fried Maggie',
      price: 70,
      rating: 4.2,
      bestseller: true,
      imagePath: 'maggi.jpg',
    ),
    MenuItem(
      name: 'Veg Grill Sandwich',
      price: 60,
      rating: 3.8,
      bestseller: true,
      imagePath: 'sandwich.jpg',
    ),
    MenuItem(
      name: 'Blue Lime',
      price: 45,
      rating: 3.3,
      bestseller: true,
      imagePath: 'burger.jpg',
    ),
  ];
}
class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}
class _MenuPageState extends State<MenuPage> {
  Menu menu = Menu();
  List<CartItem> cartItems = [];
  int totalQuantity = 0;
  double totalAmount = 0;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondaryColor = Color(0xFF8080D7);
    final primaryColor = theme.colorScheme.primary;
    final onPrimaryColor = theme.colorScheme.onPrimary;
    final buttonBackgroundColor = Colors.white;
    return Scaffold(
      appBar: AppBar(
        title: Text('THE JOOS'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 10),
            Expanded(
              child: _buildMenuItems(secondaryColor, primaryColor, onPrimaryColor),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(onPrimaryColor, secondaryColor, buttonBackgroundColor),
    );
  }
  Widget _buildMenuItems(
      Color secondaryColor, Color primaryColor, Color onPrimaryColor) {
    return ListView.builder(
      itemCount: menu.items.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final item = menu.items[index];
        return Container(
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            color: secondaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          if (item.bestseller)
                            Text(
                              'Bestseller',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: onPrimaryColor,
                                fontSize: 14,
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        item.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            'Price: ₹${item.price.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: onPrimaryColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Rating: ${item.rating}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: onPrimaryColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: 150,
                  width: 100,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          item.imagePath,
                          height: 95,
                          width: 130,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 5),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            var existingCartItem = cartItems.firstWhere(
                              (cartItem) => cartItem.name == item.name,
                              orElse: () => CartItem(name: item.name, price: item.price, quantity: 0),
                            );
                            if (existingCartItem.quantity < 10) {
                              existingCartItem.quantity++;
                              totalQuantity++;
                              totalAmount += item.price;
                            }
                            if (!cartItems.contains(existingCartItem)) {
                              cartItems.add(existingCartItem);
                            }
                          });
                        },
                        child: Text('ADD'),
                        style: ElevatedButton.styleFrom(
                          primary: primaryColor,
                          onPrimary: onPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  Widget _buildBottomBar(Color onPrimaryColor, Color secondaryColor, Color buttonBackgroundColor) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: secondaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$totalQuantity Items | ₹${totalAmount.toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: onPrimaryColor,
              fontSize: 16,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigation from View Cart to the Checkout
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BillPage()),
              );
            },
            child: Text('View Cart'),
            style: ElevatedButton.styleFrom(
              primary: buttonBackgroundColor,
              onPrimary: Colors.black, 
            ),
          ),
        ],
      ),
    );
  }
}

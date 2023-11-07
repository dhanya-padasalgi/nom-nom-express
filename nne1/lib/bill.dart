
import 'package:flutter/material.dart';

class BillPage extends StatefulWidget {
  @override
  _BillPageState createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {
  List<BillItem> items = [
    BillItem(name: 'Item 1', quantity: 2, price: 10.0),
    BillItem(name: 'Item 2', quantity: 3, price: 15.0),
    BillItem(name: 'Item 3', quantity: 1, price: 5.0),
  ];

  @override
  Widget build(BuildContext context) {
    double total = 0;
    for (var item in items) {
      total += item.totalPrice;
    }
    final theme = Theme.of(context);
    final secondaryColor = theme.colorScheme.secondary;
    final primaryColor = theme.colorScheme.primary;
    final onPrimaryColor = theme.colorScheme.onPrimary;

    return Scaffold(
      appBar: AppBar(
        title: Text('Bill Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 10),
            _buildBillItems(secondaryColor, primaryColor, onPrimaryColor),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(total, onPrimaryColor, primaryColor),
    );
  }

  Widget _buildBillItems(
    Color secondaryColor, Color primaryColor, Color onPrimaryColor) {
    return ListView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final item = items[index];
        return Container(
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            color: secondaryColor, // Use secondaryColor
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: double.infinity,
                  width: 50,
                  child: Center(
                    child: Text(
                      item.name, // Display the item name
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor, // Use primaryColor
                        fontSize: 18, // Increase font size
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: double.infinity,
                  width: 50,
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: primaryColor, // Use primaryColor
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: QuantityWidget(
                            item: item,
                            onPrimaryColor: primaryColor,
                            onQuantityChange: (int newQuantity) {
                              // Update the quantity in the original dataset
                              setState(() {
                                item.quantity = newQuantity;
                              });
                            },
                          ),
                        ),
                      ),
                      Container(
                        height: 20,
                        child: Center(
                          child: Text(
                            'Amount: \$${(item.quantity * item.price).toStringAsFixed(2)}', // Display the item amount
                            style: TextStyle(
                              color: onPrimaryColor, // Use onPrimaryColor
                              fontSize: 16, // Increase font size
                            ),
                          ),
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

  Widget _buildBottomBar(double total, Color onPrimaryColor, Color primaryColor) {
    return Container(
      height: 60,
      color: onPrimaryColor, // Use onPrimaryColor
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // Handle button click
              },
              child: Text('Button'), // Display the button with text
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Total: \$${total.toStringAsFixed(2)}', // Display the total amount
              style: TextStyle(
                fontSize: 20, // Increase font size
                fontWeight: FontWeight.bold,
                color: primaryColor, // Use primaryColor
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QuantityWidget extends StatefulWidget {
  final BillItem item;
  final Color onPrimaryColor;
  final Function(int) onQuantityChange;

  QuantityWidget(
      {required this.item, required this.onPrimaryColor, required this.onQuantityChange});

  @override
  _QuantityWidgetState createState() => _QuantityWidgetState();
}

class _QuantityWidgetState extends State<QuantityWidget> {
  int quantity = 0;

  @override
  void initState() {
    quantity = widget.item.quantity;
    super.initState();
  }

  void incrementQuantity() {
    setState(() {
      quantity++;
      widget.onQuantityChange(quantity); // Notify the parent widget about the change
    });
  }

  void decrementQuantity() {
    if (quantity > 0) {
      setState(() {
        quantity--;
        widget.onQuantityChange(quantity); // Notify the parent widget about the change
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: incrementQuantity, // Increase the quantity when tapped
          child: Icon(Icons.add),
        ),
        Text('$quantity', style: TextStyle(color: widget.onPrimaryColor)), // Display the quantity
        InkWell(
          onTap: decrementQuantity, // Decrease the quantity when tapped
          child: Icon(Icons.remove),
        ),
      ],
    );
  }
}

class BillItem {
  final String name;
  int quantity;
  final double price;

  BillItem({required this.name, required this.quantity, required this.price});

  double get totalPrice => quantity * price;
}

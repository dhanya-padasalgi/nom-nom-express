import 'package:flutter/material.dart';

class BillPage extends StatelessWidget {
  final List<BillItem> items = [
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
    final primaryColor = theme.colorScheme.primary;
    final secondaryColor = theme.colorScheme.secondary;

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
            _buildBillItems(secondaryColor,primaryColor),
            SizedBox(height: 20),
            Text(
              'Total: \$${total.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBillItems(Color secondaryColor, Color primaryColor) {
  return Container(
    child: ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: items.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final item = items[index];
        return Container(
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            color: secondaryColor,
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
                      item.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
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
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: QuantityWidget(item: item),
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
    ),
  );
}




}

class QuantityWidget extends StatefulWidget {
  final BillItem item;

  QuantityWidget({required this.item});

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
    });
  }

  void decrementQuantity() {
    if (quantity > 0) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: incrementQuantity,
          child: Icon(Icons.add),
        ),
        Text('$quantity'),
        InkWell(
          onTap: decrementQuantity,
          child: Icon(Icons.remove),
        ),
      ],
    );
  }
}

class BillItem {
  final String name;
  final int quantity;
  final double price;

  BillItem({required this.name, required this.quantity, required this.price});

  double get totalPrice => quantity * price;
}

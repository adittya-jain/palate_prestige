import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:palate_prestige/components/components.dart';
import 'package:palate_prestige/models/menu.dart';
import 'package:palate_prestige/models/orders.dart';
import 'package:palate_prestige/pages/final_page.dart';
import 'package:palate_prestige/socketIO/socket_methods.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _phoneFieldKey = GlobalKey<FormFieldState>();
  final _nameFieldKey = GlobalKey<FormFieldState>();
  final SocketMethods _socketMethods = SocketMethods();
  
  @override
  Widget build(BuildContext context) {
    final menu = Provider.of<Menu>(context);

    return Consumer<Menu>(
      builder: (context, value, child) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Cart"),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  key: _nameFieldKey,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  // Add any validation or controller as needed
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null; // Return null if the input is valid
                  },
                ),
              ),
              // Text field for phone details
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    // Text box for country code
                    Container(
                      width: 60,
                      height: 66,
                      decoration: BoxDecoration(
                        border: Border.all(), // Add border to the container
                      ),
                      child: Center(
                        child: Text(
                          '+91',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                        width: 10), // Add some space between the text fields
                    // Text field for phone number
                    Expanded(
                      child: TextFormField(
                        key: _phoneFieldKey,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          labelText: 'Phone',
                          border: OutlineInputBorder(),
                        ),
                        // Add any validation or controller as needed
                        controller: _phoneController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter A Valid Mobile Number';
                          }
                          if (value.length != 10) {
                            return 'Please Enter A Valid Mobile Number';
                          }
                          return null; // Return null if the input is valid
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: menu.userCart.isEmpty
                    ? Center(
                        child: Text('Your cart is empty...'),
                      )
                    : ListView.builder(
                        itemCount: menu.userCart.length,
                        itemBuilder: (context, index) {
                          // Get the list of entries from the userCart map
                          CartItem cartItem = menu.userCart[index];

                          // Extract the item and its count from the cart item
                          Item item = cartItem.item;
                          int count = cartItem.count;

                          // Build a widget to display the item and its count
                          return ListTile(
                            title: Text('${item.foodname} (x$count)'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Rs${count * double.parse(item.price)}'),
                                SizedBox(width: 10),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    setState(() {
                                      menu.deleteFromCart(item);
                                    });
                                  },
                                ),
                              ],
                            ),
                            // Add any other UI components as needed
                          );
                        },
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'Rs${menu.calculateTotal()}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_phoneFieldKey.currentState!.validate() &&
                      _nameFieldKey.currentState!.validate()) {
                    if (_phoneFieldKey.currentState!.validate() &&
                        _nameFieldKey.currentState!.validate()) {
                      List<OrderItem> orderItems =
                          menu.userCart.map((cartItem) {
                        return OrderItem(
                          itemName: cartItem.item.foodname,
                          quantity: cartItem.count,
                        );
                      }).toList();
                      // Create an instance of Order
                      Order order = Order(
                        orderId: generateOrderId(_phoneController.text),
                        refId: 'CASH',
                        name: _nameController.text,
                        contact: _phoneController.text,
                        orders: orderItems,
                        amount: menu.calculateTotal(),
                      );

                      // Convert Order instance to JSON format
                      Map<String, dynamic> orderJson = order.toJson();
                      _socketMethods.newOrder(orderJson);


                      print('Sending data to server: $orderJson');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FinalPage()),
                      );
                    }
                  }
                }, // Add your onPressed function here
                child: Text('Proceed to Checkout'),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

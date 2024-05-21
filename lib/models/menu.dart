import 'package:flutter/material.dart';
import 'package:palate_prestige/models/models.dart';

class CartItem {
  final Item item;
  int count;

  CartItem({required this.item, required this.count});
}
class Menu extends ChangeNotifier {
  // user cart
  List<CartItem> _userCart = [];

  // get user cart
  List<CartItem> get userCart => _userCart;

  // add to cart
  void addToCart(Item item) {
    // Check if the item already exists in the cart
    int existingIndex =
        _userCart.indexWhere((cartItem) => cartItem.item == item);
    if (existingIndex != -1) {
      // If the item exists, increment its count
      _userCart[existingIndex].count++;
    } else {
      // If the item doesn't exist, add it to the cart
      _userCart.add(CartItem(item: item, count: 1));
    }
    notifyListeners();
  }

  // delete from cart
  void deleteFromCart(Item item) {
    // Check if the item exists in the cart
    int existingIndex =
        _userCart.indexWhere((cartItem) => cartItem.item == item);
    if (existingIndex != -1) {
      // If the item exists, decrement its count
      _userCart[existingIndex].count--;
      // If count reaches zero, remove the item from the cart
      if (_userCart[existingIndex].count == 0) {
        _userCart.removeAt(existingIndex);
      }
      notifyListeners();
    }
  }

  int calculateTotal() {
    int total = 0;
    for (var cartItem in userCart) {
      total += cartItem.count * int.parse(cartItem.item.price);
    }
    return total;
  }
}



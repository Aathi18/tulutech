import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';
import '../models/cart_item.dart';

class CartProvider extends ChangeNotifier {
  Map<int, CartItem> _cart = {}; // Key: Product ID
  static const _cartKey = 'local_cart_data'; 

  Map<int, CartItem> get cart => _cart;
  List<CartItem> get cartItems => _cart.values.toList();
  double get totalAmount => _cart.values.fold(
      0.0, (sum, item) => sum + (item.product.price * item.quantity));

  CartProvider() {
    _loadCart(); 
  }

  // NOTE: Private methods are safe to call internally but not externally.
  Future<void> _loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartString = prefs.getString(_cartKey);
    
    if (cartString != null) {
      final Map<String, dynamic> decodedData = json.decode(cartString);
      _cart = decodedData.map((key, value) => MapEntry(
            int.parse(key), 
            CartItem.fromJson(value),
          ));
    }
    notifyListeners();
  }

  // NOTE: Private methods are safe to call internally but not externally.
  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final Map<String, dynamic> encodedData = _cart.map((key, value) => 
        MapEntry(key.toString(), value.toJson()));

    final jsonString = json.encode(encodedData);
    prefs.setString(_cartKey, jsonString);
  }

  // Public method to add item
  void addItem(Product product) {
    if (_cart.containsKey(product.id)) {
      _cart[product.id]!.quantity++;
    } else {
      _cart[product.id] = CartItem(product: product, quantity: 1);
    }
    _saveCart();
    notifyListeners();
  }

  // Public method to remove item
  void removeItem(int productId) {
    _cart.remove(productId);
    _saveCart();
    notifyListeners();
  }
  
  // Public method to update quantity
  void updateQuantity(int productId, int newQuantity) {
    if (_cart.containsKey(productId) && newQuantity > 0) {
      _cart[productId]!.quantity = newQuantity;
      _saveCart();
      notifyListeners();
    } else if (newQuantity == 0) {
      removeItem(productId);
    }
  }

  // <--- NEW: Public method to clear cart after successful checkout --->
  void clearCart() {
    _cart.clear(); 
    _saveCart();   
    notifyListeners();
  }
}
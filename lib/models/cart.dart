import 'package:flutter/foundation.dart';

class CartItem {
  final String id, name;
  final int views;
  final double price;

  CartItem(
      {@required this.id,
      @required this.name,
      @required this.views,
      @required this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  void addItem(String locationId, String name, double price) {
    if (_items.containsKey(locationId)) {
      _items.update(
          locationId,
          (existingCartItem) => CartItem(
              id: DateTime.now().toString(),
              name: existingCartItem.name,
              views: existingCartItem.views + 1,
              price: existingCartItem.price));
    } else {
      _items.putIfAbsent(
        locationId,
        () => CartItem(
          name: name,
          id: DateTime.now().toString(),
          views: 1,
          price: price,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void removeSingleItem(String id) {
    if (!_items.containsKey(id)) {
      return;
    }
    if (_items[id].views > 1) {
      _items.update(
          id,
          (existingCartItem) => CartItem(
              id: DateTime.now().toString(),
              name: existingCartItem.name,
              views: existingCartItem.views - 1,
              price: existingCartItem.price));
    }
    notifyListeners();
  }

  void clear(){
    _items = {};
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

class FavoriteProvider with ChangeNotifier {
  final Set<String> _favorites = {};

  bool isFavorite(String productId) {
    return _favorites.contains(productId);
  }

  void toggleFavorite(String productId) {
    if (_favorites.contains(productId)) {
      _favorites.remove(productId);
    } else {
      _favorites.add(productId);
    }
    notifyListeners();
  }

  List<String> get favorites => _favorites.toList();

  void removeFromFavorites(String productId) {}
}



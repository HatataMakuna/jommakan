import 'package:flutter/foundation.dart';
import 'package:jom_makan/server/favorites.dart';

class FavoritesProvider extends ChangeNotifier {
  List<int> _favoriteFoodIDs = [];
  List<int> get favoriteFoodIDs => _favoriteFoodIDs;

  // Check if a foodID is in the favorites list
  bool isFavorite(int foodID) {
    return _favoriteFoodIDs.contains(foodID);
  }

  // Toggle the favorite status of a foodID
  Future<String> toggleFavorite(int foodID, int userID) async {
    String status;
    if (_favoriteFoodIDs.contains(foodID)) {
      status = await _removeFavorite(foodID, userID);
    } else {
      status = await _addFavorite(foodID, userID);
    }

    notifyListeners();
    return status;
  }

  // Fetch user favorites from the database
  void fetchFavorites(int userID) async {
    try {
      List<int> favorites = await Favorites().getUserFavorites(userID: userID);
      _favoriteFoodIDs = favorites;
      notifyListeners();
    } catch (e) {
      print('Error while fetching favorites: $e');
    }
  }

  Future<String> _addFavorite(int foodID, int userID) async {
    try {
      bool isSuccess = await Favorites().addToFavorites(userID: userID, foodID: foodID);

      if (isSuccess) {
        _favoriteFoodIDs.add(foodID);
        return 'add success';
      } else {
        print('Error while adding to favorites');
        return 'add failure';
      }
    } catch (e) {
      print('Error while adding to favorites: $e');
      return 'add failure';
    }
  }

  Future<String> _removeFavorite(int foodID, int userID) async {
    try {
      bool isSuccess = await Favorites().removeFromFavorites(userID: userID, foodID: foodID);

      if (isSuccess) {
        _favoriteFoodIDs.remove(foodID);
        return 'remove success';
      } else {
        print('Error while removing from favorites');
        return 'remove failure';
      }
    } catch (e) {
      print('Error while removing from favorites: $e');
      return 'remove failure';
    }
  }
}
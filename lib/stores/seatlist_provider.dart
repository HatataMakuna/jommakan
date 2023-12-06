import 'package:flutter/foundation.dart';

class SeatListProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _seatList = [];
  List<Map<String, dynamic>> get seatList => _seatList;

  void setSeatList(List<Map<String, dynamic>> seatList) {
    _seatList = seatList;
    notifyListeners();
  }

  void reset() {
    _seatList = [];
    notifyListeners();
  }
}
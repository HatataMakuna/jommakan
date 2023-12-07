import 'package:flutter/foundation.dart';

class SeatListProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _seatList = [];
  Uint8List _qrCodeBytes = Uint8List(0);
  List<Map<String, dynamic>> get seatList => _seatList;
  Uint8List get qrCodeBytes => _qrCodeBytes;

  void setSeatList(List<Map<String, dynamic>> seatList) {
    _seatList = seatList;
    notifyListeners();
  }

  void setQrCodeBytes(Uint8List qrCodeBytes) {
    _qrCodeBytes = qrCodeBytes;
    notifyListeners();
  }

  void reset() {
    _seatList = [];
    _qrCodeBytes = Uint8List(0);
    notifyListeners();
  }
}
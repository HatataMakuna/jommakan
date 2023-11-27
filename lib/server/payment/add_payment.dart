import 'package:jom_makan/database/db_connection.dart';
import 'package:intl/intl.dart';

class AddPayment {
  String paymentDate = DateFormat('dd-MMM-yyyy').format(DateTime.now());
  String paymentTime = DateFormat('HH:mm:ss').format(DateTime.now());
  
  Future<int?> addPayment({required String paymentMethod}) async {
    //String paymentDate = DateFormat('dd-MMM-yyyy').format(DateTime.now());
    //String paymentTime = DateFormat('HH:mm:ss').format(DateTime.now());

    try {
      var result = await pool.execute('''
        INSERT INTO payments (payment_method, payment_date, payment_time) 
        VALUES (:payment_method, :payment_date, :payment_time)
      ''', {
        "payment_method": paymentMethod,
        "payment_date": paymentDate,
        "payment_time": paymentTime,
      });

      return result.lastInsertID.toInt();
    } catch (e) {
      print('Error while processing payment: $e');
      return null;
    }
  }
}

void main() {
  print(DateFormat('dd-MMM-yyyy HH:mm:ss').format(DateTime.now()));
}
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


  Future<List<Map<String, dynamic>>> getPaymentData() async {
    try {
      var results = await pool.execute('SELECT * FROM payments');
    
      List<Map<String, dynamic>> payment = [];

      for (final row in results.rows) {
        payment.add({
          "paymentID": row.colByName("paymentID"),
           "payment_method": row.colByName("payment_method"),
        "payment_date": row.colByName("payment_date"),
        "payment_time": row.colByName("payment_time"),
        });
      }

      return payment;
    } catch (e) {
      print("Error while getting payment data: $e");
      return [];
    }
  }

  Future<bool> deletePayment(String paymentID) async {
    try {
      // Execute the delete query
      var result = await pool.execute(
        'DELETE FROM payments WHERE paymentID = :paymentID', {"paymentID": paymentID},
      );

      // Check if the deletion was successful
      return result.affectedRows.toInt() == 1;
    } catch (e) {
      // Handle database errors or other exceptions here
      print('Error while deleting Payment data: $e');
      return false;
    }
  }

  Future<bool> updatePaymentMethod(String paymentID, String newPaymentMethod) async {
    try {
      var result = await pool.execute(
        'UPDATE payments SET payment_method = :newPaymentMethod WHERE paymentID = :paymentID',
        {
          "newPaymentMethod": newPaymentMethod,
          "paymentID": paymentID,
        },
      );

      return result.affectedRows.toInt() == 1;
    } catch (e) {
      print('Error while updating Payment Method: $e');
      return false;
    }
  }
}

void main() {
  print(DateFormat('dd-MMM-yyyy HH:mm:ss').format(DateTime.now()));
}
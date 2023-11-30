import 'dart:ffi';

import 'package:jom_makan/database/db_connection.dart';

class Renew {
  Future<bool> renewRegister({
    required String stallID, required String stallName, required String stallOwner, required String totalStaff, required String canteen,
  }) async {
    try {
      var result = await pool.execute(
        'INSERT INTO stallDisplay (stallID, stallName, stallOwner, totalStaff, canteen)'
        ' VALUES (:stallID, :stallName, :stallOwner, :totalStaff, :canteen)',
        {
          "stallID": stallID,
          "stallName": stallName,
          "stallOwner": stallOwner,
          "totalStaff": totalStaff,
          "canteen": canteen,
        },
      );

      // Check if the insertion was successful
      return result.affectedRows.toInt() == 1;
    } catch (e) {
      print("Error while renewing license: $e");
      return false;
    }
  }


  Future<List<Map<String, dynamic>>> getRenewData() async {
    try {
      var results = await pool.execute('SELECT * FROM stallDisplay');
    
      List<Map<String, dynamic>> renew = [];

      for (final row in results.rows) {
        renew.add({
          'stallID': row.colByName("stallID"),
          'stallName': row.colByName("stallName"),
          'stallOwner': row.colByName("stallOwner"),
          'totalStaff': row.colByName("totalStaff"),
          'canteen': row.colByName("canteen"),
        });
      }

      return renew;
    } catch (e) {
      print("Error while getting admin renewing data: $e");
      return [];
    }
  }

  Future<bool> deleteRenew(String stallID) async {
    try {
      // Execute the delete query
      var result = await pool.execute(
        'DELETE FROM stallDisplay WHERE stallID = :stallID', {"stallID": stallID},
      );

      // Check if the deletion was successful
      return result.affectedRows.toInt() == 1;
    } catch (e) {
      // Handle database errors or other exceptions here
      print('Error while deleting renew data: $e');
      return false;
    }
  }
}
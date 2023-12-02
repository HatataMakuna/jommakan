import 'package:jom_makan/database/db_connection.dart';

class SeatDisplay {
  Future<bool> seatAdded({
    required String confirmationID, required int row, required int col, required String location, required DateTime time,
  }) async {
    try {
      var result = await pool.execute(
        'INSERT INTO seatNumber (confirmationID, row, col, location, time)'
        ' VALUES (:confirmationID, :row, :col, :location, :time)',
        {
          "confirmationID": confirmationID,
          "row": row,
          "col": col,
          "location": location,
          "time": time,
        },
      );

      // Check if the insertion was successful
      return result.affectedRows.toInt() == 1;
    } catch (e) {
      print("Error while adding Seating: $e");
      return false;
    }
  }

  Future<bool> deleteSeat(String confirmationID) async {
    try {
      // Execute the delete query
      var result = await pool.execute(
        'DELETE FROM seatNumber WHERE confirmationID = :confirmationID', {"confirmationID": confirmationID},
      );

      // Check if the deletion was successful
      return result.affectedRows.toInt() == 1;
    } catch (e) {
      // Handle database errors or other exceptions here
      print('Error while deleting Seating: $e');
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getSeatingData() async {
    try {
      var results = await pool.execute('SELECT * FROM seatNumber');
    
      List<Map<String, dynamic>> seatDisplay = [];

      for (final row in results.rows) {
        seatDisplay.add({
          'confirmationID': row.colByName("confirmationID"),
          'row': row.colByName("row"),
          'col': row.colByName("col"),
          'location': row.colByName("location"),
          'time': row.colByName("time"),
        });
      }

      return seatDisplay;
    } catch (e) {
      print("Error while getting promotion data: $e");
      return [];
    }
  }


  // Future<bool> updateQuantity(String foodId, int newQuantity) async {
  //   try {
  //     var result = await pool.execute(
  //       'UPDATE promotion SET quantity = :newQuantity WHERE foodId = :foodId',
  //       {
  //         "newQuantity": newQuantity,
  //         "foodId": foodId,
  //       },
  //     );

  //     return result.affectedRows.toInt() == 1;
  //   } catch (e) {
  //     print('Error while updating quantity: $e');
  //     return false;
  //   }
  // }
}


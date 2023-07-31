/* import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<String> _generateUserID() async {
  // Open a connection to the database
  String databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'jommakan.db');
  Database database = await openDatabase(path);

  // Retrieve the latest user ID from the database
  List<Map<String, dynamic>> rows = await database.rawQuery(
    'SELECT MAX(user_id) FROM users',
  );
  String latestUserID = rows[0]['MAX(user_id)'] ?? '0';

  // Increment the latest user ID and generate the new user ID
  int newUserID = int.parse(latestUserID) + 1;
  String newUserIDString = newUserID.toString();

  // Close the database connection
  await database.close();

  return newUserIDString;
}
 */
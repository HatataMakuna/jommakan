/* import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> _initializeDatabase() async {
  // Get the path for the database file
  String databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'jommakan.db');

  // Open the database
  Database database = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
    // Create the table when the database is created
    await db.execute(
      'CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
    );
  });

  return database;
}

void main() async {
  // Initialize the database
  Database database = await _initializeDatabase();

  // Use the database
  // ...

  // Close the database connection when no longer needed
  await database.close();
} */
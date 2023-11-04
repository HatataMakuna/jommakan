// JUST FOR TESTING PURPOSE
import 'db_connection.dart';

Future<void> fetchData() async {
  final conn = await createConnection();
  var results = await conn.query('SELECT * FROM your_table');
  for (var row in results) {
    print('Data: ${row.fields['column_name']}');
  }
  await conn.close();
}
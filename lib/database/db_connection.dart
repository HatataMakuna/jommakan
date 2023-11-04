import 'package:mysql1/mysql1.dart';

Future<MySqlConnection> createConnection() async {
  final connection = await MySqlConnection.connect(ConnectionSettings(
    host: 'jommakan.c1efdodxxtlq.us-east-1.rds.amazonaws.com',
    port: 3306,
    user: 'admin',
    db: 'jommakan',
    password: 'fypjommakan',
  ));

  return connection;
}

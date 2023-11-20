import 'package:mysql_client/mysql_client.dart';

final pool = MySQLConnectionPool(
  host: 'jommakan.c1efdodxxtlq.us-east-1.rds.amazonaws.com',
  port: 3306,
  userName: 'admin',
  password: 'fypjommakan',
  maxConnections: 10,
  databaseName: 'jommakan',
);
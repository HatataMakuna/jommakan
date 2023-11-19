import 'package:mysql1/mysql1.dart';

class MySqlConnectionPool {
  static const int poolSize = 5; // Adjust the pool size based on your requirements

  late final List<MySqlConnection> _connections;
  int _currentConnectionIndex = 0;

  MySqlConnectionPool() {
    _connections = []; // Initialize an empty list
  }

  Future<void> initConnections() async {
    print("Initialize connections");
    _connections = await Future.wait(List.generate(poolSize, (_) => createConnection()));
  }

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

  Future<MySqlConnection> getConnection() async {
    final connection = _connections[_currentConnectionIndex];

    // Move to the next connection in the pool
    _currentConnectionIndex = (_currentConnectionIndex + 1) % poolSize;

    // Check if the connection is closed and reopen if necessary
    try {
      // Execute a simple query to check the connection status
      await connection.query('SELECT 1');

      return connection;
    } catch (_) {
      // Reopen the connection if an exception occurs (indicating it's closed)
      await connection.close();
      _connections[_currentConnectionIndex] = await createConnection();

      return _connections[_currentConnectionIndex];
    }
  }
}

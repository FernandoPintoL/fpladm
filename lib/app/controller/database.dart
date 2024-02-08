// import 'package:connect_to_sql_server_directly/connect_to_sql_server_directly.dart';
// import 'package:flutter/cupertino.dart';
//
// class Database {
//   ConnectToSqlServerDirectly conectSqlServer = ConnectToSqlServerDirectly();
//   Database();
//
//   Future<void> transaccion() async {
//     try {
//       await conectSqlServer.initializeConnection(
//         //serverIp
//         '192.168.1.35',
//         //databaseName
//         'market',
//         //username
//         'sa',
//         //password
//         '1234',
//         instance: 'SQL Server (MSSQLSERVER)'
//       ).then((value){
//         debugPrint(value.toString());
//         if(value){
//           debugPrint('insertando...');
//           conectSqlServer.getStatusOfQueryResult("INSERT INTO item (nombre,descripcion) VALUES ('nombre2','insertando2')")
//               .then((value) => debugPrint('insertado: $value'));
//         }
//       });
//     } catch (e) {
//       debugPrint("error en conexion: $e");
//     }
//   }
// }
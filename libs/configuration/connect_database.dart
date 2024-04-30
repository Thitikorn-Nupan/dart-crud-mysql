import 'package:dotenv/dotenv.dart';
import 'package:mysql_client/mysql_client.dart' show MySQLConnection;
import '../log/logging.dart';

class ConnectDatabase {

  var logger;
  late DotEnv env;

  ConnectDatabase() {
    Logging.setLogName('libs/configuration/connect_database.dart');
    logger = Logging.logger;
    env = DotEnv(includePlatformEnvironment: true)..load(['env/.env']);
  }

  /*
   *** i think it's good
   no need to set async/await on this getter
   but when you call this method you have to call with async/await
   finally first way (set async/await) or second way
   when you call this method you have to call with async/await
  */
  Future<MySQLConnection> get createConnection {
    logger.info('initial creating mysql connection');
    return  MySQLConnection.createConnection(
        host: env['SQLL_HOST'],
        port: int.parse("${env['SQLL_PORT']}"),
        userName: "${env['SQLL_USERNAME']}",
        password: "${env['SQLL_PASSWORD']}" ,
        databaseName: "${env['SQLL_DATABASE']}" // optional
    );
  }

}

/*
main () async {
  ConnectDatabase connectDatabase = ConnectDatabase();
  var mysql = await connectDatabase.createConnection;
  await mysql.connect().then((response)async => {
    print('connected') ,
    await mysql.close()
  }).catchError((onError) => {
    print(onError),
    throw onError
  });
}
*/

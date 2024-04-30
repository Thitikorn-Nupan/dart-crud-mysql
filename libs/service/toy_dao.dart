import 'package:mysql_client/mysql_client.dart';
import '../configuration/connect_database.dart';
import '../entity/toy.dart';
import '../log/logging.dart';
import '../repository/toy_repo.dart';
import 'sql/command.dart' show sqlCommand;

class ToyDaoService implements ToyRepo<Toy> {
  late ConnectDatabase connectDatabase;
  late MySQLConnection mysql;

  var logger;
  Set<String> sql = sqlCommand.call(); // apply with typedef

  ToyDaoService() {
    // Logging.setLogConsole();
    Logging.setLogName('libs/service/toy_dao.dart');
    logger = Logging.logger;
  }

  /*
    // **** this way is good if you don't use Dao concept
    Method for load mysql connect class to mysql variable
    *** So you can't use mysql until you use mysql.connect()
    ---------------------------------------------------------------
    initialCreatingMysqlConnection() async {
      connectDatabase = ConnectDatabase();
      // await will destroy Future<> Type So now you can use MySQLConnection Type
      mysql = await connectDatabase.createConnection;
    }
    ---------------------------------------------------------------
  */

  /*
     // **** this way is good if you use Dao concept
     have to call open and close db on repo class
     seem you call mysql then open and close on your own
  */
  @override
  initialCreatingMysqlConnectionAndConnectMysql() async {
    connectDatabase = ConnectDatabase();
    mysql = await connectDatabase.createConnection;
    await mysql.connect();
    logger.info('database is connecting');
  }

  @override
  destroyCreatingMysqlConnectionConnectMysql() async {
    await mysql.close();
    logger.info('database closed');
  }

  @override
  Future<Toy> read(int tid) async {
    logger.info('you called read(tid) method async');

    IResultSet result = await mysql.execute(sql.elementAt(1), {'tid': tid});
    logger.info("result.rows.isEmpty : ${result.rows.isEmpty}\nresult.affectedRows : ${result.affectedRows}");
    /*
      result.affectedRows will return 1 or more when columns has affect (insert , update , delete)
    */

    if (result.rows.isEmpty) {
      return new Toy(0, "", "", 0, "");
    }

    // if tid did not exist it will throw Local 'toy' has not been initialized So before define Toy i have to check result query first
    late Toy toy;

    /// loop and get element by name and create toy object class
    result.rows.forEach((element) {
      /*
        element.assoc() : {tid: 17, name: MG MSN-04 SAZABI VER KA, status: used, price: 2299.000000, release_date: 2021-02-27 19:08:29}
        element : Instance of 'ResultSetRow'
      */
      logger.info("element.assoc() : ${element.assoc()}\nelement : $element");
      toy = Toy(
        int.parse(element.colByName('tid').toString()),
        element.colByName('name').toString(),
        element.colByName('status').toString(),
        double.parse(element.colByName('price').toString()),
        element.colByName('release_date').toString(),
      );
    });
    return toy;
  }

  @override
  Future<List<Toy>> reads() async {
    logger.info('you called reads() method async');
    IResultSet result = await mysql.execute(sql.elementAt(0));
    List<Toy> toys = [];
    result.rows.forEach((element) {
      logger.info("element.assoc() : ${element.assoc()}\nelement : $element");
      /**
          element.assoc() : {tid: 17, name: MG MSN-04 SAZABI VER KA, status: used, price: 2299.000000, release_date: 2021-02-27 19:08:29}
          element : Instance of 'ResultSetRow'
          ...
          .
       */
      toys.add(Toy(
        int.parse(element.colByName('tid').toString()),
        element.colByName('name').toString(),
        element.colByName('status').toString(),
        double.parse(element.colByName('price').toString()),
        element.colByName('release_date').toString(),
      ));
    });
    return toys;
  }

  @override
  Future<bool> create(Toy toy) async {
    logger.info('you called create(toy) method async');
    // String dateTimeCurrent = DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now());
    IResultSet result = await mysql.execute(
        sql.elementAt(2),
        // way to pass values
        {
          "name": toy.name,
          "status": toy.status,
          "price": toy.price,
          "release_date": toy.releaseDate
        });
    if (result.affectedRows.toInt() >= 1) {
      return true;
    }
    return false;
  }

  @override
  Future<bool> update(Toy toy, int tid) async {
    logger.info('you called update(toy,tid) method async');
    IResultSet result = await mysql.execute(
        sql.elementAt(3), // way to pass values
        {
          "name": toy.name,
          "status": toy.status,
          "price": toy.price,
          "release_date": toy.releaseDate,
          "tid": tid
        });
    /*
      return result.affectedRows.toInt() >= 1;
    */
    if (result.affectedRows.toInt() >= 1) {
      return true;
    }
    return false;
  }

  @override
  Future<bool> delete(int tid) async {
    logger.info('you called delete(tid) method async');
    IResultSet result = await mysql.execute(
        sql.elementAt(4), // way to pass values
        {
          "tid": tid,
        });
    /*
      return result.affectedRows.toInt() >= 1;
    */
    if (result.affectedRows.toInt() >= 1) {
      return true;
    }
    return false;
  }
}

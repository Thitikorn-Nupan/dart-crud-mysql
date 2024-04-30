import 'package:intl/intl.dart'; // for date format
import 'package:intl/date_symbol_data_local.dart'; // for other locales
import '../libs/entity/toy.dart';
import '../libs/log/logging.dart';
import '../libs/repository/toy_repo.dart';
import '../libs/service/toy_dao.dart';



main() async {

  /// Service Layer
  ToyRepo toyRepo = ToyDaoService();

  /// initial logging (set Log on console)
  Logging.setLogConsole();
  Logging.setLogName("bin/main.dart");
  var logger = Logging.logger;

  /// create connection and connect to mysql database
  await toyRepo.initialCreatingMysqlConnectionAndConnectMysql();

  // logger.info(await toyRepo.create(Toy(0,'WWE STONE COLD STEVE AUSTIN','used',2999.99,DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now()))));
  logger.info(await toyRepo.reads());
  // logger.info(await toyRepo.read(21));
  // logger.info(await toyRepo.update(Toy(0,'WWE STONE COLD STEVE AUSTIN','used',2999.99,'2009-01-30 06:00:01'),21));
  // logger.info(await toyRepo.delete(21));

  /// close connection
  await toyRepo.destroyCreatingMysqlConnectionConnectMysql();

}
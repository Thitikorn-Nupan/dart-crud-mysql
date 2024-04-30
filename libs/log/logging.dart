import 'package:logging/logging.dart';

class Logging {
  // this way is the best for static concept
  static late Logger logger;

  static setLogConsole() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      print('${record.level.name} : ${record.time} : ${record.loggerName} : ${record.message}');
    });
  }

  static setLogName(String name) {
    logger = Logger(name);
  }

}

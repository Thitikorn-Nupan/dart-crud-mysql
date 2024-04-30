/*
  I can access database tho this abstract class
  **** Work like Interface in Java (Dao concept)
*/
abstract class ToyRepo <T> {
  Future<List<T>> reads();
  Future<T> read(int tid);
  Future<bool> create (T toy);
  Future<bool> update (T toy  , int tid);
  Future<bool> delete (int tid);
  initialCreatingMysqlConnectionAndConnectMysql();
  destroyCreatingMysqlConnectionConnectMysql();
}


typedef SqlCommand();

Set<String> _command () {
  return {
    // :name , :status , ... it will pass value later
    // it's like @Query(...) in spring boot
    'select * from toys;',
    'select * from toys where tid = :tid;',
    'insert into toys (name,status,price,release_date) values (:name,:status,:price,:release_date);',
    'update toys set name = :name , status = :status , price = :price , release_date = :release_date  where name = :name;',
    'delete from toys where tid = :tid;'
  };
}

SqlCommand sqlCommand = _command;



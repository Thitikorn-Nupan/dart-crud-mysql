class Toy {

  int _tid;
  String _name;
  String _status;
  double _price ;
  String _releaseDate ;

  Toy(this._tid,this._name, this._status, this._price, this._releaseDate);


  int get tid => _tid;

  set tid(int value) {
    _tid = value;
  }

  String get releaseDate => _releaseDate;

  set releaseDate(String value) {
    _releaseDate = value;
  }

  double get price => _price;

  set price(double value) {
    _price = value;
  }

  String get status => _status;

  set status(String value) {
    _status = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  @override
  String toString() {
    return 'Toy{_tid: $_tid,_name: $_name, _status: $_status, _price: $_price, _releaseDate: $_releaseDate}';
  }
}
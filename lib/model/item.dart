class Item {
  int _id;
  String _name;
  String _alamat;
  int _nomorhp;
  
  int get id => _id;

  String get name => this._name;
  set name(String value) => this._name = value;

  String get alamat => this._alamat;
  set alamat(String value) => this._alamat = value;

  get nomorhp => this._nomorhp;
  set nomorhp(value) => this._nomorhp = value;

  // konstruktor versi 1
  Item(this._name, this._alamat, this._nomorhp);

  // konstruktor versi 2: konversi dari Map ke Item
  Item.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._alamat = map['alamat'];
    this._nomorhp = map['nomorhp'];
  }

  // konversi dari Item ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['name'] = name;
    map['alamat'] = alamat;
    map['nomorhp'] = nomorhp;
    return map;
  }
}
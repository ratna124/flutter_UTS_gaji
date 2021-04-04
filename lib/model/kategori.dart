class Kategori {
  int _id;
  String _golongan;
  int _gaji;
  
  int get id => _id;

  String get golongan => this._golongan;
  set golongan(String value) => this._golongan = value;

  get gaji => this._gaji;
  set gaji(value) => this._gaji = value;

  // konstruktor versi 1
  Kategori(this._golongan, this._gaji);

  // konstruktor versi 2: konversi dari Map ke Item
  Kategori.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._golongan = map['kgolongan'];
    this._gaji = map['gaji'];
  }

  // konversi dari Item ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['golongan'] = golongan;
    map['gaji'] = gaji;
    return map;
  }
}
  
class Profil {
  int id; 
  String nama;
  String alamat;
  String kota;
  String telp;

  Profil(
      {this.id, this.nama, this.alamat, this.kota, this.telp});

  factory Profil.fromMap(Map<String, dynamic> map) {
    return Profil(
      id: map['id'], 
      nama: map['nama'],
      alamat: map['alamat'],
      kota: map['kota'],
      telp: map['telp'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this.id; 
    map['nama'] = nama;
    map['alamat'] = alamat;
    map['kota'] = kota;
    map['telp'] = telp;
    return map;
  }
}
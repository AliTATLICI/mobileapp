class PersonelISUBU {
  int id;
  Birim birim;
  Bolum bolum;
  String adiSoyadi;
  String sicil;
  String telefon;
  String ePosta;
  String genelBilgi;
  int anaBilimDali;

  PersonelISUBU(
      {this.id,
      this.birim,
      this.bolum,
      this.adiSoyadi,
      this.sicil,
      this.telefon,
      this.ePosta,
      this.genelBilgi,
      this.anaBilimDali});

  PersonelISUBU.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    birim = json['birim'] != null ? new Birim.fromJson(json['birim']) : null;
    bolum = json['bolum'] != null ? new Bolum.fromJson(json['bolum']) : null;
    adiSoyadi = json['adi_soyadi'];
    sicil = json['sicil'];
    telefon = json['telefon'];
    ePosta = json['e_posta'];
    genelBilgi = json['genel_bilgi'];
    anaBilimDali = json['ana_bilim_dali'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.birim != null) {
      data['birim'] = this.birim.toJson();
    }
    if (this.bolum != null) {
      data['bolum'] = this.bolum.toJson();
    }
    data['adi_soyadi'] = this.adiSoyadi;
    data['sicil'] = this.sicil;
    data['telefon'] = this.telefon;
    data['e_posta'] = this.ePosta;
    data['genel_bilgi'] = this.genelBilgi;
    data['ana_bilim_dali'] = this.anaBilimDali;
    return data;
  }
}

class Birim {
  String adi;
  String birimKodu;

  Birim({this.adi, this.birimKodu});

  Birim.fromJson(Map<String, dynamic> json) {
    adi = json['adi'];
    birimKodu = json['birim_kodu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adi'] = this.adi;
    data['birim_kodu'] = this.birimKodu;
    return data;
  }
}

class Bolum {
  String adi;
  String altBirimKodu;

  Bolum({this.adi, this.altBirimKodu});

  Bolum.fromJson(Map<String, dynamic> json) {
    adi = json['adi'];
    altBirimKodu = json['alt_birim_kodu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adi'] = this.adi;
    data['alt_birim_kodu'] = this.altBirimKodu;
    return data;
  }
}
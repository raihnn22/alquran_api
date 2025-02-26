class Alquran {
  int? nomor;
  String? nama;
  String? namaLatin;
  int? jumlahAyat;
  String? tempatTurun;
  String? arti;
  String? deskripsi;
  List<Ayat>? ayat;  // Tambahkan ini untuk variabel ayat

  Alquran({
    this.nomor,
    this.nama,
    this.namaLatin,
    this.jumlahAyat,
    this.tempatTurun,
    this.arti,
    this.deskripsi,
    this.ayat,   // Inisialisasi variabel ayat
  });

  factory Alquran.fromJson(Map<String, dynamic> json) {
    return Alquran(
      nomor: json['nomor'],
      nama: json['nama'],
      namaLatin: json['nama_latin'],
      jumlahAyat: json['jumlah_ayat'],
      tempatTurun: json['tempat_turun'],
      arti: json['arti'],
      deskripsi: json['deskripsi'],
      ayat: json.containsKey('ayat') && json['ayat'] != null
        ? (json['ayat'] as List<dynamic>).map((item) => Ayat.fromJson(item)).toList()
        : [], // Jika tidak ada 'ayat', set ke list kosong
    );
  }
}

class Ayat {
  int? id;
  int? surah;
  int? nomor;
  String? ar;
  String? tr;
  String? idn;

  Ayat({
    this.id,
    this.surah,
    this.nomor,
    this.ar,
    this.tr,
    this.idn,
  });

  factory Ayat.fromJson(Map<String, dynamic> json) {
    return Ayat(
      id: json['id'],
      surah: json['surah'],
      nomor: json['nomor'],
      ar: json['ar'],
      tr: json['tr'],
      idn: json['idn'],
    );
  }
}
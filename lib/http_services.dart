import 'package:http/http.dart' as http;
import 'dart:convert';
import 'post_model.dart';

class HttpService {
  final String baseUrl = "https://quran-api.santrikoding.com/api/surah";

  // Ambil daftar surah
  Future<List<Alquran>> Surah() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Alquran.fromJson(item)).toList();
    } else {
      throw Exception("Gagal mengambil data, kode: ${response.statusCode}");
    }
  }

  //  Ambil ayat berdasarkan nomor surah
  Future<List<Ayat>> SurahAyat(int surahNumber) async {
    final response = await http.get(Uri.parse("$baseUrl/$surahNumber"));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return (jsonData['ayat'] as List<dynamic>)
          .map((item) => Ayat.fromJson(item))
          .toList();
    } else {
      throw Exception("Gagal mengambil ayat, kode: ${response.statusCode}");
    }
  }
}
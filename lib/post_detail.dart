import 'package:flutter/material.dart';
import 'http_services.dart'; // ✅ Import service
import 'post_model.dart';
import 'package:google_fonts/google_fonts.dart';

class PostDetail extends StatefulWidget {
  final Alquran post;

  const PostDetail({Key? key, required this.post}) : super(key: key);

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  final HttpService httpService = HttpService(); 
  List<Ayat> ayatList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadAyat();
  }

  Future<void> loadAyat() async {
    try {
      List<Ayat> fetchedAyat = await httpService.SurahAyat(widget.post.nomor!);
      setState(() {
        ayatList = fetchedAyat;
        isLoading = false;
      });
    } catch (e) {
      print("Error: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: Text(
          widget.post.namaLatin ?? "Detail Surah",
          style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)), // Tambahkan warna merah
        ),
        backgroundColor: const Color.fromARGB(255, 148, 12, 12), // Tambahkan warna background putih
      ),
      body: Container(
        color: Colors.white, // Tambahkan warna background putih
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: ayatList.length,
                itemBuilder: (context, index) {
                  Ayat ayat = ayatList[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              ayat.ar ?? "",
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl, 
                              style: GoogleFonts.amiri(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "${ayat.nomor}. Artinya: ${ayat.idn}",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
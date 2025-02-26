
import 'package:flutter/material.dart'; 
import 'http_services.dart'; 
import 'post_model.dart'; 
import 'post_detail.dart';

class PostsPage extends StatelessWidget {
  final HttpService httpService = HttpService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Al-Qur'an"),
        backgroundColor: const Color.fromARGB(255, 148, 12, 12),
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: httpService.Surah(),  // <-- Ubah ini
        builder: (BuildContext context, AsyncSnapshot<List<Alquran>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Terjadi kesalahan: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Tidak ada data surat."));
          } else {
            List<Alquran> posts = snapshot.data!;
            return ListView(
              children: posts.map((Alquran post) => Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PostDetail(post: post),
                    ),
                  ),
                  title: Text(
                    post.namaLatin.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text("Arti: ${post.arti}"),
                  leading: CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 148, 12, 12),
                    foregroundColor: Colors.white,
                    child: Text(post.nomor.toString()),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                ),
              )).toList(),
            );
          }
        },
      ),
    );
  }
}
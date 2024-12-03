import 'package:aslab_travel/model/makanan_model.dart';
import 'package:aslab_travel/services/makanan_service.dart';
import 'package:aslab_travel/widgets/makanan_card.dart';
import 'package:flutter/material.dart';

class Pertemuan9APIScreen extends StatelessWidget {
  final MakananService _makananService = MakananService();
  Pertemuan9APIScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daftar Menu Seafood',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<List<MakananModel>>(
        future: _makananService.fetchMakanan(),
        builder: (context, Snapshot) {
          if (Snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (Snapshot.hasError) {
            return Center(
              child: Text("Eror : ${Snapshot.error}"),
            );
          } else if (!Snapshot.hasData || Snapshot.data!.isEmpty) {
            return Center(
              child: Text("Tidak Ada Makanan Yang Tersedia"),
            );
          } else {
            final makanan = Snapshot.data!;
            return ListView.builder(
              itemBuilder: (context, index) {
                return MakananCard(makananModel: makanan[index]);
              },
              itemCount: makanan.length,
            );
          }
        },
      ),
    );
  }
}

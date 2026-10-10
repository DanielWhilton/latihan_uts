
import 'dart:io';

// 1. Menyimpan daftar film dan harga tiket
Map<String, int> daftarFilm = {
  'Avengers': 40000,
  'Frozen': 35000,
  'Interstellar': 45000,
};

// 2. Menyimpan semua pemesanan tiket
List<Map<String, dynamic>> pemesanan = [];

// 3. Function untuk membaca input teks
String bacaTeks(String pesan) {
  stdout.write(pesan);
  return stdin.readLineSync() ?? '';
}

// 4. Function untuk membaca input angka
int bacaAngka(String pesan) {
  while (true) {
    String input = bacaTeks(pesan);
    int? angka = int.tryParse(input);

    if (angka != null) {
      return angka;
    }

    print('Input harus berupa angka!');
  }
}

// 5. Function untuk menambah pemesanan
void tambahPemesanan() {
  print('\n===== PESAN TIKET =====');

  String nama = bacaTeks('Nama pelanggan: ');

  print('\nDaftar film:');

  int nomorFilm = 1;
  for (String film in daftarFilm.keys) {
    print('$nomorFilm. $film - Rp${daftarFilm[film]}');
    nomorFilm++;
  }

  String judulFilm = bacaTeks('Masukkan judul film: ');

  if (!daftarFilm.containsKey(judulFilm)) {
    print('Film tidak tersedia.');
    return;
  }

  int jumlah = bacaAngka('Jumlah tiket: ');

  if (jumlah <= 0) {
    print('Jumlah tiket harus lebih dari 0.');
    return;
  }

  int harga = daftarFilm[judulFilm]!;
  int total = harga * jumlah;

  Map<String, dynamic> dataPemesanan = {
    'nama': nama,
    'film': judulFilm,
    'jumlah': jumlah,
    'harga': harga,
    'total': total,
    'status': 'Belum dibayar',
  };

  pemesanan.add(dataPemesanan);

  print('\nPemesanan berhasil!');
  print('Total pembayaran: Rp$total');
}

// 6. Function untuk menampilkan pemesanan
void tampilkanPemesanan() {
  print('\n===== DAFTAR PEMESANAN =====');

  if (pemesanan.isEmpty) {
    print('Belum ada pemesanan.');
    return;
  }

  for (int i = 0; i < pemesanan.length; i++) {
    print('\nPemesanan nomor ${i + 1}');
    print('Nama   : ${pemesanan[i]['nama']}');
    print('Film   : ${pemesanan[i]['film']}');
    print('Jumlah : ${pemesanan[i]['jumlah']} tiket');
    print('Total  : Rp${pemesanan[i]['total']}');
    print('Status : ${pemesanan[i]['status']}');
    print('-------------------------');
  }
}

// 7. Function untuk mengubah status pembayaran
void ubahPembayaran() {
  if (pemesanan.isEmpty) {
    print('Belum ada pemesanan.');
    return;
  }

  tampilkanPemesanan();

  int nomor = bacaAngka('Pilih nomor pemesanan: ');

  if (nomor < 1 || nomor > pemesanan.length) {
    print('Nomor pemesanan tidak valid.');
    return;
  }

  pemesanan[nomor - 1]['status'] = 'Sudah dibayar';

  print('Pembayaran berhasil diperbarui.');
}

// 8. Function untuk membatalkan pemesanan
void batalkanPemesanan() {
  if (pemesanan.isEmpty) {
    print('Belum ada pemesanan.');
    return;
  }

  tampilkanPemesanan();

  int nomor = bacaAngka('Pilih nomor yang dibatalkan: ');

  if (nomor < 1 || nomor > pemesanan.length) {
    print('Nomor pemesanan tidak valid.');
    return;
  }

  String nama = pemesanan[nomor - 1]['nama'];

  pemesanan.removeAt(nomor - 1);

  print('Pemesanan atas nama $nama berhasil dibatalkan.');
}

// 9. Function untuk menghitung jumlah pemesanan
void lihatJumlahPemesanan() {
  print('Jumlah transaksi: ${pemesanan.length}');

  int totalTiket = 0;

  for (Map<String, dynamic> data in pemesanan) {
    totalTiket += data['jumlah'] as int;
  }

  print('Jumlah seluruh tiket: $totalTiket');
}

// 10. Function utama
void main() {
  while (true) {
    print('\n===== SISTEM BIOSKOP =====');
    print('1. Pesan tiket');
    print('2. Tampilkan pemesanan');
    print('3. Ubah status pembayaran');
    print('4. Batalkan pemesanan');
    print('5. Lihat jumlah pemesanan');
    print('6. Keluar');

    String pilihan = bacaTeks('Pilih menu: ');

    switch (pilihan) {
      case '1':
        tambahPemesanan();
        break;

      case '2':
        tampilkanPemesanan();
        break;

      case '3':
        ubahPembayaran();
        break;

      case '4':
        batalkanPemesanan();
        break;

      case '5':
        lihatJumlahPemesanan();
        break;

      case '6':
        print('Terima kasih telah menggunakan sistem bioskop.');
        return;

      default:
        print('Pilihan menu tidak valid.');
    }
  }
}
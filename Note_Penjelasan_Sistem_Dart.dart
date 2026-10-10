// ============================================================
// NOTE PENJELASAN KESELURUHAN SISTEM DART
// Catatan untuk sistem Salon, Laundry, Kasir, Rental Mobil,
// Reservasi Hotel, Inventaris Gudang, Klinik, dan Pemesanan Tiket.
// ============================================================

/*
1. LIBRARY INPUT DAN OUTPUT

import 'dart:io';
// Mengimpor library dart:io agar program dapat membaca input
// pengguna dan menampilkan teks pada terminal.

2. FUNGSI INPUT TEKS

String input(String pesan) {
  stdout.write(pesan);
  return stdin.readLineSync() ?? '';
}

// String: fungsi mengembalikan nilai berupa teks.
// input(String pesan): membuat fungsi bernama input dengan parameter pesan.
// stdout.write(pesan): menampilkan pesan tanpa berpindah baris.
// stdin.readLineSync(): membaca teks yang diketik pengguna.
// ?? '': jika hasil input bernilai null, gunakan teks kosong.
// return: mengembalikan nilai input kepada bagian program yang memanggilnya.

3. FUNGSI INPUT ANGKA BULAT

int inputAngka(String pesan) {
  stdout.write(pesan);
  return int.tryParse(stdin.readLineSync() ?? '') ?? 0;
}

// int: fungsi mengembalikan bilangan bulat.
// int.tryParse(): mencoba mengubah teks menjadi bilangan bulat.
// ?? 0: jika input tidak valid atau null, gunakan angka 0.

4. FUNGSI INPUT ANGKA DESIMAL

double inputDesimal(String pesan) {
  stdout.write(pesan);
  return double.tryParse(stdin.readLineSync() ?? '') ?? 0;
}

// double: menyimpan atau mengembalikan angka desimal.
// Cocok untuk data seperti berat cucian, tarif, atau harga desimal.

5. VARIABEL DAN TIPE DATA

String nama = 'Andi';
// String digunakan untuk menyimpan teks.

int jumlah = 10;
// int digunakan untuk menyimpan bilangan bulat.

double harga = 15000.0;
// double digunakan untuk menyimpan angka desimal.

bool aktif = true;
// bool menyimpan nilai true (benar) atau false (salah).

var data = 'Contoh';
// var membuat Dart menentukan tipe variabel berdasarkan nilai awal.

const pajak = 0.1;
// const digunakan untuk nilai konstan yang tidak dapat diubah.

6. STRUKTUR DATA LIST

List<String> daftarNama = [];
// List menyimpan beberapa data dalam satu variabel.
// String menunjukkan bahwa setiap elemen List berupa teks.

daftarNama.add('Andi');
// add() menambahkan data ke dalam List.

daftarNama.remove('Andi');
// remove() menghapus elemen yang cocok dari List.

// daftarNama[0] digunakan untuk mengakses elemen pertama.
// daftarNama.length memberikan jumlah elemen dalam List.
// daftarNama.isEmpty memeriksa apakah List kosong.

7. STRUKTUR DATA MAP

Map<String, dynamic> dataPelanggan = {
  'nama': 'Andi',
  'umur': 20,
};
// Map menyimpan data dalam pasangan key dan value.
// String menunjukkan tipe data key.
// dynamic memungkinkan value memiliki tipe data yang berbeda.

dataPelanggan['umur'] = 21;
// Mengubah nilai yang tersimpan pada key 'umur'.

// dataPelanggan['nama'] digunakan untuk mengambil nama pelanggan.

8. PERCABANGAN IF-ELSE

if (pilihan == 1) {
  print('Tambah data');
} else {
  print('Pilihan tidak tersedia');
}

// if memeriksa apakah kondisi benar.
// else dijalankan ketika kondisi if tidak terpenuhi.

9. PERCABANGAN SWITCH-CASE

switch (pilihan) {
  case 1:
    print('Tambah data');
    break;
  case 2:
    print('Lihat data');
    break;
  default:
    print('Pilihan tidak tersedia');
}

// switch memilih tindakan berdasarkan nilai variabel.
// case menunjukkan nilai pilihan yang ditangani.
// break mengakhiri case.
// default dijalankan jika tidak ada case yang cocok.

10. PERULANGAN WHILE

while (true) {
  print('Menu sistem');
  break;
}

// while mengulang kode selama kondisinya true.
// break menghentikan perulangan.
// Dalam sistem menu, perulangan biasanya terus berjalan sampai pengguna memilih keluar.

11. PERULANGAN FOR

for (int i = 0; i < 5; i++) {
  print(i);
}

// int i = 0: menentukan nilai awal penghitung.
// i < 5: perulangan berjalan selama kondisi benar.
// i++: menaikkan nilai penghitung sebanyak satu.
// Contoh ini menampilkan angka 0 sampai 4.

12. FUNGSI VOID

void tampilkanMenu() {
  print('1. Tambah data');
  print('2. Lihat data');
}

// void menandakan fungsi tidak mengembalikan nilai.
// Fungsi dapat digunakan untuk memisahkan tugas tertentu,
// misalnya menampilkan menu atau daftar data.

13. FUNGSI YANG MENGEMBALIKAN NILAI

double hitungTotal(int jumlah, double harga) {
  return jumlah * harga;
}

// double menunjukkan bahwa hasil fungsi berupa angka desimal.
// jumlah dan harga adalah parameter yang diterima fungsi.
// return mengembalikan hasil perkalian.

double total = hitungTotal(3, 15000);
// Memanggil fungsi dengan jumlah 3 dan harga 15000.

14. VALIDASI DATA KOSONG

if (daftarNama.isEmpty) {
  print('Data masih kosong');
}

// isEmpty memeriksa apakah List atau Map tidak memiliki elemen.
// Validasi membantu mencegah program menampilkan data yang belum ada.

15. FORMAT OUTPUT

print('Total: Rp${total.toStringAsFixed(2)}');

// print() menampilkan teks ke terminal.
// ${...} menyisipkan nilai variabel ke dalam teks.
// toStringAsFixed(2) mengubah angka menjadi teks dengan dua angka desimal.

============================================================
PENJELASAN DELAPAN SISTEM
============================================================

A. SISTEM ANTREAN SALON

// List digunakan untuk menyimpan daftar antrean pelanggan.
// Map digunakan untuk menyimpan detail pelanggan, seperti nama dan layanan.
// Tambah antrean memasukkan pelanggan baru ke daftar.
// Lihat antrean menampilkan pelanggan yang menunggu.
// Panggil pelanggan mengambil pelanggan berikutnya untuk dilayani.
// Hapus data menghapus data pelanggan sesuai fitur program.

B. SISTEM LAUNDRY

// List digunakan untuk menyimpan daftar transaksi laundry.
// Map menyimpan nama pelanggan, berat cucian, jenis layanan, dan biaya.
// Input berat menerima berat cucian pelanggan.
// Pilihan layanan menentukan jenis layanan dan tarifnya.
// Hitung biaya mengalikan berat cucian dengan tarif layanan.
// Status pesanan menyimpan atau menampilkan status pengerjaan.
// Laporan transaksi menampilkan transaksi yang sudah dimasukkan.

C. SISTEM KASIR / POINT OF SALE (POS)

// List digunakan untuk menyimpan barang atau daftar transaksi.
// Map menyimpan nama barang, harga, dan jumlah pembelian.
// Tambah barang memasukkan barang ke daftar belanja.
// Hitung subtotal mengalikan harga barang dengan jumlah pembelian.
// Hitung total menjumlahkan semua subtotal.
// Pembayaran menerima jumlah uang dari pelanggan.
// Hitung kembalian mengurangi pembayaran dengan total belanja.
// Validasi memastikan pembayaran mencukupi total belanja.

D. SISTEM PENYEWAAN MOBIL

// List menyimpan data mobil dan transaksi penyewaan.
// Map menyimpan informasi mobil, tarif sewa, dan status ketersediaan.
// Lihat mobil menampilkan mobil yang tersedia.
// Sewa mobil menyimpan data pelanggan dan mobil yang dipilih.
// Hitung biaya mengalikan tarif harian dengan jumlah hari.
// Status mobil menunjukkan apakah mobil tersedia atau sedang disewa.
// Pengembalian mobil mengubah status mobil menjadi tersedia kembali.

E. SISTEM RESERVASI HOTEL

// List menyimpan data kamar dan reservasi pelanggan.
// Map menyimpan nomor kamar, tipe kamar, tarif, dan status reservasi.
// Lihat kamar menampilkan kamar yang tersedia.
// Reservasi menyimpan informasi tamu dan kamar yang dipilih.
// Hitung biaya mengalikan tarif kamar dengan jumlah malam.
// Status kamar menunjukkan apakah kamar tersedia atau telah dipesan.
// Pembatalan menghapus atau mengubah status reservasi sesuai program.

F. SISTEM INVENTARIS GUDANG

// List menyimpan daftar barang di gudang.
// Map menyimpan kode barang, nama barang, stok, dan harga.
// Tambah barang memasukkan barang baru ke inventaris.
// Tambah stok meningkatkan jumlah persediaan.
// Kurangi stok mengurangi persediaan saat barang keluar.
// Cek stok menampilkan jumlah barang yang tersedia.
// Validasi stok mencegah pengurangan melebihi jumlah persediaan.

G. SISTEM PENDAFTARAN KLINIK

// List menyimpan daftar pasien yang terdaftar.
// Map menyimpan nama pasien, keluhan, nomor antrean, dan data lainnya.
// Registrasi pasien memasukkan data pasien baru.
// Nomor antrean memberikan nomor kepada pasien.
// Lihat pasien menampilkan daftar pasien.
// Panggil pasien memilih pasien berikutnya untuk dilayani.
// Status pelayanan mengelola informasi antrean sesuai fitur program.

H. SISTEM PEMESANAN TIKET

// List menyimpan daftar pemesanan tiket.
// Map menyimpan nama pemesan, jenis tiket, jumlah tiket, dan harga.
// Pilih tiket menentukan jenis atau kategori tiket.
// Input jumlah menerima jumlah tiket yang ingin dibeli.
// Hitung total mengalikan harga tiket dengan jumlah pembelian.
// Konfirmasi pesanan menyimpan informasi pemesanan.
// Lihat pesanan menampilkan daftar tiket yang telah dipesan.

============================================================
RINGKASAN FUNGSI DAN KONSEP UMUM
============================================================

// print()                 : menampilkan teks atau hasil ke terminal.
// stdout.write()          : menampilkan teks tanpa otomatis pindah baris.
// stdin.readLineSync()    : membaca input pengguna.
// return                  : mengembalikan nilai dari fungsi.
// add()                   : menambahkan data ke List.
// remove()                : menghapus data dari List.
// length                  : menghitung jumlah elemen atau karakter.
// isEmpty                 : memeriksa apakah data kosong.
// tryParse()              : mencoba mengubah teks menjadi angka.
// toString()              : mengubah nilai menjadi teks.
// if-else                 : menentukan tindakan berdasarkan kondisi.
// switch-case             : memilih tindakan berdasarkan menu.
// while                   : mengulang kode selama kondisi benar.
// for                     : mengulang kode dengan penghitung.
// break                   : menghentikan perulangan atau case.
// continue                : melewati sisa kode pada iterasi saat ini.
// Map                     : menyimpan data dengan pasangan key-value.
// List                    : menyimpan kumpulan data.
// void                    : fungsi tidak mengembalikan nilai.
// dynamic                 : memperbolehkan value memiliki tipe berbeda.

// CATATAN PENTING
// Sistem-sistem yang dijelaskan menggunakan penyimpanan sementara di
// memori jika belum dihubungkan dengan database atau file permanen.
// Data biasanya hilang ketika program dihentikan.
// File ini adalah catatan penjelasan, bukan implementasi aplikasi utama.
*/

// Fungsi main kosong agar file catatan ini tetap menjadi file Dart yang valid.
void main() {
  // Buka komentar di atas untuk membaca note penjelasan sistem.
}

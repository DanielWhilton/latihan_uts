
import 'dart:io';

// 1. Daftar menu makanan dan harga
Map<String, int> daftarMenu = {
  'Nasi Goreng': 25000,
  'Mie Goreng': 20000,
  'Ayam Bakar': 30000,
  'Sate Ayam': 28000,
  'Es Teh': 5000,
  'Jus Jeruk': 10000,
};

// 2. Menyimpan seluruh pesanan
List<Map<String, dynamic>> pesanan = [];

// 3. Function membaca teks
String bacaTeks(String pesan) {
  stdout.write(pesan);
  return stdin.readLineSync() ?? '';
}

// 4. Function membaca angka
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

// 5. Function menambah pesanan
void tambahPesanan() {
  print('\n===== TAMBAH PESANAN =====');

  String nama = bacaTeks('Nama pelanggan: ').trim();

  if (nama.isEmpty) {
    print('Nama pelanggan tidak boleh kosong.');
    return;
  }

  print('\n===== DAFTAR MENU =====');

  List<String> menuTersedia = daftarMenu.keys.toList();

  for (int i = 0; i < menuTersedia.length; i++) {
    String menu = menuTersedia[i];
    print('${i + 1}. $menu - Rp${daftarMenu[menu]}');
  }

  int nomorMenu = bacaAngka('Pilih nomor menu: ');

  if (nomorMenu < 1 || nomorMenu > menuTersedia.length) {
    print('Nomor menu tidak valid.');
    return;
  }

  String namaMenu = menuTersedia[nomorMenu - 1];
  int harga = daftarMenu[namaMenu]!;

  int jumlah = bacaAngka('Jumlah pesanan: ');

  if (jumlah <= 0) {
    print('Jumlah pesanan harus lebih dari 0.');
    return;
  }

  int total = harga * jumlah;

  Map<String, dynamic> dataPesanan = {
    'nama': nama,
    'menu': namaMenu,
    'harga': harga,
    'jumlah': jumlah,
    'total': total,
    'status': 'Menunggu',
    'pembayaran': 'Belum dibayar',
  };

  pesanan.add(dataPesanan);

  print('\nPesanan berhasil ditambahkan!');
  print('Pelanggan: $nama');
  print('Menu: $namaMenu');
  print('Jumlah: $jumlah');
  print('Total tagihan: Rp$total');
}

// 6. Function menampilkan pesanan
void tampilkanPesanan() {
  print('\n===== DAFTAR PESANAN =====');

  if (pesanan.isEmpty) {
    print('Belum ada pesanan.');
    return;
  }

  for (int i = 0; i < pesanan.length; i++) {
    print('\nPesanan nomor ${i + 1}');
    print('Pelanggan : ${pesanan[i]['nama']}');
    print('Menu      : ${pesanan[i]['menu']}');
    print('Harga     : Rp${pesanan[i]['harga']}');
    print('Jumlah    : ${pesanan[i]['jumlah']}');
    print('Total     : Rp${pesanan[i]['total']}');
    print('Status    : ${pesanan[i]['status']}');
    print('Pembayaran: ${pesanan[i]['pembayaran']}');
    print('--------------------------');
  }
}

// 7. Function mengubah status pesanan
void ubahStatusPesanan() {
  if (pesanan.isEmpty) {
    print('Belum ada pesanan.');
    return;
  }

  tampilkanPesanan();

  int nomor = bacaAngka('Pilih nomor pesanan: ');

  if (nomor < 1 || nomor > pesanan.length) {
    print('Nomor pesanan tidak valid.');
    return;
  }

  print('\n1. Menunggu');
  print('2. Diproses');
  print('3. Selesai');

  String pilihan = bacaTeks('Pilih status baru: ');

  switch (pilihan) {
    case '1':
      pesanan[nomor - 1]['status'] = 'Menunggu';
      break;

    case '2':
      pesanan[nomor - 1]['status'] = 'Diproses';
      break;

    case '3':
      pesanan[nomor - 1]['status'] = 'Selesai';
      break;

    default:
      print('Pilihan status tidak valid.');
      return;
  }

  print('Status pesanan berhasil diubah.');
}

// 8. Function melakukan pembayaran
void bayarPesanan() {
  if (pesanan.isEmpty) {
    print('Belum ada pesanan.');
    return;
  }

  tampilkanPesanan();

  int nomor = bacaAngka('Pilih nomor pesanan yang dibayar: ');

  if (nomor < 1 || nomor > pesanan.length) {
    print('Nomor pesanan tidak valid.');
    return;
  }

  int indeks = nomor - 1;

  if (pesanan[indeks]['pembayaran'] == 'Sudah dibayar') {
    print('Pesanan ini sudah dibayar.');
    return;
  }

  pesanan[indeks]['pembayaran'] = 'Sudah dibayar';

  print('Pembayaran berhasil dicatat.');
  print('Total pembayaran: Rp${pesanan[indeks]['total']}');
}

// 9. Function menghapus pesanan
void hapusPesanan() {
  if (pesanan.isEmpty) {
    print('Belum ada pesanan.');
    return;
  }

  tampilkanPesanan();

  int nomor = bacaAngka('Pilih nomor pesanan yang dihapus: ');

  if (nomor < 1 || nomor > pesanan.length) {
    print('Nomor pesanan tidak valid.');
    return;
  }

  int indeks = nomor - 1;

  if (pesanan[indeks]['pembayaran'] == 'Sudah dibayar') {
    print('Pesanan yang sudah dibayar tidak dapat dihapus.');
    return;
  }

  String nama = pesanan[indeks]['nama'];

  pesanan.removeAt(indeks);

  print('Pesanan atas nama $nama berhasil dihapus.');
}

// 10. Function laporan pendapatan
void laporanPendapatan() {
  int totalPendapatan = 0;
  int jumlahTransaksiDibayar = 0;

  for (Map<String, dynamic> data in pesanan) {
    if (data['pembayaran'] == 'Sudah dibayar') {
      totalPendapatan += data['total'] as int;
      jumlahTransaksiDibayar++;
    }
  }

  print('\n===== LAPORAN PENDAPATAN =====');
  print('Jumlah seluruh pesanan: ${pesanan.length}');
  print('Transaksi sudah dibayar: $jumlahTransaksiDibayar');
  print('Total pendapatan: Rp$totalPendapatan');
}

// 11. Function utama
void main() {
  while (true) {
    print('\n===== SISTEM RESTORAN =====');
    print('1. Tambah pesanan');
    print('2. Tampilkan pesanan');
    print('3. Ubah status pesanan');
    print('4. Bayar pesanan');
    print('5. Hapus pesanan');
    print('6. Laporan pendapatan');
    print('7. Keluar');

    String pilihan = bacaTeks('Pilih menu: ');

    switch (pilihan) {
      case '1':
        tambahPesanan();
        break;

      case '2':
        tampilkanPesanan();
        break;

      case '3':
        ubahStatusPesanan();
        break;

      case '4':
        bayarPesanan();
        break;

      case '5':
        hapusPesanan();
        break;

      case '6':
        laporanPendapatan();
        break;

      case '7':
        print('Terima kasih telah menggunakan sistem restoran.');
        return;

      default:
        print('Pilihan menu tidak valid.');
    }
  }
}
import 'dart:io';

List<Map<String, dynamic>> pesanan = [];
int nomorPesanan = 1;

String input(String pesan) {
  stdout.write(pesan);
  return stdin.readLineSync() ?? '';
}

void tambahPesanan() {
  String nama = input('Nama pelanggan: ');
  double berat =
      double.tryParse(input('Berat pakaian (kg): ')) ?? 0;

  if (nama.trim().isEmpty || berat <= 0) {
    print('Data tidak valid.');
    return;
  }

  print('\nJenis layanan:');
  print('1. Reguler - Rp7000/kg');
  print('2. Express - Rp12000/kg');

  int pilihan = int.tryParse(input('Pilih layanan: ')) ?? 0;
  int harga;

  switch (pilihan) {
    case 1:
      harga = 7000;
      break;
    case 2:
      harga = 12000;
      break;
    default:
      print('Layanan tidak valid.');
      return;
  }

  int total = (berat * harga).round();

  pesanan.add({
    'id': nomorPesanan++,
    'nama': nama,
    'berat': berat,
    'total': total,
    'status': 'Diproses',
    'dibayar': false,
  });

  print('Pesanan berhasil dibuat. Total: Rp$total');
}

void lihatPesanan() {
  if (pesanan.isEmpty) {
    print('Belum ada pesanan.');
    return;
  }

  for (var p in pesanan) {
    print(
      "ID ${p['id']} | ${p['nama']} | ${p['berat']} kg | "
      "Rp${p['total']} | ${p['status']}",
    );
  }
}

void ubahStatus() {
  int id = int.tryParse(input('ID pesanan: ')) ?? 0;

  int index = pesanan.indexWhere((p) => p['id'] == id);

  if (index == -1) {
    print('Pesanan tidak ditemukan.');
    return;
  }

  print('1. Diproses');
  print('2. Siap diambil');
  print('3. Selesai');

  switch (input('Status baru: ')) {
    case '1':
      pesanan[index]['status'] = 'Diproses';
      break;
    case '2':
      pesanan[index]['status'] = 'Siap diambil';
      break;
    case '3':
      pesanan[index]['status'] = 'Selesai';
      break;
    default:
      print('Pilihan tidak valid.');
      return;
  }

  print('Status berhasil diperbarui.');
}

void pembayaran() {
  int id = int.tryParse(input('ID pesanan: ')) ?? 0;

  int index = pesanan.indexWhere((p) => p['id'] == id);

  if (index == -1) {
    print('Pesanan tidak ditemukan.');
    return;
  }

  if (pesanan[index]['dibayar']) {
    print('Pesanan sudah dibayar.');
    return;
  }

  int total = pesanan[index]['total'];
  int bayar =
      int.tryParse(input('Total Rp$total. Uang pembayaran: Rp')) ?? 0;

  if (bayar < total) {
    print('Uang tidak cukup.');
    return;
  }

  pesanan[index]['dibayar'] = true;
  print('Pembayaran berhasil. Kembalian: Rp${bayar - total}');
}

void hapusPesanan() {
  int id = int.tryParse(input('ID pesanan: ')) ?? 0;

  int index = pesanan.indexWhere((p) => p['id'] == id);

  if (index == -1) {
    print('Pesanan tidak ditemukan.');
    return;
  }

  pesanan.removeAt(index);
  print('Pesanan berhasil dihapus.');
}

void main() {
  while (true) {
    print('\n=== SISTEM LAUNDRY ===');
    print('1. Tambah pesanan');
    print('2. Lihat pesanan');
    print('3. Ubah status');
    print('4. Pembayaran');
    print('5. Hapus pesanan');
    print('0. Keluar');

    switch (input('Pilih menu: ')) {
      case '1':
        tambahPesanan();
        break;
      case '2':
        lihatPesanan();
        break;
      case '3':
        ubahStatus();
        break;
      case '4':
        pembayaran();
        break;
      case '5':
        hapusPesanan();
        break;
      case '0':
        return;
      default:
        print('Pilihan tidak valid.');
    }
  }
}
import 'dart:io';

List<Map<String, dynamic>> antrean = [];
int nomorAntrean = 1;

String input(String pesan) {
  stdout.write(pesan);
  return stdin.readLineSync() ?? '';
}

void tampilkanLayanan() {
  print('\n=== DAFTAR LAYANAN ===');
  print('1. Potong rambut - Rp30000');
  print('2. Creambath     - Rp50000');
  print('3. Cat rambut    - Rp100000');
  print('4. Cukur         - Rp20000');
}

void tambahAntrean() {
  String nama = input('Nama pelanggan: ');
  tampilkanLayanan();

  int pilihan = int.tryParse(input('Pilih layanan: ')) ?? 0;
  String layanan;
  int harga;

  switch (pilihan) {
    case 1:
      layanan = 'Potong rambut';
      harga = 30000;
      break;
    case 2:
      layanan = 'Creambath';
      harga = 50000;
      break;
    case 3:
      layanan = 'Cat rambut';
      harga = 100000;
      break;
    case 4:
      layanan = 'Cukur';
      harga = 20000;
      break;
    default:
      print('Layanan tidak valid.');
      return;
  }

  antrean.add({
    'nomor': nomorAntrean++,
    'nama': nama,
    'layanan': layanan,
    'harga': harga,
    'status': 'Menunggu',
  });

  print('Antrean berhasil ditambahkan.');
}

void tampilkanAntrean() {
  if (antrean.isEmpty) {
    print('Belum ada antrean.');
    return;
  }

  for (var a in antrean) {
    print(
      "No.${a['nomor']} | ${a['nama']} | "
      "${a['layanan']} | Rp${a['harga']} | ${a['status']}",
    );
  }
}

void panggilAntrean() {
  int index = antrean.indexWhere(
    (a) => a['status'] == 'Menunggu',
  );

  if (index == -1) {
    print('Tidak ada pelanggan yang menunggu.');
    return;
  }

  antrean[index]['status'] = 'Sedang dilayani';
  print("Memanggil ${antrean[index]['nama']}.");
}

void selesaikanLayanan() {
  int nomor = int.tryParse(input('Nomor antrean: ')) ?? 0;

  int index = antrean.indexWhere(
    (a) => a['nomor'] == nomor,
  );

  if (index == -1) {
    print('Antrean tidak ditemukan.');
    return;
  }

  if (antrean[index]['status'] != 'Sedang dilayani') {
    print('Pelanggan belum sedang dilayani.');
    return;
  }

  antrean[index]['status'] = 'Selesai';
  print('Layanan selesai.');
}

void hapusAntrean() {
  int nomor = int.tryParse(input('Nomor antrean: ')) ?? 0;

  int index = antrean.indexWhere(
    (a) => a['nomor'] == nomor,
  );

  if (index == -1) {
    print('Antrean tidak ditemukan.');
    return;
  }

  antrean.removeAt(index);
  print('Antrean berhasil dihapus.');
}

void main() {
  while (true) {
    print('\n=== SISTEM SALON ===');
    print('1. Lihat layanan');
    print('2. Tambah antrean');
    print('3. Lihat antrean');
    print('4. Panggil antrean');
    print('5. Selesaikan layanan');
    print('6. Hapus antrean');
    print('0. Keluar');

    switch (input('Pilih menu: ')) {
      case '1':
        tampilkanLayanan();
        break;
      case '2':
        tambahAntrean();
        break;
      case '3':
        tampilkanAntrean();
        break;
      case '4':
        panggilAntrean();
        break;
      case '5':
        selesaikanLayanan();
        break;
      case '6':
        hapusAntrean();
        break;
      case '0':
        return;
      default:
        print('Pilihan tidak valid.');
    }
  }
}
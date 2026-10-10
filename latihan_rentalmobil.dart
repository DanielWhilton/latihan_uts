import 'dart:io';

List<Map<String, dynamic>> mobil = [
  {'id': 1, 'nama': 'Avanza', 'harga': 300000, 'tersedia': true},
  {'id': 2, 'nama': 'Innova', 'harga': 500000, 'tersedia': true},
  {'id': 3, 'nama': 'Brio', 'harga': 250000, 'tersedia': true},
];

List<Map<String, dynamic>> penyewaan = [];
int nomorSewa = 1;

String input(String pesan) {
  stdout.write(pesan);
  return stdin.readLineSync() ?? '';
}

void lihatMobil() {
  for (var m in mobil) {
    print(
      "ID ${m['id']} | ${m['nama']} | Rp${m['harga']}/hari | "
      "${m['tersedia'] ? 'Tersedia' : 'Disewa'}",
    );
  }
}

void tambahMobil() {
  String nama = input('Nama mobil: ');
  int harga = int.tryParse(input('Harga sewa per hari: Rp')) ?? 0;

  if (nama.trim().isEmpty || harga <= 0) {
    print('Data mobil tidak valid.');
    return;
  }

  int id = mobil.isEmpty
      ? 1
      : mobil.map((m) => m['id'] as int).reduce((a, b) => a > b ? a : b) + 1;

  mobil.add({
    'id': id,
    'nama': nama,
    'harga': harga,
    'tersedia': true,
  });

  print('Mobil berhasil ditambahkan.');
}

void sewaMobil() {
  lihatMobil();

  int id = int.tryParse(input('ID mobil: ')) ?? 0;
  int index = mobil.indexWhere((m) => m['id'] == id);

  if (index == -1 || mobil[index]['tersedia'] != true) {
    print('Mobil tidak ditemukan atau sedang disewa.');
    return;
  }

  String nama = input('Nama penyewa: ');
  int hari = int.tryParse(input('Lama sewa (hari): ')) ?? 0;

  if (nama.trim().isEmpty || hari <= 0) {
    print('Data penyewaan tidak valid.');
    return;
  }

  int total = mobil[index]['harga'] * hari;

  mobil[index]['tersedia'] = false;

  penyewaan.add({
    'id': nomorSewa++,
    'mobilId': id,
    'nama': nama,
    'mobil': mobil[index]['nama'],
    'hari': hari,
    'total': total,
    'dibayar': false,
  });

  print('Penyewaan berhasil. Total: Rp$total');
}

void lihatPenyewaan() {
  if (penyewaan.isEmpty) {
    print('Belum ada penyewaan.');
    return;
  }

  for (var p in penyewaan) {
    print(
      "ID ${p['id']} | ${p['nama']} | ${p['mobil']} | "
      "${p['hari']} hari | Rp${p['total']} | "
      "${p['dibayar'] ? 'Lunas' : 'Belum bayar'}",
    );
  }
}

void pembayaran() {
  int id = int.tryParse(input('ID penyewaan: ')) ?? 0;
  int index = penyewaan.indexWhere((p) => p['id'] == id);

  if (index == -1) {
    print('Penyewaan tidak ditemukan.');
    return;
  }

  if (penyewaan[index]['dibayar']) {
    print('Penyewaan sudah dibayar.');
    return;
  }

  int total = penyewaan[index]['total'];
  int bayar = int.tryParse(input('Total Rp$total. Bayar: Rp')) ?? 0;

  if (bayar < total) {
    print('Uang tidak cukup.');
    return;
  }

  penyewaan[index]['dibayar'] = true;
  print('Pembayaran berhasil. Kembalian: Rp${bayar - total}');
}

void kembalikanMobil() {
  int id = int.tryParse(input('ID penyewaan: ')) ?? 0;
  int index = penyewaan.indexWhere((p) => p['id'] == id);

  if (index == -1) {
    print('Penyewaan tidak ditemukan.');
    return;
  }

  int mobilId = penyewaan[index]['mobilId'];
  int indexMobil = mobil.indexWhere((m) => m['id'] == mobilId);

  mobil[indexMobil]['tersedia'] = true;
  penyewaan.removeAt(index);

  print('Mobil berhasil dikembalikan.');
}

void main() {
  while (true) {
    print('\n=== SISTEM RENTAL MOBIL ===');
    print('1. Lihat mobil');
    print('2. Tambah mobil');
    print('3. Sewa mobil');
    print('4. Lihat penyewaan');
    print('5. Pembayaran');
    print('6. Pengembalian mobil');
    print('0. Keluar');

    switch (input('Pilih menu: ')) {
      case '1':
        lihatMobil();
        break;
      case '2':
        tambahMobil();
        break;
      case '3':
        sewaMobil();
        break;
      case '4':
        lihatPenyewaan();
        break;
      case '5':
        pembayaran();
        break;
      case '6':
        kembalikanMobil();
        break;
      case '0':
        return;
      default:
        print('Pilihan tidak valid.');
    }
  }
}
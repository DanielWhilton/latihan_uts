import 'dart:io';

Map<String, Map<String, int>> barang = {
  'Keyboard': {'stok': 10, 'harga': 100000},
  'Mouse': {'stok': 15, 'harga': 50000},
  'Monitor': {'stok': 5, 'harga': 1500000},
};

List<Map<String, dynamic>> riwayat = [];

String input(String pesan) {
  stdout.write(pesan);
  return stdin.readLineSync() ?? '';
}

void lihatBarang() {
  barang.forEach((nama, data) {
    print('$nama | Stok: ${data['stok']} | Harga: Rp${data['harga']}');
  });
}

void tambahBarang() {
  String nama = input('Nama barang: ');

  if (nama.trim().isEmpty || barang.containsKey(nama)) {
    print('Nama kosong atau barang sudah tersedia.');
    return;
  }

  int harga = int.tryParse(input('Harga satuan: Rp')) ?? 0;

  if (harga <= 0) {
    print('Harga harus lebih dari 0.');
    return;
  }

  barang[nama] = {'stok': 0, 'harga': harga};
  print('Barang berhasil ditambahkan.');
}

void stokMasuk() {
  String nama = input('Nama barang: ');

  if (!barang.containsKey(nama)) {
    print('Barang tidak ditemukan.');
    return;
  }

  int jumlah = int.tryParse(input('Jumlah stok masuk: ')) ?? 0;

  if (jumlah <= 0) {
    print('Jumlah harus lebih dari 0.');
    return;
  }

  barang[nama]!['stok'] = barang[nama]!['stok']! + jumlah;

  riwayat.add({
    'barang': nama,
    'jumlah': jumlah,
    'jenis': 'Stok masuk',
  });

  print('Stok berhasil ditambahkan.');
}

void stokKeluar() {
  String nama = input('Nama barang: ');

  if (!barang.containsKey(nama)) {
    print('Barang tidak ditemukan.');
    return;
  }

  int jumlah = int.tryParse(input('Jumlah stok keluar: ')) ?? 0;
  int stok = barang[nama]!['stok']!;

  if (jumlah <= 0 || jumlah > stok) {
    print('Jumlah tidak valid atau stok tidak cukup.');
    return;
  }

  barang[nama]!['stok'] = stok - jumlah;

  riwayat.add({
    'barang': nama,
    'jumlah': jumlah,
    'jenis': 'Stok keluar',
  });

  print('Stok berhasil dikurangi.');
}

void ubahHarga() {
  String nama = input('Nama barang: ');

  if (!barang.containsKey(nama)) {
    print('Barang tidak ditemukan.');
    return;
  }

  int harga = int.tryParse(input('Harga baru: Rp')) ?? 0;

  if (harga <= 0) {
    print('Harga tidak valid.');
    return;
  }

  barang[nama]!['harga'] = harga;
  print('Harga berhasil diperbarui.');
}

void hapusBarang() {
  String nama = input('Nama barang: ');

  if (!barang.containsKey(nama)) {
    print('Barang tidak ditemukan.');
    return;
  }

  if (barang[nama]!['stok']! > 0) {
    print('Stok masih tersedia. Keluarkan stok terlebih dahulu.');
    return;
  }

  barang.remove(nama);
  print('Barang berhasil dihapus.');
}

void tampilkanRiwayat() {
  if (riwayat.isEmpty) {
    print('Belum ada riwayat.');
    return;
  }

  for (int i = 0; i < riwayat.length; i++) {
    var r = riwayat[i];
    print(
      '${i + 1}. ${r['jenis']} | ${r['barang']} | ${r['jumlah']} unit',
    );
  }
}

void laporan() {
  int totalStok = 0;
  int nilaiPersediaan = 0;

  barang.forEach((nama, data) {
    totalStok += data['stok']!;
    nilaiPersediaan += data['stok']! * data['harga']!;
  });

  print('\n=== LAPORAN GUDANG ===');
  print('Jenis barang: ${barang.length}');
  print('Total unit: $totalStok');
  print('Nilai persediaan: Rp$nilaiPersediaan');
}

void main() {
  while (true) {
    print('\n=== SISTEM INVENTARIS ===');
    print('1. Lihat barang');
    print('2. Tambah barang');
    print('3. Stok masuk');
    print('4. Stok keluar');
    print('5. Ubah harga');
    print('6. Hapus barang');
    print('7. Riwayat stok');
    print('8. Laporan');
    print('0. Keluar');

    switch (input('Pilih menu: ')) {
      case '1':
        lihatBarang();
        break;
      case '2':
        tambahBarang();
        break;
      case '3':
        stokMasuk();
        break;
      case '4':
        stokKeluar();
        break;
      case '5':
        ubahHarga();
        break;
      case '6':
        hapusBarang();
        break;
      case '7':
        tampilkanRiwayat();
        break;
      case '8':
        laporan();
        break;
      case '0':
        return;
      default:
        print('Pilihan tidak valid.');
    }
  }
}
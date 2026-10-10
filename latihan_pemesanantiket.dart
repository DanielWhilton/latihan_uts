import 'dart:io';

List<Map<String, dynamic>> acara = [
  {'id': 1, 'nama': 'Konser Musik', 'harga': 150000, 'stok': 50},
  {'id': 2, 'nama': 'Seminar Teknologi', 'harga': 75000, 'stok': 100},
  {'id': 3, 'nama': 'Pertunjukan Teater', 'harga': 100000, 'stok': 30},
];

List<Map<String, dynamic>> pesanan = [];
int nomorPesanan = 1;

String input(String pesan) {
  stdout.write(pesan);
  return stdin.readLineSync() ?? '';
}

void lihatAcara() {
  for (var a in acara) {
    print(
      "ID ${a['id']} | ${a['nama']} | "
      "Rp${a['harga']} | Sisa tiket: ${a['stok']}",
    );
  }
}

void tambahAcara() {
  String nama = input('Nama acara: ');
  int harga = int.tryParse(input('Harga tiket: Rp')) ?? 0;
  int stok = int.tryParse(input('Jumlah tiket: ')) ?? 0;

  if (nama.trim().isEmpty || harga <= 0 || stok <= 0) {
    print('Data acara tidak valid.');
    return;
  }

  int id = acara.map((a) => a['id'] as int).reduce(
        (a, b) => a > b ? a : b,
      ) + 1;

  acara.add({
    'id': id,
    'nama': nama,
    'harga': harga,
    'stok': stok,
  });

  print('Acara berhasil ditambahkan.');
}

void pesanTiket() {
  lihatAcara();

  int id = int.tryParse(input('ID acara: ')) ?? 0;
  int index = acara.indexWhere((a) => a['id'] == id);

  if (index == -1) {
    print('Acara tidak ditemukan.');
    return;
  }

  String nama = input('Nama pembeli: ');
  int jumlah = int.tryParse(input('Jumlah tiket: ')) ?? 0;

  if (nama.trim().isEmpty ||
      jumlah <= 0 ||
      jumlah > acara[index]['stok']) {
    print('Data tidak valid atau stok tiket tidak cukup.');
    return;
  }

  int total = acara[index]['harga'] * jumlah;

  pesanan.add({
    'id': nomorPesanan++,
    'acaraId': id,
    'nama': nama,
    'acara': acara[index]['nama'],
    'jumlah': jumlah,
    'total': total,
    'dibayar': false,
  });

  acara[index]['stok'] -= jumlah;

  print('Pesanan berhasil dibuat. Total: Rp$total');
}

void lihatPesanan() {
  if (pesanan.isEmpty) {
    print('Belum ada pesanan.');
    return;
  }

  for (var p in pesanan) {
    print(
      "ID ${p['id']} | ${p['nama']} | ${p['acara']} | "
      "${p['jumlah']} tiket | Rp${p['total']} | "
      "${p['dibayar'] ? 'Lunas' : 'Belum bayar'}",
    );
  }
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
  int bayar = int.tryParse(input('Total Rp$total. Bayar: Rp')) ?? 0;

  if (bayar < total) {
    print('Uang tidak cukup.');
    return;
  }

  pesanan[index]['dibayar'] = true;

  print('Pembayaran berhasil.');
  print('Kembalian: Rp${bayar - total}');
}

void batalkanPesanan() {
  int id = int.tryParse(input('ID pesanan: ')) ?? 0;
  int index = pesanan.indexWhere((p) => p['id'] == id);

  if (index == -1) {
    print('Pesanan tidak ditemukan.');
    return;
  }

  int acaraId = pesanan[index]['acaraId'];
  int jumlah = pesanan[index]['jumlah'];

  int indexAcara = acara.indexWhere((a) => a['id'] == acaraId);

  acara[indexAcara]['stok'] += jumlah;
  pesanan.removeAt(index);

  print('Pesanan dibatalkan. Stok tiket dikembalikan.');
}

void laporan() {
  int tiketTerjual = 0;

  for (var p in pesanan) {
    tiketTerjual += p['jumlah'] as int;
  }

  print('\n=== LAPORAN PENJUALAN TIKET ===');
  print('Jumlah acara: ${acara.length}');
  print('Jumlah pesanan aktif: ${pesanan.length}');
  print('Total tiket dipesan: $tiketTerjual');
}

void main() {
  while (true) {
    print('\n=== SISTEM PEMESANAN TIKET ===');
    print('1. Lihat acara');
    print('2. Tambah acara');
    print('3. Pesan tiket');
    print('4. Lihat pesanan');
    print('5. Pembayaran');
    print('6. Batalkan pesanan');
    print('7. Laporan');
    print('0. Keluar');

    switch (input('Pilih menu: ')) {
      case '1':
        lihatAcara();
        break;
      case '2':
        tambahAcara();
        break;
      case '3':
        pesanTiket();
        break;
      case '4':
        lihatPesanan();
        break;
      case '5':
        pembayaran();
        break;
      case '6':
        batalkanPesanan();
        break;
      case '7':
        laporan();
        break;
      case '0':
        return;
      default:
        print('Pilihan tidak valid.');
    }
  }
}